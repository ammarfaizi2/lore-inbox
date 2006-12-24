Return-Path: <linux-kernel-owner+w=401wt.eu-S1753052AbWLXXoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753052AbWLXXoL (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 18:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753176AbWLXXoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 18:44:11 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44977 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753052AbWLXXoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 18:44:10 -0500
Date: Mon, 25 Dec 2006 00:43:57 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>,
       maxk@qualcomm.com, bluez-devel@lists.sourceforge.net
Subject: Re: bluetooth memory corruption (was Re: ext3-related crash in 2.6.20-rc1)
Message-ID: <20061224234357.GA1817@elf.ucw.cz>
References: <20061223234305.GA1809@elf.ucw.cz> <20061223235501.GA1740@elf.ucw.cz> <1166971163.15485.21.camel@violet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1166971163.15485.21.camel@violet>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I got this nasty oops while playing with debugger. Not sure if that is
> > > related; it also might be something with bluetooth; I already know it
> > > corrupts memory during suspend, perhaps it corrupts memory in some
> > > error path?
> > 
> > Okay, I spoke too soon. bluetooth & suspend memory corruption was
> > _way_ harder to reproduce than expected. Took me 5-or-so-suspend
> > cycles... so it is probably unrelated to the previous crash.
> 
> can you try to reproduce this with 2.6.20-rc2 as well.

(reproduced in another mail).

        _urb_queue_tail(__pending_q(husb, _urb->type), _urb);
        err = usb_submit_urb(urb, GFP_ATOMIC);
        if (err) {
                BT_ERR("%s tx submit failed urb %p type %d err %d",
                                husb->hdev->name, urb, _urb->type, err);
                _urb_unlink(_urb);

                ~~~~~~~~~~~~~~~~~~
	 	 Do we need to remove urb from pending_q here?

                _urb_queue_tail(__completed_q(husb, _urb->type), _urb);
        } else
                atomic_inc(__pending_tx(husb, _urb->type));

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
