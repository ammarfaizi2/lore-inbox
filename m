Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261487AbULTMVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbULTMVo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 07:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbULTMVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 07:21:44 -0500
Received: from mx1.redhat.com ([66.187.233.31]:2501 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261487AbULTMVn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 07:21:43 -0500
Date: Mon, 20 Dec 2004 04:21:34 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       <laforge@gnumonks.org>, greg@kroah.com
Subject: Re: [linux-usb-devel] Re: My vision of usbmon
Message-ID: <20041220042134.7893e68f@lembas.zaitcev.lan>
In-Reply-To: <200412201255.59120.oliver@neukum.org>
References: <20041219230454.5b7f83e3@lembas.zaitcev.lan>
	<200412201255.59120.oliver@neukum.org>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2004 12:55:59 +0100, Oliver Neukum <oliver@neukum.org> wrote:

> Am Montag, 20. Dezember 2004 08:04 schrieb Pete Zaitcev:
> > +       add_wait_queue(&rp->wait, &waita);
> > +       while ((ep = mon_text_fetch(rp, mbus)) == NULL) {
> > +               if (file->f_flags & O_NONBLOCK) {
> > +                       remove_wait_queue(&rp->wait, &waita);
> > +                       return -EWOULDBLOCK;    /* Same as EAGAIN in Linux */
> > +               }
> > +               /*
> > +                * We do not count nwaiters, because ->release is supposed
> > +                * to be called when all openers are gone only.
> > +                */
> > +               set_current_state(TASK_INTERRUPTIBLE);
> 
> Here you can lose a wakeup.
> 
> > +               schedule();

Thanks, Oliver. Indeed, it's a bug.

-- Pete
