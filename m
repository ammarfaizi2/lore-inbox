Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262996AbTCNMMM>; Fri, 14 Mar 2003 07:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262988AbTCNMMM>; Fri, 14 Mar 2003 07:12:12 -0500
Received: from divine.city.tvnet.hu ([195.38.100.154]:19831 "EHLO
	divine.city.tvnet.hu") by vger.kernel.org with ESMTP
	id <S262996AbTCNMML>; Fri, 14 Mar 2003 07:12:11 -0500
Date: Fri, 14 Mar 2003 13:16:12 +0100 (MET)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>, <linux-kernel@vger.kernel.org>
Subject: Backward disassembling (was: Re: 2.5.63 accesses below %esp)
In-Reply-To: <200303140718.h2E7IKu06478@Port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.30.0303141214180.25220-100000@divine.city.tvnet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 14 Mar 2003, Denis Vlasenko wrote:
> On 13 March 2003 23:04, Horst von Brand wrote:
> > Szakacsits Szabolcs <szaka@sienet.hu> said:
> > >
> > > Of course, it's a bad approach. You start earlier and stop at EIP.
> > > Repeat this for max(instruction length) different offsets and you
> > > will have the winner. Figure it out from the context after EIP.
> >
> > By hand, OK. Automatically, no.
>
> Why not? Disassemble from, say, EIP-16 and check whether you have
> an instruction starting exactly at EIP. If no, repeat from EIP-15,
> -14... You are guaranteed to succeed at EIP-0 ;)

Disassembling must be started "much" earlier. From your example one
could get the impression you want to get the instruction right before
EIP. It's not possible to go back this way. For example if you want to
disassemble 100 bytes before EIP you must start at EIP-100 and EIP-99
and ... and EIP-100-max_instruction_length+1. Then you have the right
one among them (well, 99.9% but let's don't be too pedantic).

You also can't stop the above max_instruction_length iteration when
the next instruction address matches EIP. You can have even
max_instruction_length matches. But from the additional info (code
after EIP, assembly "quality", available source where the crash
happend) you could choose the right one.

	Szaka

