Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283016AbRLMCll>; Wed, 12 Dec 2001 21:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283052AbRLMClV>; Wed, 12 Dec 2001 21:41:21 -0500
Received: from mail.myrio.com ([63.109.146.2]:34544 "HELO smtp1.myrio.com")
	by vger.kernel.org with SMTP id <S283016AbRLMClK>;
	Wed, 12 Dec 2001 21:41:10 -0500
Message-ID: <D52B19A7284D32459CF20D579C4B0C0211CB01@mail0.myrio.com>
From: Torrey Hoffman <torrey.hoffman@myrio.com>
To: "'Ryan Cumming'" <bodnar42@phalynx.dhs.org>,
        "David C. Hansen" <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: [RFC] Change locking in block_dev.c:do_open()
Date: Wed, 12 Dec 2001 18:40:24 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Cumming wrote:
 
> On December 12, 2001 16:39, David C. Hansen wrote:
> > Let's assume that the BKL is not held here, at least over the whole
> > thing.  First, what do we need to do to keep the module from getting
> > unloaded after the request_module() in get_blkfops()?

[...]
 
> Why not use a read-write semaphore? The sections that require 
> the module to 
> stay resident use a read lock, and module unloading aquires a 
> write lock. In 
> addition to containing the evil, evil BKL, you might actually 
> get a tangiable 
> scalability gain out of it. 

(*cough*)

Scalability of module loading certainly seems to be a problem. 
A quick test on my dual PIII system shows a shocking 13 seconds 
to load and unload the "input.o" module 400 times.

With some improvements in this area, massively parallel SMP systems 
could parallelize module loading, and achieve thousands of module 
load/unload operations per second (MLUOPS).

Wouldn't that be useful!  No?

(Sorry, I couldn't resist.  I'm sure there are good reasons to work on 
this, the scalability issue just sounded funny to me.)

Torrey
