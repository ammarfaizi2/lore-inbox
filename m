Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269073AbUI2WGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269073AbUI2WGl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 18:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269096AbUI2WGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 18:06:33 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:22155 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269083AbUI2WGL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 18:06:11 -0400
Subject: Re: New DRM driver model - gets rid of DRM() macros!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Discuss issues related to the xorg tree <xorg@freedesktop.org>
Cc: Jon Smirl <jonsmirl@gmail.com>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040929235238.46c55c58.felix@trabant>
References: <9e4733910409280854651581e2@mail.gmail.com>
	 <20040929235238.46c55c58.felix@trabant>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Message-Id: <1096491771.16768.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 29 Sep 2004 22:02:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-09-29 at 22:52, Felix Kühling wrote:
> Module                  Size  Used by
> savage                  3520  0
> drm                    62500  3 savage
> 
> Is it normal that the savage module looks unused?

looks like a bug. If the drm layer provides the file_operations for
the device node then the locking done automatically locks the wrong
module. Thats easy to fix with try_module_get() and module_put()

