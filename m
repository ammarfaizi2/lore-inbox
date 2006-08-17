Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbWHQMfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbWHQMfo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 08:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbWHQMfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 08:35:44 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:54243 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932351AbWHQMfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 08:35:43 -0400
Subject: Re: PATCH/FIX for drivers/cdrom/cdrom.c
From: Arjan van de Ven <arjan@infradead.org>
To: 7eggert@gmx.de
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, Dirk <noisyb@gmx.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <E1GDgyZ-0000jV-MV@be1.lrz>
References: <6Kxns-7AV-13@gated-at.bofh.it> <6Kytd-1g2-31@gated-at.bofh.it>
	 <6KyCQ-1w7-25@gated-at.bofh.it>  <E1GDgyZ-0000jV-MV@be1.lrz>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 17 Aug 2006 14:35:37 +0200
Message-Id: <1155818138.4494.56.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 14:27 +0200, Bodo Eggert wrote:
> Arjan van de Ven <arjan@infradead.org> wrote:
> > On Wed, 2006-08-16 at 14:37 -0400, Lennart Sorensen wrote:
> 
> >> Perhaps the real problem is that some @#$@#$ user space task is
> >> constantly trying to mount the disc while something else is trying to
> >> write to it.
> >> 
> >> gnome and kde both seem very eager to implement such things.  perhaps
> >> there should be a way to prevent any access by such processes while
> >> writing to the disc.
> > 
> > there is. O_EXCL works for this.
> > Any sane desktop app and cd burning app use O_EXCL already for this
> > purpose...
> 
> This was discussed to death:
> 
> HAL using O_EXCL will randomly prevent burning/mounting/etc by causing a
> race condition, so it can't do that.

all burning apps will retry a few times if they get "busy"....

>  HAL not using O_EXCL will OTOH succeed
> in opening despite of O_EXCL used by the burning process and thereby
> prevent burning by opening a busy device. The proposed solution was
> introducing O_NONE or O_HARMLESS to prevent side-effects from opening
> the device.

doesn't help, since hal doesn't just open it, but also issues an ioctl
that then goes to the device, and THAT is causing the damage. Not the
open itself.

> This will, however, not prevent other users from maliciously destroying the
> CD by not using O_EXCL.

if the user wants to destroy his own burning cd... then why is it the
kernels job to stop him?

> Maybe it's possible to cache the result and thereby prevent repeated
> opening from disturbing the burning process.

oh I really want to have this ioctl cached, but more so that the kernel
can enforce a reasonable polling interval ;)

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

