Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317341AbSHGKTb>; Wed, 7 Aug 2002 06:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317592AbSHGKTa>; Wed, 7 Aug 2002 06:19:30 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:64760 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317341AbSHGKTa>; Wed, 7 Aug 2002 06:19:30 -0400
Subject: Re: [PATCH] pdc20265 problem.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: nick.orlov@mail.ru, davidsen@tmr.com, linux-kernel@vger.kernel.org
In-Reply-To: <200208070754.AAA08086@adam.yggdrasil.com>
References: <200208070754.AAA08086@adam.yggdrasil.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 07 Aug 2002 12:41:32 +0100
Message-Id: <1028720492.18130.251.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-07 at 08:54, Adam J. Richter wrote:
> 	Linux users in the "I'm not a sysadmin" crowd (?) probably
> don't care about the scan order of the pdc20265 IDE controller,
> but people in the "I'm a sysadmin, not a programmer" crowd
> may have legitimiate reasons to.

The non sysadmin people care that is has not change, and generally
prefer that its the same ordering as windows seems to use. Once you go
to modular IDE it gets trickier. Certainly if you load modules the usual
bets are off (as with scsi)

It is possible to take a serial like approach and we could say

	if(pci && southbridge_has_ide_device())
		reserve_ide0();

That would ensure the southbridge IDE stayed in one place. Another
alternative is to enumerate all the IDE devices by class (we can do that
nice and easy, with a little tweak for the fasttrak stuff) then hand
them off according to the enumeration position. That would preserve the
old semantics nicely for pci IDE. (Plug in ISA IDE is pretty rare and
since we can't probe those its kind of hard to do anything much about
it).

Andre is currently dealing with some of this in the main IDE code

