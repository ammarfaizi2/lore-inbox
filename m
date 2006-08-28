Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750916AbWH1SLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbWH1SLx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 14:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWH1SLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 14:11:53 -0400
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:27576 "EHLO
	caffeine.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1750916AbWH1SLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 14:11:52 -0400
Date: Mon, 28 Aug 2006 14:11:41 -0400
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Strange transmit corruption in jsm driver on geode sc1200 system
Message-ID: <20060828181141.GK13641@csclub.uwaterloo.ca>
References: <20060825203047.GH13641@csclub.uwaterloo.ca> <1156540817.3007.270.camel@localhost.localdomain> <20060825210305.GL13639@csclub.uwaterloo.ca> <20060825212441.GC2246@martell.zuzino.mipt.ru> <20060825215724.GI13641@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060825215724.GI13641@csclub.uwaterloo.ca>
User-Agent: Mutt/1.5.9i
From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lsorense@csclub.uwaterloo.ca
X-SA-Exim-Scanned: No (on caffeine.csclub.uwaterloo.ca); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2006 at 05:57:24PM -0400, Lennart Sorensen wrote:
> Of course given the __memcpy assembly seems to work fine unalligned on a
> pentium4, and probably most othe systems, what could make it not work
> correctly on a geode SC1200?

Related to the SC1200, I notied cyrix.c doesn't actually know about the
SC1200 that we are using.  This one returs dir0_msn = 11, while cyrix.c
only knows about 0 through 5.  If I add 11 to the block handling geode
GX1, then I get this cpuinfo:

processor       : 0
vendor_id       : CyrixInstead
cpu family      : 5
model           : 9
model name      : Geode(TM) Integrated Processor by National Semi
stepping        : 1
cpu MHz         : 266.729
cache size      : 16 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu tsc msr cx8 cmov mmx cxmmx
bogomips        : 535.35

So the get_model_name function seems to do something on it.  Otherwise I
get "model name" of Unknown, since there is no entry for it in cyrix.c

Since it is unknown, no setup calls are being done, although it seems a
number of features exist that could be enabled on the geode gx1, which I
believe is what a geode sc1200 really is.  The full label of the CPU is:

(national semi conductors logo)
Geode(tm)
SC1200
SC1200UL-266
(C)(M)NSC1999 D3
VS424AB

Does anyone know what should be called on this CPU type, and how to fix
cyrix.c to handle it correcly rather than ignoring it?

Forcing it to be treated like a GX1 and calling the geode_configure
function call, does not make my memcpy_toio problem go away.  On the
other hand I have a small optimistic hope that if it actually turns on
power saving on HLT, and some cache and memory optimizations, that it
might actually make the system run slightly faster and use slightly less
power.  If someone knows that part for sure I would love to know.

--
Len Sorensen
