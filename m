Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264077AbTH1Pt4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 11:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264079AbTH1Pt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 11:49:56 -0400
Received: from sojef.skynet.be ([195.238.2.127]:166 "EHLO sojef.skynet.be")
	by vger.kernel.org with ESMTP id S264077AbTH1Ptw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 11:49:52 -0400
Message-ID: <001301c36d7b$f96cfbe0$0400a8c0@LAPTOP>
From: "Hans Lambrechts" <hans.lambrechts@skynet.be>
To: "Patrick McHardy" <kaber@trash.net>
Cc: <linux-kernel@vger.kernel.org>,
       "Netfilter Development Mailinglist" 
	<netfilter-devel@lists.netfilter.org>
References: <pcKD.6BP.19@gated-at.bofh.it> <200308280850.h7S8oxGx001862@pc.skynet.be> <3F4E1823.7060600@trash.net>
Subject: Re: Linux 2.4.23-pre1
Date: Thu, 28 Aug 2003 17:49:32 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Patrick,

forwarding and NAT works as before

greetings,
Hans

----- Original Message ----- 
From: "Patrick McHardy" <kaber@trash.net>
To: "Hans Lambrechts" <hans.lambrechts@skynet.be>
Cc: <linux-kernel@vger.kernel.org>; "Netfilter Development Mailinglist"
<netfilter-devel@lists.netfilter.org>
Sent: Thursday, August 28, 2003 4:56 PM
Subject: Re: Linux 2.4.23-pre1


> Please try this patch.
>
> Regards,
> Patrick
>
> Hans Lambrechts wrote:
>
> >Greetings,
> >
> >
> >
> >>Harald Welte:
> >>  o [NETFILTER]: Backport iptables AH/ESP fixes from 2.6.x
> >>  o [NETFILTER]: Fix uninitialized return in iptables tftp
> >>  o [NETFILTER]: NAT optimization
> >>  o [NETFILTER]: Conntrack optimization (LIST_DELETE)
> >>
> >>
> >>
> >
> >
> >I see this in my log:
> >
> >Aug 28 10:45:44 pc kernel: MASQUERADE: No route: Rusty's brain broke!
> >Aug 28 10:46:10 pc last message repeated 13 times
> >Aug 28 10:48:42 pc kernel: NET: 1 messages suppressed.
> >Aug 28 10:48:42 pc kernel: MASQUERADE: No route: Rusty's brain broke!
> >Aug 28 10:48:43 pc kernel: MASQUERADE: Route sent us somewhere else.
> >
> >Forwarding and masquerading doesn't work anymore.
> >
> >Hans
> >
> >
>


----------------------------------------------------------------------------
----


> ===== net/ipv4/netfilter/ipt_MASQUERADE.c 1.6 vs edited =====
> --- 1.6/net/ipv4/netfilter/ipt_MASQUERADE.c Tue Aug 12 11:30:12 2003
> +++ edited/net/ipv4/netfilter/ipt_MASQUERADE.c Thu Aug 28 16:54:15 2003
> @@ -90,6 +90,7 @@
>  #ifdef CONFIG_IP_ROUTE_FWMARK
>   key.fwmark = (*pskb)->nfmark;
>  #endif
> + key.oif = 0;
>   if (ip_route_output_key(&rt, &key) != 0) {
>                  /* Funky routing can do this. */
>                  if (net_ratelimit())
>


