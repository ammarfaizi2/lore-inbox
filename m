Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319334AbSHVM0A>; Thu, 22 Aug 2002 08:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319336AbSHVM0A>; Thu, 22 Aug 2002 08:26:00 -0400
Received: from [217.167.51.129] ([217.167.51.129]:5059 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S319334AbSHVMZ7>;
	Thu, 22 Aug 2002 08:25:59 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
Cc: Yoann Vandoorselaere <yoann@prelude-ids.org>,
       <cpufreq@lists.arm.linux.org.uk>, <cpufreq@www.linux.org.uk>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]: fix 32bits integer overflow in loops_per_jiffy
 calculation
Date: Thu, 22 Aug 2002 16:31:15 +0200
Message-Id: <20020822143115.15323@192.168.4.1>
In-Reply-To: <3D64D51C.9040603@iram.es>
References: <3D64D51C.9040603@iram.es>
X-Mailer: CTM PowerMail 3.1.2 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Well, first on sane archs which have an easily accessible, fixed
>frequency time counter, loops_per_jiffy should never have existed :-)
>
>Second, putting this code there means that one day somebody will
>inevitably try to use it outside of its domain of operation (like it
>happened for div64 a few months ago when I pointed out that it would not
>work for divisors above 65535 or so).

Well... it's clearly located inside kernel/cpufreq.c, so there is
little risk, though it may be worth a big bold comment

>Finally, I agree that we should not import libgcc, but for example on
>PPC32 the double lengths shifts (__ashrdi3, __ashldi3, and __lshsldi3)
>are implemented somewhere, and the assembly implementation (directly
>taken from some appendix in PPC documentation, I just slightly twisted
>__ashrdi3 to make it branchless AFAIR) is actually way faster than the
>one in libgcc ;-), and less than half the size.
>
>  Adding a few subroutines that implement a subset of libgcc's
>functionality is necessary for most archs (which functions are needed is
>arch, and sometimes compiler's, dependent).
>
>In this case a generic scaling function, while not a standard libgcc/C
>library feature has potentially more applications than this simple 
>cpufreq approximation. But I don't see very much the need for scaling a 
>long (64 bit on 64 bit archs) value, 32 bit would be sufficient.

Well... if you can write one, go on then ;) In my case, I'm happy
with Yoann implementation for cpufreq right now. Though I agree that
could ultimately be moved to arch code.

Ben.


