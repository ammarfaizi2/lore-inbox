Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267440AbSLSWUZ>; Thu, 19 Dec 2002 17:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267218AbSLSWT2>; Thu, 19 Dec 2002 17:19:28 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18697 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267630AbSLSWSg>; Thu, 19 Dec 2002 17:18:36 -0500
Message-ID: <3E02479E.8050801@transmeta.com>
Date: Thu, 19 Dec 2002 14:26:38 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021119
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Jamie Lokier <lk@tantalophile.demon.co.uk>, bart@etpmod.phys.tue.nl,
       davej@codemonkey.org.uk, terje.eggestad@scali.com, drepper@redhat.com,
       matti.aarnio@zmailer.org, hugh@veritas.com, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
References: <Pine.LNX.4.44.0212191412180.1629-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0212191412180.1629-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> Uli's suggested glibc approach is to just put the magis system call 
> address (which glibc gets from the AT_SYSINFO elf aux table entry) into 
> the per-thread TLS area, which is alway spointed to by %gs anyway.
>
> THIS WORKS WITH ALL DSO'S WITHOUT ANY GAMES, ANY MMAP'S, ANY RELINKING, OR
> ANY EXTRA WORK AT ALL!
> 
> The system call entry becomes a simple
> 
> 	call *%gs:constant-offset
> 
> Not mmap. No magic system calls. No relinking. Not _nothing_. One 
> instruction, that's it. 
> 

Unfortunately it means taking an indirect call cost for every invocation...

	-hpa

