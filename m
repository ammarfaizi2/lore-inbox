Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750880AbWC2R3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbWC2R3E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 12:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbWC2R3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 12:29:04 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:47750 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1750880AbWC2R3C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 12:29:02 -0500
Date: Wed, 29 Mar 2006 19:29:01 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Kirill Korotaev <dev@sw.ru>
Cc: Kirill Korotaev <dev@openvz.org>, devel@openvz.org,
       Kir Kolyshkin <kir@sacred.ru>, linux-kernel@vger.kernel.org,
       sam@vilain.net
Subject: Re: [Devel] Re: [RFC] Virtualization steps
Message-ID: <20060329172901.GE15842@MAIL.13thfloor.at>
Mail-Followup-To: Kirill Korotaev <dev@sw.ru>,
	Kirill Korotaev <dev@openvz.org>, devel@openvz.org,
	Kir Kolyshkin <kir@sacred.ru>, linux-kernel@vger.kernel.org,
	sam@vilain.net
References: <44242D4D.40702@yahoo.com.au> <1143228339.19152.91.camel@localhost.localdomain> <4428BB5C.3060803@tmr.com> <4428DB76.9040102@openvz.org> <1143583179.6325.10.camel@localhost.localdomain> <4429B789.4030209@sacred.ru> <1143588501.6325.75.camel@localhost.localdomain> <442A4FAA.4010505@openvz.org> <20060329134524.GA14522@MAIL.13thfloor.at> <442A9E1E.4030707@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <442A9E1E.4030707@sw.ru>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2006 at 06:47:58PM +0400, Kirill Korotaev wrote:
> >>I wonder what is the value of it if it doesn't do guarantees or QoS?
> >>In our experiments with it we failed to observe any fairness. 
> >
> >probably a misconfiguration on your side ...
> maybe you can provide some instructions on which kernel version to use
> and how to setup the following scenario: 2CPU box. 3 VPSs which should
> run with 1:2:3 ratio of CPU usage.

that is quite simple, you enable the Hard CPU Scheduler
and select the Idle Time Skip, then you set the following
token bucket values depending on what your mean with
'should run with 1:2:3 ratio of CPU usage':

a) a guaranteed maximum of 16.7%, 33.3% and 50.0%

b) a fair sharing according to 1:2:3

c) a guaranteed minimum of 16.7%, 33.3% and 50.0%
   with a fair sharing of 1:2:3 for the rest ...


for all cases you would set:
(adjust according to you reserve/boost likings)
   
    VPS1,2,3:	tokens_min = 50, tokens_max = 500
    	    	interval = interval2 = 6

a)  VPS1: rate = 1, hard, noidleskip
    VPS2: rate = 2, hard, noidleskip
    VPS3: rate = 3, hard, noidleskip

b)  VPS1: rate2 = 1, hard, idleskip
    VPS2: rate2 = 2, hard, idleskip
    VPS3: rate2 = 3, hard, idleskip

c)  VPS1: rate = rate2 = 1, hard, idleskip
    VPS2: rate = rate2 = 2, hard, idleskip
    VPS3: rate = rate2 = 3, hard, idleskip

of course, adjusting rate/interval while keeping
the ratio might help you depending on the guest load
(i.e. more batch load type or mor interactive stuff)

of course, you can do those adjustments per CPU so, if
you for example want to assign one CPU to the third
guest, you can do that easily too ...

> >well, do you have numbers?
> just run the above scenario with one busy loop inside each VPS. I was 
> not able to observe 1:2:3 cpu distribution. Other scenarios also didn't 
> showed my any fairness. The results were different. Sometimes 1:1:2, 
> sometimes others.

what was your setup?

best,
Herbert

> Thanks,
> Kirill
