Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266682AbTGKUWl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 16:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266683AbTGKUWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 16:22:41 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45842 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S266682AbTGKUWB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 16:22:01 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Style question: Should one check for NULL pointers?
Date: 11 Jul 2003 13:36:25 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <ben749$mkp$1@cesium.transmeta.com>
References: <Pine.LNX.4.44L0.0307101606060.22398-100000@netrider.rowland.org> <200307111932.h6BJWMr5004606@eeyore.valparaiso.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id h6BKaRF22744
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200307111932.h6BJWMr5004606@eeyore.valparaiso.cl>
By author:    Horst von Brand <vonbrand@inf.utfsm.cl>
In newsgroup: linux.dev.kernel
>
> Alan Stern <stern@rowland.harvard.edu> said:
> 
> [...]
> 
> > Suppose everything is working correctly and the pointer never is NULL.  
> > Then it really doesn't matter whether you check or not;  the loss in code
> > speed and size is completely negligible (except maybe deep in some inner
> > loop).  But there is a loss in code clarity; when I see a check like that
> > it makes me think, "What's that doing there?  Can that pointer ever be
> > NULL, or is someone just being paranoid?"  Distractions of that sort don't
> > help when trying to read code.
> 
> My personal paranoia when reading code goes the other way: How can I be
> sure it won´t ever be NULL?  Maybe it can't be now (and to find that out an
> hour grepping around goes by), but the very next patch introduces the
> possibility.  Better have the function do an extra check, or make sure
> somehow the assumption won't _ever_ be violated. But that is a large (huge,
> even) cost, so...
> 

And you just shot yourself in the foot, majorly, because you tested
for NULLness and then took the action you anticipated might have been
appropriate, which really it wasn't, and you allowed a kernel with
now-corrupt data structures to continue to run.

This is bad.  This is extrememly bad.  And your "forward thinking"
*caused* it.

A null pointer dereference in the kernel is fatal for a reason.  It
indicates that there are interfaces that aren't consistent, and your
data structures are now completely unreliable.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
