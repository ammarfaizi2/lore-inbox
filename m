Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262808AbSKYKJM>; Mon, 25 Nov 2002 05:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262812AbSKYKJM>; Mon, 25 Nov 2002 05:09:12 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:13323 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S262808AbSKYKJL>; Mon, 25 Nov 2002 05:09:11 -0500
Message-Id: <200211251009.gAPA9np09476@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: David Zaffiro <davzaffiro@netscape.net>, willy@w.ods.org
Subject: Re: Compiling x86 with and without frame pointer
Date: Mon, 25 Nov 2002 13:00:27 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <19005.1037854033@kao2.melbourne.sgi.com> <20021121192045.GE3636@alpha.home.local> <3DE1E384.8000801@netscape.net>
In-Reply-To: <3DE1E384.8000801@netscape.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 November 2002 06:47, David Zaffiro wrote:
> I can understand why not omitting framepointers generates better
> compressible code, since every function will start with:
> 	push   %ebp
> 	mov    %esp,%ebp
> and end with:
> 	leave
> 	ret
>
> But it's harder to find a reason why -fomit-frame-pointer is better
> compressible that -momit-leaf-frame-pointer (but it's probably
> related to a lot of mov's with stackpointer involved), especially
> since "-momit-leaf-frame-pointer" makes a trade-off between both
> other options: it omits framepointers for leaf functions (callees
> that aren't callers as well) and it doesn't for branch-functions.

Which does not sound quite right for me. FP should be omitted
only if function contains less than half dozen stack references,
otherwise not. It does not matter whether it is a leaf function or not.

OTOH, AFAIK frame pointers make debugging easier, development kernels
are better to be compiled with fp in every func.
--
vda
