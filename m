Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbWHVNpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWHVNpN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 09:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWHVNpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 09:45:12 -0400
Received: from mx03.cybersurf.com ([209.197.145.106]:49321 "EHLO
	mx03.cybersurf.com") by vger.kernel.org with ESMTP id S932250AbWHVNpK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 09:45:10 -0400
Subject: Re: 800+ byte inlines in include/net/pkt_act.h
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: David Miller <davem@davemloft.net>
Cc: vda.linux@googlemail.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <20060821.163801.15260979.davem@davemloft.net>
References: <200608201933.10293.vda.linux@googlemail.com>
	 <1156163160.5126.47.camel@jzny2>
	 <20060821.163801.15260979.davem@davemloft.net>
Content-Type: text/plain
Organization: ?
Date: Tue, 22 Aug 2006 09:45:05 -0400
Message-Id: <1156254305.5304.17.camel@jzny2>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-21-08 at 16:38 -0700, David Miller wrote:
> From: jamal <hadi@cyberus.ca>
> Date: Mon, 21 Aug 2006 08:26:00 -0400
> 
> > As per last discussion, either Patrick McHardy or myself are going
> > to work on it - at some point. Please be patient. The other
> > alternative is: you fix it and send patches.
> 
> I'm working on it right now.  This code is really gross and needs
> to be fixed immediately.
> 
> What I'll do is define a "struct tcf_common" and have the generic
> interfaces take that as well as a "struct tcf_hashinfo *" parameter to
> deal with the individual hash tables.
> 

Sounds reasonable. May actually be close to what Patrick and I had in
discussion (I cant find my notes) i.e hashinfo would contain
table{size,index,mask,lock, and pointer to table}
After staring at the code for a minute, I think the challenges you may
face are in the conversions of: tcf_ {dump_walker(), del_walker() and
generic_walker()}

Thanks for taking this up Dave. And if you get it started and get
distracted somewhere, I could take it over.

> We define all of this templated stuff then don't even use it in
> act_police.c, we just duplicate everything!

act_police deviates from the generic layout; the intent is to allow for
that. The desire was/is for usability for whoever uses the generic
layout (read: joe-netfilter) could write a single page of code quickly
to do something powerful (like gact for example). It is turning out code
augmentation is not such a practical idea in the kernel.

cheers,
jamal

> Absolutely unbelievable.
> -
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

