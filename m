Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935314AbWKZKTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935314AbWKZKTX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 05:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935316AbWKZKTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 05:19:22 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:24794 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S935314AbWKZKTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 05:19:22 -0500
Subject: Re: [2.6 patch] net/sctp/socket.c: add missing
	sctp_spin_unlock_irqrestore
From: Arjan van de Ven <arjan@infradead.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Eugene Teo <eteo@redhat.com>, lksctp-developers@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061126101254.GW3078@ftp.linux.org.uk>
References: <456965D5.1000302@redhat.com>
	 <20061126101254.GW3078@ftp.linux.org.uk>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 26 Nov 2006 11:19:12 +0100
Message-Id: <1164536353.3147.70.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-11-26 at 10:12 +0000, Al Viro wrote:
> On Sun, Nov 26, 2006 at 06:00:53PM +0800, Eugene Teo wrote:
> > This patch adds a missing sctp_spin_unlock_irqrestore when returning
> > from "if(space_left<addrlen)" condition.
> >                 if (copy_to_user(*to, &temp, addrlen)) {
> > -                       sctp_spin_unlock_irqrestore(&sctp_local_addr_lock,
> > -                                                   flags);
> > -                       return -EFAULT;
> > +                       err = -EFAULT;
> > +                       goto unlock;
> 
> > +       sctp_spin_unlock_irqrestore(&sctp_local_addr_lock, flags);
> > +       return err;
> >  }
> 
> You do realize that it's obviously still badly broken, don't you?
> copy_to_user() under a spinlock is a recipe for deadlock, especially
> if you've got interrupts disabled...
> 
> I have a beginning of locking fixes in that shitpile, but it's incomplete
> and bloody painful ;-/
> -

do your patches also remove the empty abstraction of the sctp_ prefix
around the spinlock use in sctp ?


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

