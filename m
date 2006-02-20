Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964931AbWBTOU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964931AbWBTOU1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 09:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030235AbWBTOU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 09:20:26 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:14675 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964933AbWBTOU0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 09:20:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n9Kgz5RAucu1dbQcmpfDzR5+A8unJ8uBcs5KJESFO21qRE4iBgwVG5b97u5ccLeriSxsX1T4oi32NPOSa6VnnR2atYKHuIUaiqLv2yIXJ3b5bxtT0wNKa14uj2EKx9xnXNUprTpEZevotZ2oYTzfihu0F6smMb4og2zydFH2o88=
Message-ID: <39e6f6c70602200620i750b022an4c544072ff51f080@mail.gmail.com>
Date: Mon, 20 Feb 2006 11:20:24 -0300
From: "Arnaldo Carvalho de Melo" <acme@ghostprotocols.net>
To: "Patrick McHardy" <kaber@trash.net>
Subject: Re: 2.6.16-rc4-mm1
Cc: "Reuben Farrelly" <reuben-lkml@reub.net>, "Andrew Morton" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       "Netfilter Development Mailinglist" 
	<netfilter-devel@lists.netfilter.org>,
       dccp@vger.kernel.org
In-Reply-To: <43F9CE18.10709@trash.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060220042615.5af1bddc.akpm@osdl.org> <43F9BDDA.1060508@reub.net>
	 <43F9CE18.10709@trash.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/06, Patrick McHardy <kaber@trash.net> wrote:
> Reuben Farrelly wrote:
> > Minor dependency issue:
> >
> > My compile failed with this..
> >
> >   CC [M]  net/netfilter/xt_dccp.o
> > In file included from net/netfilter/xt_dccp.c:15:
> > include/linux/dccp.h:341:2: error: #error "At least one CCID must be
> > built as the default"
> > make[2]: *** [net/netfilter/xt_dccp.o] Error 1
> > make[1]: *** [net/netfilter] Error 2
> > make: *** [net] Error 2
> > [root@tornado linux-2.6-mm]#
> >
> > [I have no idea what a CCID is]
> >
> > But it was caused by this:
> >
> > CONFIG_NETFILTER_XT_MATCH_DCCP=m
> >
> > and maybe this below had an impact:
> >
> > #
> > # DCCP Configuration (EXPERIMENTAL)
> > #
> > # CONFIG_IP_DCCP is not set
> >
> > After unsetting the option to build the DCCP Netfilter module, I was
> > able to compile through to completion.
>
> Ideally this dependency should be enforced by Kconfig. I'm not sure
> if it is possible to express something like "IP_DCCP_CCID2 and
> IP_DCCP_CCID3 depend on DCCP, DCCP requires at least one of both
> to be enabled". Can someone more familiar with Kconfig than me
> comment on this? Otherwise the #error should be moved to
> net/dccp/options.c to keep dccp.h usable without dccp enabled.

oops, I think I'll move the #error to options.c, thanks for forwarding
this report
to dccp@vger.kernel.org.

- Arnaldo
