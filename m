Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316951AbSF0TlU>; Thu, 27 Jun 2002 15:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316953AbSF0TlT>; Thu, 27 Jun 2002 15:41:19 -0400
Received: from aboukir-101-1-23-willy.adsl.nerim.net ([62.212.114.60]:40722
	"EHLO www.home.local") by vger.kernel.org with ESMTP
	id <S316951AbSF0TlT>; Thu, 27 Jun 2002 15:41:19 -0400
From: Willy Tarreau <willy@w.ods.org>
Message-Id: <200206271942.g5RJgv6F008956@alpha.home.local>
Subject: Re: /proc/cpuinfo incomplete for AMD 386DX 40?
To: zwane@linux.realnet.co.sz (Zwane Mwaikambo)
Date: Thu, 27 Jun 2002 21:42:57 +0200 (CEST)
Cc: johnnyo@mindspring.com (John O'Donnell), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0206271521150.10717-100000@netfinity.realnet.co.sz> from "Zwane Mwaikambo" at Jun 27, 2002 03:26:50 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!


> > bogomips        : 5.17
> bogomips        : 7.93

I remember having had this last rate on my Am386DX/40 too, when the cache
was enabled on the mainboard. If I disabled it, it dropped to about 5.2,
which might explain differences noticed here. So check if you have some
cache on your motherboard, and if it's enabled in your bios setup.  And
don't trust these boards with fake plastic chips labelled "write back"
with no other vendor name, and for which the bios reported "Write Back
cache ON" instead of a size.

> > Is there any harm in Linux not identifying stuff like the manufacturer.
> > I dont know if the i386 supports any extensions that would show up in
> > the flags field.  Think the bogomips is right?!?
> 
> The flags field is stuff deduced from doing cpuid calls, so nothing there. 
> The vendor might be a little difficult and might require depending on 
> quirks of specific cpu models (i'm not 100% sure) therefore it would be a 
> waste of memory to do.

CPUID was introduced in latest Intel's 486, when there was a lot of relabelling
of cheaper AMDs to Intel equivalents with higher frequencies (eg: Amd486-50 ->
i486-66). AMD took the step too at the time they were sending their new
DX4/write-back core, IIRC. But I've never seen a 386 with a CPUID instruction,
and trust me, I've searched for many ways to differenciate Intel's from AMD's.
Even the register values after reset were the same as intel's. And they were
very hard to catch because you had to reset the CPU and bypass the bios to
get the values, then restore all its context. The only noticeable difference
I found was that they didn't prefetch instructions the same way, and when you
disabled the external cache, you could notice a different pipeline stall depending
on instruction alignment.

So no reliable means to do what you want without opening the case, IMHO.

Cheers,
Willy

