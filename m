Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275529AbRJBQTU>; Tue, 2 Oct 2001 12:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275576AbRJBQTK>; Tue, 2 Oct 2001 12:19:10 -0400
Received: from mons.uio.no ([129.240.130.14]:61662 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S275529AbRJBQS6>;
	Tue, 2 Oct 2001 12:18:58 -0400
To: Ian Grant <Ian.Grant@cl.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10 build failure - atomic_dec_and_lock export
In-Reply-To: <E15oRJg-00005z-00@wisbech.cl.cam.ac.uk>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 02 Oct 2001 18:19:21 +0200
In-Reply-To: Ian Grant's message of "Tue, 02 Oct 2001 16:18:40 +0100"
Message-ID: <shs669yvwty.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Ian Grant <Ian.Grant@cl.cam.ac.uk> writes:

     > Trond,
     > 2.4.10 won't link with CONFIG_SMP and i386 CPU selected. I
     >        believe the problem
     > lies in in the #ifndef atomic_dec_and_lock in
     > lib/dec_and_lock.c. As far as I can see this symbol is always
     > defined because it's exported.

This patch looks very redundant.

If you have CONFIG_SMP defined then atomic_dec_and_lock will never get
defined, and if CONFIG_HAVE_DEC_LOCK is not defined, then
dec_and_lock.c will never even get compiled. Even the config.h include
is superfluous as linux/module.h will include it.

I don't understand though: I have no problems compiling and linking
stock 2.4.10 with CONFIG_M386=y + CONFIG_SMP=y.
Are you sure that you didn't miss a 'make dep' after doing 'make
config'/'make oldconfig'?

Cheers,
   Trond

PS: sorry that you received this mail twice Ian. I didn't notice the
first time around that you had Cced the l-k list.
