Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262334AbSKCTXq>; Sun, 3 Nov 2002 14:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262335AbSKCTXq>; Sun, 3 Nov 2002 14:23:46 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:8976 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S262334AbSKCTXp>; Sun, 3 Nov 2002 14:23:45 -0500
Message-Id: <200211031925.gA3JPHp29128@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Jussi Laako <jussi.laako@kolumbus.fi>
Subject: Re: Some functions are not inlined by gcc 3.2, resulting code is ugly
Date: Sun, 3 Nov 2002 22:17:13 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <200211031125.gA3BP4p27812@Port.imtp.ilyichevsk.odessa.ua> <1036340272.26281.5.camel@vaarlahti.uworld>
In-Reply-To: <1036340272.26281.5.camel@vaarlahti.uworld>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 November 2002 14:17, Jussi Laako wrote:
> On Sun, 2002-11-03 at 18:17, Denis Vlasenko wrote:
>
> Jump target 17e0 is aligned (with nops):
> >     17dd:	88 02                	mov    %al,(%edx)
> >     17df:	90                   	nop
> >     17e0:	89 d0                	mov    %edx,%eax
> >     17e2:	5a                   	pop    %edx
> >
> >     17ec:	eb f2                	jmp    17e0
> > <__constant_memcpy+0x20>
> >
> >     17fa:	eb e4                	jmp    17e0
> > <__constant_memcpy+0x20>
> >
> >     1800:	eb de                	jmp    17e0
> > <__constant_memcpy+0x20>
> >
> >     187c:	e9 5f ff ff ff       	jmp    17e0
> > <__constant_memcpy+0x20> 1881:	eb 0d                	jmp    1890
> > <__constant_memcpy+0xd0> 1883:	90                   	nop
>
> ...
>
> >     188f:	90                   	nop
> >     1890:	c1 e9 02             	shr    $0x2,%ecx
> >     1893:	89 d7                	mov    %edx,%edi
>
> And also jump target 1890 is aligned.
>
>
> I think the penalty of few NOPs is smaller than result of jump to
> unaligned address. This is especially true with P4 architecture.

Alignment does not eliminate jump. It only moves jump target to 16 byte
boundary. This _probably_ makes execution slightly faster but on average
it costs you 7,5 bytes. This price is too high when you take into account
L1 instruction cache wastage and current bus/core clock ratios.
--
vda
