Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269477AbUINTTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269477AbUINTTE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 15:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269366AbUINTS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 15:18:57 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:65434 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S269477AbUINTSi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 15:18:38 -0400
Message-ID: <41474395.4040206@colorfullife.com>
Date: Tue, 14 Sep 2004 21:16:37 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg Edwards <edwardsg@sgi.com>
CC: Jesse Barnes <jbarnes@sgi.com>, paulmck@us.ibm.com,
       "Martin J. Bligh" <mbligh@aracnet.com>, hawkes@sgi.com,
       linux-kernel@vger.kernel.org, wli@holomorphy.com
Subject: Re: kernbench on 512p
References: <200408191216.33667.jbarnes@engr.sgi.com> <200408192016.10064.jbarnes@engr.sgi.com> <20040820155717.GF1243@us.ibm.com> <200408201324.32464.jbarnes@engr.sgi.com> <41265CCE.3070808@colorfullife.com> <20040910190153.GA32062@sgi.com> <4145E50E.2020300@colorfullife.com> <20040914175241.GI4178@sgi.com> <41473578.7000106@colorfullife.com> <20040914184327.GM4178@sgi.com>
In-Reply-To: <20040914184327.GM4178@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Edwards wrote:

>| >
>| Which value did you use for RCU_GROUP_SIZE? I'm not sure what's the 
>| optimal value for 512p - probably 32 or so.
>
>I used what was defined in the patch
>
>+#define RCU_GROUP_SIZE 2
>
>I can try running with a couple different values and see how it looks.
>
>  
>
Ok, that explains the lockstat: I've missed data on rcu_group_state.lock.

I'd just use 32. The code uses a two-level bitmap and the group size 
specifies the size of the lower level.
Thus you use right now a 2/256 split. Therefore you still trash the 
spinlock that protects the upper level. Group size 32 would generate a 
32/16 split.

--
    Manfred

