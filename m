Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315971AbSE3AyA>; Wed, 29 May 2002 20:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315988AbSE3Ax7>; Wed, 29 May 2002 20:53:59 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:49291 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315971AbSE3Ax6>; Wed, 29 May 2002 20:53:58 -0400
Date: Wed, 29 May 2002 17:54:06 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, john stultz <johnstul@us.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] Disable TSCs on CONFIG_MULTIQUAD
Message-ID: <521610000.1022720046@flay>
In-Reply-To: <1022722675.4124.337.camel@irongate.swansea.linux.org.uk>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Anyway, if you really would rather see what you suggested, I'll happily
>> change it (I do like the idea of breaking the CONFIG_X86_TSC_UNSYNCED
>> notion out of CONFIG_MULTIQUAD).
> 
> Not all the other places are "there is no TSC" most of them deal with
> the ability to use a TSC. There are other setups where TSC exists but
> isnt usable so distinguishing matters

I think the CONFIG_X86_TSC option is most confusing (bad naming, at
best).

Without CONFIG_X86_TSC:
You get the ability to have a TSC or not, both code paths are compiled
in, and it dynamically detects at boot time. You can override this with the
"notsc" option, or overriding the tsc_disable variable, as we did here.

With CONFIG_X86_TSC:
You remove all the code which supports non-TSC systems.

Perhaps I'm just mentally slow, but I think my little brain would find this
area easier of it was called CONFIG_X86_ONLY_TSC or some such.

So if John's patch was rewritten to leave the CPU type switching on
CONFIG_X86_TSC, then have the multiquad switch turn that into 
CONFIG_X86_ONLY_TSC (and change the in code #ifdefs to that)
would that be more palletable? Would make things more readable in
the main code to my mind ....

M.

