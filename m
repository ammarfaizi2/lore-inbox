Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030423AbWHUM0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030423AbWHUM0G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 08:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030424AbWHUM0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 08:26:06 -0400
Received: from mx02.cybersurf.com ([209.197.145.105]:6574 "EHLO
	mx02.cybersurf.com") by vger.kernel.org with ESMTP id S1030419AbWHUM0E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 08:26:04 -0400
Subject: Re: 800+ byte inlines in include/net/pkt_act.h
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Denis Vlasenko <vda.linux@googlemail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <200608201933.10293.vda.linux@googlemail.com>
References: <200608201933.10293.vda.linux@googlemail.com>
Content-Type: text/plain
Organization: ?
Date: Mon, 21 Aug 2006 08:26:00 -0400
Message-Id: <1156163160.5126.47.camel@jzny2>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-20-08 at 19:33 +0200, Denis Vlasenko wrote:
> Hi,
> 
> include/net/pkt_act.h plays a game of inlines
> which are kind of "templatized", like this:
> 
> act_ipt.c:
> 
> /* ovewrride the defaults */
> #define tcf_st          tcf_ipt
> #define tcf_t_lock      ipt_lock
> #define tcf_ht          tcf_ipt_ht
> #define CONFIG_NET_ACT_INIT
> #include <net/pkt_act.h>
> 
> This results in code duplication. For example,
> tcf_generic_walker() is duplicated four times.
> On i386 it is about 4*800 bytes in text section.
> Other inlines are a bit smaller but still are substantial.

As per last discussion, either Patrick McHardy or myself are going to
work on it - at some point. Please be patient. The other alternative is:
you fix it and send patches. 

Note that even after conversion, functions like tcf_generic_walker() are
not going to save much in total .text sizes; also note they run the
control path and are typically not as much invoked and therefore not
performance impacting on smaller cache systems..

cheers,
jamal

