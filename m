Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbVGLGnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVGLGnb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 02:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbVGLGnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 02:43:31 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:974 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261187AbVGLGnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 02:43:22 -0400
Subject: Re: [PATCH] [3/48] Suspend2 2.1.9.8 for 2.6.12:
	301-proc-acpi-sleep-activate-hook.patch
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Christoph Hellwig <hch@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050710230347.GB513@infradead.org>
References: <11206164393426@foobar.com> <11206164393081@foobar.com>
	 <20050710230347.GB513@infradead.org>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1121150703.13869.27.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 12 Jul 2005 16:45:04 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2005-07-11 at 09:03, Christoph Hellwig wrote:
> Please add an explanation why this is nessecary.  Big NACK for the patch as-is, but
> to find a proper solution we need to know what you're actually doing.

When the user has an initrd or initramfs, they're supposed to include

echo > /proc/software_suspend/do_resume

at the point in their initrd where drivers needed for accessing the
image, encryption keys and so on have been set up, but the root fs has
not yet been mounted. If they don't do that, we should scream loudly,
because mounting the root fs (even read only) will replay the journal,
making the image not match what is on disk. This in turn can and
probably will result in hard disk corruption if they echo to do_resume
from say /etc/rc.d/rc.sysinit.

In addition, the try_to_freeze call is needed because, having loaded an
image, we freeze kernel threads before doing the atomic restore.

Regards,

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

