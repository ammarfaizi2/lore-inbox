Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751205AbWFFBzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWFFBzJ (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 21:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbWFFBzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 21:55:09 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:44253
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1751205AbWFFBzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 21:55:07 -0400
Message-ID: <4484E06B.9020609@microgate.com>
Date: Mon, 05 Jun 2006 20:54:51 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: Dave Jones <davej@redhat.com>, akpm@osdl.org, linux-kernel@vger.kernel.org,
        zippel@linux-m68k.org
Subject: Re: 2.6.17-rc5-mm3
References: <20060603232004.68c4e1e3.akpm@osdl.org>	<20060605230248.GE3963@redhat.com> <20060605184407.230bcf73.rdunlap@xenotime.net>
In-Reply-To: <20060605184407.230bcf73.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> Those Kconfig + Makefiles are quite ugly to me.  I would rather see
> SYNCLINK depend on HDLC rather than using some tricks to SELECT HDLC.
> And then it selects HDLC (and HDLC depends on WAN), but (in my case)
> WAN was not enabled, and doing "SELECT HDLC" did not enable WAN.
> 
> Adding SELECT WAN and changing the hdlc (wan) Makefile to use
> obj-m or obj-y (it was ONLY obj-y for hdlc) fixes^W makes it build
> with no missing symbols.  However, I'll also see about a fix
> that uses "depends on HDLC" instead of "selects HDLC".

Generic HDLC support in the synclink drivers is optional.
Should the generic HDLC code be enabled even if it is not used?

Some of our customers would scream if we started forcing
them to compile and load unused code.

> Fix many missing hdlc_generic symbols when CONFIG_HDLC=m.
> When Selecting HDLC, also Select WAN.
> Fix Makefile to build for HDLC=y or HDLC=m.
> 
> +	select WAN if SYNCLINK_HDLC

If this is the accepted approach, then synclink_cs should be added also.
(drivers/char/pcmcia)

What about select WAN if HDLC instead?
Or does kbuild not propogate the reverse dependency?
(SYNCLINK_HDLC selects HDLC, HDLC selects WAN)

--
Paul
