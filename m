Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313083AbSEYAWC>; Fri, 24 May 2002 20:22:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313087AbSEYAWB>; Fri, 24 May 2002 20:22:01 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38418 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313083AbSEYAWA>; Fri, 24 May 2002 20:22:00 -0400
Subject: Re: [RFC] POSIX personality
To: jw@pegasys.ws (jw schultz)
Date: Sat, 25 May 2002 01:38:37 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds), davidsen@tmr.com (Bill Davidsen),
        dmccr@us.ibm.com (Dave McCracken),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <20020524170207.C9600@pegasys.ws> from "jw schultz" at May 24, 2002 05:02:07 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17BPZt-0007jK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It seems to me that the biggest issue here is maintaining
> POSIX behavior without having to modify application source
> every time the flag set changes.

I don't think that is a big problem. Think about how it evolves over time


App calls pthread_foo   libpthreads/ngpt does all the work by emulation

	Add CLONE_somefoo

App calls pthread_foo	libpthreads/ngpt does all the work by emulation
			and doesnt set the flag

	New libpthreads

App calls pthread_foo	libpthreads/ngpt uses the kernel assists




The behaviour is good - it means that the new kernel/old library setup won't
break the emulation gunge by suddenely providing precise semantics itself
