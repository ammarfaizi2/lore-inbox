Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161177AbWBTU4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161177AbWBTU4s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 15:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161181AbWBTU4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 15:56:48 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:60091 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161177AbWBTU4s convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 15:56:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MpOtqzXu7bQZAXMubJVOU6x7OXrhKVBLjayYNPPMBGFku1Ch+gesADG2lrsDpldAygqxbhanj9ryoC8f2H+0kWdXWlh21KAQkT57Ih+0u/lEePwIQ1+ne4fOBTWns/9HJSrdHtSHGV5rPiu1ysW58+83gNNGYi7WVAVDQF5S3Zw=
Message-ID: <39e6f6c70602201256s14df3079j676a88e28934d8ef@mail.gmail.com>
Date: Mon, 20 Feb 2006 17:56:47 -0300
From: "Arnaldo Carvalho de Melo" <acme@ghostprotocols.net>
To: "Carl-Daniel Hailfinger" <c-d.hailfinger.devel.2006@gmx.net>
Subject: Re: 2.6.16-rc4-mm1
Cc: "Patrick McHardy" <kaber@trash.net>,
       "Reuben Farrelly" <reuben-lkml@reub.net>,
       "Andrew Morton" <akpm@osdl.org>,
       "Netfilter Development Mailinglist" 
	<netfilter-devel@lists.netfilter.org>,
       linux-kernel@vger.kernel.org, dccp@vger.kernel.org
In-Reply-To: <43FA20C4.9090709@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060220042615.5af1bddc.akpm@osdl.org> <43F9BDDA.1060508@reub.net>
	 <43F9CE18.10709@trash.net> <43FA20C4.9090709@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/06, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net> wrote:
> Patrick McHardy schrieb:
> > Reuben Farrelly wrote:
> >
> >>Minor dependency issue:
> >>
> >>My compile failed with this..
> >>
> >>  CC [M]  net/netfilter/xt_dccp.o
> >>In file included from net/netfilter/xt_dccp.c:15:
> >>include/linux/dccp.h:341:2: error: #error "At least one CCID must be
> >>built as the default"
> >>make[2]: *** [net/netfilter/xt_dccp.o] Error 1
> >>make[1]: *** [net/netfilter] Error 2
> >>make: *** [net] Error 2
> >>[root@tornado linux-2.6-mm]#
> >>
> >>[I have no idea what a CCID is]
> >>
> >>But it was caused by this:
> >>
> >>CONFIG_NETFILTER_XT_MATCH_DCCP=m
> >>
> >>and maybe this below had an impact:
> >>
> >>#
> >># DCCP Configuration (EXPERIMENTAL)
> >>#
> >># CONFIG_IP_DCCP is not set
> >>
> >>After unsetting the option to build the DCCP Netfilter module, I was
> >>able to compile through to completion.
> >
> >
> > Ideally this dependency should be enforced by Kconfig. I'm not sure
> > if it is possible to express something like "IP_DCCP_CCID2 and
> > IP_DCCP_CCID3 depend on DCCP, DCCP requires at least one of both
> > to be enabled". Can someone more familiar with Kconfig than me
> > comment on this? Otherwise the #error should be moved to
> > net/dccp/options.c to keep dccp.h usable without dccp enabled.
>
> Suggestion (not tested):
>
> config IP_DCCP_CCID2
>         tristate "blah"
>         select DCCP
>         help
>           Foo
> config IP_DCCP_CCID3
>         tristate "blah"
>         select DCCP
>         help
>           Foo
> config DCCP
>         bool "blah"
>         depends on IP_DCCP_CCID2 || IP_DCCP_CCID3
>         help
>           Foo

NAK, its more clear to be exposed to DCCP specific stuff such as CCIDs only
if the user selected DCCP.

So perhaps something like what is done for the io schedulers, will study this...

- Arnaldo
