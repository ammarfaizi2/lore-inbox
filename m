Return-Path: <linux-kernel-owner+w=401wt.eu-S932596AbWLMLEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932596AbWLMLEO (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 06:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932601AbWLMLEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 06:04:14 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53979 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932596AbWLMLEN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 06:04:13 -0500
Date: Wed, 13 Dec 2006 11:08:47 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Kasper Sandberg <lkml@metanurb.dk>, David Howells <dhowells@redhat.com>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, ak@muc.de, vojtech@suse.cz
Subject: Re: BUG? atleast >=2.6.19-rc5, x86 chroot on x86_64
Message-ID: <20061213110847.2b6b25db@localhost.localdomain>
In-Reply-To: <200612130253_MC3-1-D4E3-471@compuserve.com>
References: <200612130253_MC3-1-D4E3-471@compuserve.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2006 02:50:01 -0500
Chuck Ebbert <76306.1226@compuserve.com> wrote:

> In-Reply-To: <1165984783.23819.7.camel@localhost>
> 
> On Wed, 13 Dec 2006 05:39:43 +0100, Kasper Sandberg wrote:
> 
> > do you think it may be a bug in the kernel? the stuff with wine that
> > gets thrown in the kernel messages?
> 
> Let's just say the behavior has changed.  It now returns
> -EINVAL instead of -ENOTTY when the msdos IOCTLs fail.

For an unknown ioctl the correct return is -ENOTTY. For an invalid ioctl
(known but wrong parameters) it may be -EINVAL.

> Anyway, here is a much simpler patch that restores the previous
> behavior (but leaves the message.)  However if you aren't having
> any problems now other than the messages maybe there's no real
> problem after all?

As far as I can see from a quick review the code should return -ENOTTY
in this situation not -EINVAL, for all unhandled ioctls.

Alan
