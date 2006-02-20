Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161092AbWBTUEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161092AbWBTUEY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 15:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161116AbWBTUEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 15:04:24 -0500
Received: from mail.gmx.de ([213.165.64.20]:2275 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161102AbWBTUEX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 15:04:23 -0500
X-Authenticated: #31060655
Message-ID: <43FA20C4.9090709@gmx.net>
Date: Mon, 20 Feb 2006 21:04:20 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.12) Gecko/20050921
X-Accept-Language: de, en
MIME-Version: 1.0
To: Patrick McHardy <kaber@trash.net>
CC: Reuben Farrelly <reuben-lkml@reub.net>, Andrew Morton <akpm@osdl.org>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       linux-kernel@vger.kernel.org, dccp@vger.kernel.org
Subject: Re: 2.6.16-rc4-mm1
References: <20060220042615.5af1bddc.akpm@osdl.org> <43F9BDDA.1060508@reub.net> <43F9CE18.10709@trash.net>
In-Reply-To: <43F9CE18.10709@trash.net>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick McHardy schrieb:
> Reuben Farrelly wrote:
> 
>>Minor dependency issue:
>>
>>My compile failed with this..
>>
>>  CC [M]  net/netfilter/xt_dccp.o
>>In file included from net/netfilter/xt_dccp.c:15:
>>include/linux/dccp.h:341:2: error: #error "At least one CCID must be
>>built as the default"
>>make[2]: *** [net/netfilter/xt_dccp.o] Error 1
>>make[1]: *** [net/netfilter] Error 2
>>make: *** [net] Error 2
>>[root@tornado linux-2.6-mm]#
>>
>>[I have no idea what a CCID is]
>>
>>But it was caused by this:
>>
>>CONFIG_NETFILTER_XT_MATCH_DCCP=m
>>
>>and maybe this below had an impact:
>>
>>#
>># DCCP Configuration (EXPERIMENTAL)
>>#
>># CONFIG_IP_DCCP is not set
>>
>>After unsetting the option to build the DCCP Netfilter module, I was
>>able to compile through to completion.
> 
> 
> Ideally this dependency should be enforced by Kconfig. I'm not sure
> if it is possible to express something like "IP_DCCP_CCID2 and
> IP_DCCP_CCID3 depend on DCCP, DCCP requires at least one of both
> to be enabled". Can someone more familiar with Kconfig than me
> comment on this? Otherwise the #error should be moved to
> net/dccp/options.c to keep dccp.h usable without dccp enabled.

Suggestion (not tested):

config IP_DCCP_CCID2
        tristate "blah"
        select DCCP
        help
          Foo
config IP_DCCP_CCID3
        tristate "blah"
        select DCCP
        help
          Foo
config DCCP
        bool "blah"
        depends on IP_DCCP_CCID2 || IP_DCCP_CCID3
        help
          Foo


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
