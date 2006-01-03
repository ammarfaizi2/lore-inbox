Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932418AbWACP6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbWACP6c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 10:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWACP6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 10:58:32 -0500
Received: from webmail-outgoing2.us4.outblaze.com ([205.158.62.67]:51420 "EHLO
	webmail-outgoing.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S932418AbWACP6b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 10:58:31 -0500
X-OB-Received: from unknown (205.158.62.16)
  by wfilter.us4.outblaze.com; 3 Jan 2006 15:58:29 -0000
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
From: "Kai Geek" <kaigeek@linuxmail.org>
To: "Linus Torvalds" <torvalds@osdl.org>, "Ingo Molnar" <mingo@elte.hu>
Cc: "Nick Piggin" <nickpiggin@yahoo.com.au>,
       lkml <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Nicolas Pitre" <nico@cam.org>, "Jes Sorensen" <jes@trained-monkey.org>,
       "Al Viro" <viro@ftp.linux.org.uk>, "Oleg Nesterov" <oleg@tv-sign.ru>,
       "David Howells" <dhowells@redhat.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Christoph Hellwig" <hch@infradead.org>, "Andi Kleen" <ak@suse.de>,
       "Russell King" <rmk+lkml@arm.linux.org.uk>
Date: Tue, 03 Jan 2006 23:58:29 +0800
Subject: Re: [patch 08/19] mutex subsystem, core
X-Originating-Ip: 194.125.232.2
X-Originating-Server: ws5-10.us4.outblaze.com
Message-Id: <20060103155829.998327B386@ws5-10.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
can we run the semaphores from the console if we do it with mutex instead of interrupt context? in this case will the mutex codes be interrupted?
base a image run pid kernel/printk.c?
Best Regards,

----- Original Message -----
From: "Linus Torvalds" <torvalds@osdl.org>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: [patch 08/19] mutex subsystem, core
Date: 	Tue, 3 Jan 2006 07:38:41 -0800 (PST)

> 
> 
> 
> On Tue, 3 Jan 2006, Ingo Molnar wrote:
> > > > Is this an interrupt deadlock, or do you not allow interrupt 
> > contexts > to even trylock a mutex?
> >
> > correct, no irq contexts are allowed. This is also checked for if 
> > CONFIG_DEBUG_MUTEXES is enabled.
> 
> Note that semaphores are definitely used from interrupt context, and as
> such you can't replace them with mutexes if you do this.
> 
> The prime example is the console semaphore. See kernel/printk.c, look for
> "down_trylock()", and realize that they are all about interrupts.
> 
> 			Linus
> -

+-+-+-+ BEGIN PGP SIGNATURE +-+-+-+
Version: GnuPG v1.4.2 (GNU/Linux)
   .-.      .-.    _              
   : :      : :   :_;             
 .-' : .--. : `-. .-. .--.  ,-.,-.
' .; :' '_.'' .; :: :' .; ; : ,. :
`.__.'`.__.'`.__.':_;`.__,_;:_;:_;

Kai "Ozgur" Geek
Network Engineer
PGP ID: B1B63B6E
+-+-+-+ END PGP SIGNATURE +-+-+-+

-- 
_______________________________________________
Check out the latest SMS services @ http://www.linuxmail.org
This allows you to send and receive SMS through your mailbox.

Powered by Outblaze
