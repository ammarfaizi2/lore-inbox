Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273666AbRIQTrd>; Mon, 17 Sep 2001 15:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273664AbRIQTrX>; Mon, 17 Sep 2001 15:47:23 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:48134 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S273663AbRIQTrO>; Mon, 17 Sep 2001 15:47:14 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [Q] Implementation of spin_lock on i386: why "rep;nop" ?
Date: 17 Sep 2001 12:47:27 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9o5k0f$25d$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.31.0109171725140.26090-100000@sisley.ri.silicomp.fr> <E15j2BM-0007WU-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <E15j2BM-0007WU-00@the-village.bc.nu>
By author:    Alan Cox <alan@lxorguk.ukuu.org.uk>
In newsgroup: linux.dev.kernel
>
> > The "rep;nop" line looks dubious, since the IA-32 programmer's manual from
> > Intel (year 2001) mentions that the behaviour of REP is undefined when it
> > is not used with string opcodes. BTW, according to the same manual, REP is
> > supposed to modify ecx, but it looks like is is not the case here... which
> > is fortunate, since ecx is never saved. :-)
> 
> rep nop is a pentium IV operation. Its retroactively after testing defined
> to be portable and ok. 
> 

Now, the example brought up was assembly, but in general I really
think we should have a processor-independent wait_loop(); inline.
Right now we have a rep_nop(); inline which only works on x86 (and
presumably x86-64).

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
