Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262369AbSKCUAq>; Sun, 3 Nov 2002 15:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262371AbSKCUAq>; Sun, 3 Nov 2002 15:00:46 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:48526 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262369AbSKCUAp>; Sun, 3 Nov 2002 15:00:45 -0500
Subject: Re: Some functions are not inlined by gcc 3.2, resulting code is
	ugly
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: Jakub Jelinek <jakub@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@suse.de>
In-Reply-To: <200211031928.gA3JSSp29136@Port.imtp.ilyichevsk.odessa.ua>
References: <200211031125.gA3BP4p27812@Port.imtp.ilyichevsk.odessa.ua>
	<20021103103710.D10988@devserv.devel.redhat.com>
	<1036340502.29642.36.camel@irongate.swansea.linux.org.uk> 
	<200211031928.gA3JSSp29136@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Nov 2002 20:28:32 +0000
Message-Id: <1036355312.30629.25.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-11-04 at 00:20, Denis Vlasenko wrote:
> __constant_c_and_count_memset *has to* be inlined.
> There is large switch statement which meant to be optimized out.
> It does optimize out *only if* count is compile-time constant.

gcc already allows you to check for constants that means you can
generate

	(is a constant ? inline: noninline)(to, from, len)

and I would hope gcc does the right thing. Similarly your switch will 
be optimised out so the default case for the constant one can be the
invocation of uninlined code and it should optimise back to the straight
expected call.

Alan

