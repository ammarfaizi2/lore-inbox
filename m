Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262078AbTCQHca>; Mon, 17 Mar 2003 02:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262333AbTCQHca>; Mon, 17 Mar 2003 02:32:30 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:8967 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S262078AbTCQHc2>; Mon, 17 Mar 2003 02:32:28 -0500
Message-Id: <200303170700.h2H70Qu18002@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63))
Date: Mon, 17 Mar 2003 08:56:54 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200303151834.h2FIYAXh005499@eeyore.valparaiso.cl>
In-Reply-To: <200303151834.h2FIYAXh005499@eeyore.valparaiso.cl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 March 2003 20:34, Horst von Brand wrote:
> Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> said:
> > On 13 March 2003 23:04, Horst von Brand wrote:
> > > Szakacsits Szabolcs <szaka@sienet.hu> said:
> > > > On Wed, 12 Mar 2003, Horst von Brand wrote:
> > > > > It is _hard_ to do with variable length instructions (CISC,
> > > > > remember?), the code is designed to be easily decoded
> > > > > forward, noone executes code going backwards.
> > > >
> > > > Of course, it's a bad approach. You start earlier and stop at
> > > > EIP. Repeat this for max(instruction length) different offsets
> > > > and you will have the winner. Figure it out from the context
> > > > after EIP.
> > >
> > > By hand, OK. Automatically, no.
> >
> > Why not? Disassemble from, say, EIP-16 and check whether you
> > have an instruction starting exactly at EIP. If no, repeat from
> > EIP-15, -14... You are guaranteed to succeed at EIP-0  ;)
>
> But your previous success (if any) doesn't mean anything, and might
> even screw up the decoding after EIP

How come? If I started to decode at EIP-n and got a sequence of
instructions at EIP-n, EIP-n+k1, EIP-n+k2, EIP-n+k3..., EIP,
instructions prior to EIP can be wrong. Instruction at EIP
and all subsequent ones ought to be right.

> (if accidentally an address
> looks like an instruction, say). This is too much work (to get right)
> for something of purely informational value (if that much), generated
> by a suspect kernel (an Oops is when something went wrong...).
--
vda
