Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264816AbSJaKj0>; Thu, 31 Oct 2002 05:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264814AbSJaKj0>; Thu, 31 Oct 2002 05:39:26 -0500
Received: from tml.hut.fi ([130.233.44.1]:13842 "EHLO tml-gw.tml.hut.fi")
	by vger.kernel.org with ESMTP id <S264816AbSJaKjY>;
	Thu, 31 Oct 2002 05:39:24 -0500
Date: Thu, 31 Oct 2002 12:41:46 +0200
From: Antti Tuominen <ajtuomin@morphine.tml.hut.fi>
To: Noriaki Takamiya <takamiya@po.ntts.co.jp>
Cc: davem@redhat.com, kuznet@ms2.inr.ac.ru, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, yoshfuji@wide.ad.jp, pekkas@netcore.fi,
       torvalds@transmeta.com, jagana@us.ibm.com
Subject: Re: [PATCHSET] Mobile IPv6 for 2.5.43
Message-ID: <20021031104146.GA18786@morphine.tml.hut.fi>
References: <20021017162624.GC16370@morphine.tml.hut.fi> <20021031.174442.846937513.takamiya@po.ntts.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021031.174442.846937513.takamiya@po.ntts.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 05:44:42PM +0900, Noriaki Takamiya wrote:
> Hi,

Hello Takamiya,

>   Please note that we're preparing for checking to what extent this
>   patch is compliant to the Internet draft of MIPv6.  

May I ask with what?  We ran all the TAHI tests last month at ETSI
IPv6 Plugtest, and know pretty much were we stand.  And with all due
respect to TAHI, who checks that the test suites conform to the spec?

> (1) About MIPV6CALLFUNC and MIPV6CALLPROC
> 	It is reasonable to use these macros for modularized
> 	functions. But the current your implementation needs to select
> 	HA or MN when compiling the kernel. So, it doesn't seems to be
> 	needed this macros, and the real function may be called
> 	directly. How about this?

If MIPv6 is compiled as module, and is not loaded, those macros
protect against calling non-existant code.  HA and MN do not need to
be compiled statically, if that is what you are implying.  You must
first select CN support, which decides module or static.

> 	Rather, how about using sysctl and so on to switch the
> 	functionality?

No.  Users want to be able to have only one of the capabilities loaded
at one time (i.e. CN, CN+MN or CN+HA).  When you compile e.g. CN,
there is no HA or MN support compiled in, so the sysctl makes no sense.

> (4) Processing Mobility Header
> 	How about using ip6_txoptions and hdrproc_lst?
> 	Because Mobility header is an extension header, we think it is
> 	reasonable way to handle it in ipv6_parse_exthdrs().

No.  We did this back in Draft 15, when all the mobility stuff was
destination options.  Mobility Header is not an extension header, but
rather a final protocol.  Only Home Address Option is an extension
header and is handled in ipv6/exthdrs.c.  What is the problem with
this?

> (5) How about using CryptoAPI?
> 	CryptoAPI is merged to mainline.
> 	We believe we can use the CryptoAPI for caluculating cookies 
> 	of RR.  How do you think about this?

Yes, this will be done.  But that was merged yesterday, and we are
only humans :)

> (6) Order of HAO and Routing header
> 	When MN acts also as CN, the order doesn't seems to be
> 	compliant to ID-18 in the implementation. The order will be
> 	the following:
> 
> 	[IPv6][HAO][RT2]
> 
> 	I-D says:
> 
> 	[IPv6][RT2][HAO]

Right.  We haven't changed the IPv6 code to support the third
destination option header placement (after RH, before frag/AH/ESP),
and since it introduces no compatibility problems with any other
implementation we've tested with, it has not been a priority.

Regards,

Antti

-- 
Antti J. Tuominen, Gyldenintie 8A 11, 00200 Helsinki, Finland.
Research assistant, Institute of Digital Communications at HUT
work: ajtuomin@tml.hut.fi; home: tuominen@iki.fi

