Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316579AbSEPFPJ>; Thu, 16 May 2002 01:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316583AbSEPFPI>; Thu, 16 May 2002 01:15:08 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:26119 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S316579AbSEPFPG>;
	Thu, 16 May 2002 01:15:06 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200205160515.g4G5F0I29175@oboe.it.uc3m.es>
Subject: Re: Kernel deadlock using nbd over acenic driver
In-Reply-To: <200205151943.UAA22346@gw.chygwyn.com> from Steven Whitehouse at
 "May 15, 2002 08:43:49 pm"
To: Steve Whitehouse <Steve@ChyGwyn.com>
Date: Thu, 16 May 2002 07:15:00 +0200 (MET DST)
Cc: alan@lxorguk.ukuu.org.uk, chen_xiangping@emc.com,
        linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Steven Whitehouse wrote:"
> So something to try is this, in nbd_send_req() add the lines:
> 
> 	if (current->flags & PF_MEMALLOC == 0) {
> 		current->flags |= PF_MEMALLOC;
> 		we_set_memalloc = 1;
> 	}
> 
> before the first nbd_xmit() call and
> 
> 	if (we_set_memalloc)
> 		current->flags &= ~PF_MEMALLOC;
> 
> at the end just before the return; rememebring to declare the variable:

I don't see any reason to introduce a second flag to say when a flag
has been set .. Initial reports are that symptoms go away when

    current->flags |= PF_MEMALLOC;

is set in the process about to do networking (and unset afterwards).

There will be more news later today. I believe that this will remove
deadlock against VM for tcp buffers, but I don't believe it will 
stop deadlocks against "nothing", when we simply are out of buffers.
The only thing that can do that is reserved memory for the socket.
Any pointers?

Peter
