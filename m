Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268298AbUIMSV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268298AbUIMSV3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 14:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268404AbUIMSV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 14:21:29 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:5259 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S268298AbUIMSV1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 14:21:27 -0400
Message-ID: <4145E50E.2020300@colorfullife.com>
Date: Mon, 13 Sep 2004 20:21:02 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg Edwards <edwardsg@sgi.com>
CC: Jesse Barnes <jbarnes@sgi.com>, paulmck@us.ibm.com,
       "Martin J. Bligh" <mbligh@aracnet.com>, hawkes@sgi.com,
       linux-kernel@vger.kernel.org, wli@holomorphy.com
Subject: Re: kernbench on 512p
References: <200408191216.33667.jbarnes@engr.sgi.com> <200408192016.10064.jbarnes@engr.sgi.com> <20040820155717.GF1243@us.ibm.com> <200408201324.32464.jbarnes@engr.sgi.com> <41265CCE.3070808@colorfullife.com> <20040910190153.GA32062@sgi.com>
In-Reply-To: <20040910190153.GA32062@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Edwards wrote:

>Whenever this happens, there is another thread waiting to sync buffers
>(sometimes with several backed up behind him).  It was kjournald in this
>case.  Have you seen this ever with these patches?
>
>  
>
No - as I wrote, I tested only with qemu, without networking. Thus the 
bh queue was never used. Just booting a complete system with 
uniprocessor, spinlock debugging enabled immediately showed a bug in 
line 315: It unlocked rcu_state.lock instead of rsp->lock :-(

pseudo-patch:

 out_unlock_all:
-                spin_unlock(&rcu_state.lock);
+                spin_unlock(&rsp->lock);
        }


--
    Manfred
