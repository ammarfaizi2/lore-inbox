Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282293AbRKWXyp>; Fri, 23 Nov 2001 18:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282297AbRKWXyg>; Fri, 23 Nov 2001 18:54:36 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45317 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S282289AbRKWXya> convert rfc822-to-8bit; Fri, 23 Nov 2001 18:54:30 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: copy to suer space
Date: 23 Nov 2001 15:53:54 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9tmnii$8q4$1@cesium.transmeta.com>
In-Reply-To: <5.1.0.14.2.20011120165440.00a745b0@pop.cus.cam.ac.uk> <200111211057.fALAvi288566@criticalsoftware.com> <m2ofltljcl.fsf@trasno.mitica> <200111231440.fANEeh213167@criticalsoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id fANNrwD03196
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200111231440.fANEeh213167@criticalsoftware.com>
By author:    =?iso-8859-1?q?Lu=EDs=20Henriques?= 
	<lhenriques@criticalsoftware.com>
In newsgroup: linux.dev.kernel
> 
> When I read the timestamp («rdtsc»), a value is returned to edx:eax. This 
> code works just fine when I put it in the process stack. The problem is when 
> I want to compare %edx instead of %eax, that is:
> 
> 	rdtsc
> 	movl %edx, %ecx
> 	addl $0x1, %ecx
>    loop:
> 	rdtsc
> 	cmp %ecx, %edx
> 	jb loop
> 
> This is supposed to take much more time than the other loop. When I write 
> this code to the stack of my process, a segmentation fault occurs after some 
> time. Why? I'm not changing the stack at any moment! (By the way, the stack 
> pointer is pointing to the end of my code...)
> 

Did you remember to restore all the registers, including %eax and
%eflags, before you return?

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
