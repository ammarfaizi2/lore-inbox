Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277358AbRJOJkW>; Mon, 15 Oct 2001 05:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277359AbRJOJkD>; Mon, 15 Oct 2001 05:40:03 -0400
Received: from medusa.sparta.lu.se ([194.47.250.193]:25186 "EHLO
	medusa.sparta.lu.se") by vger.kernel.org with ESMTP
	id <S277358AbRJOJju>; Mon, 15 Oct 2001 05:39:50 -0400
Date: Mon, 15 Oct 2001 10:29:39 +0200 (MET DST)
From: Bjorn Wesen <bjorn@sparta.lu.se>
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: crc32 cleanups 
In-Reply-To: <16790.1002968731@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.3.96.1011015101708.22179A-100000@medusa.sparta.lu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Oct 2001, Keith Owens wrote:
> Does not work if all the code that uses crc32 is in a module.  No
> references from the main kernel so crc32 is not included by the linker.

So make the CRC32 code a module itself ?

> ???!  __initcall entries are executed in the order that they are linked
> into the kernel.  The linkage order is controlled by the order that
> Makefiles are processed during kbuild and by line order within each
> Makefile.  There is definitely a priority order for __initcall code.

That is in practice an unuseable "priority" (I'd like to consider that a
highly stochastic variable :) 

Not to mention that as an individual sub-project maintainer you can't go
around changing higher level makefiles all the time just to get your
particular initcall chain in order (again, in practice).

You could _conceivably_ build an initcall dependency system by adding some
"initcall_requires" macros which put the dependant other calls into
another linker table, which the kernel would resolve at boot. 

/BW

