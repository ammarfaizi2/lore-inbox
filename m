Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319068AbSHWTHP>; Fri, 23 Aug 2002 15:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319112AbSHWTHP>; Fri, 23 Aug 2002 15:07:15 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:41600 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S319068AbSHWTHO>; Fri, 23 Aug 2002 15:07:14 -0400
Message-ID: <3D668850.468184FC@austin.ibm.com>
Date: Fri, 23 Aug 2002 14:09:04 -0500
From: Bill Hartner <hartner@austin.ibm.com>
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Mala Anand <manand@us.ibm.com>
CC: Benjamin LaHaise <bcrl@redhat.com>, alan@lxorguk.ukuu.org.uk,
       Bill Hartner <bhartner@us.ibm.com>, davem@redhat.com,
       linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       lse-tech-admin@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: (RFC): SKB Initialization
References: <OF126E7130.D54285DD-ON87256C1C.0077A747@boulder.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mala Anand wrote:
> 
> Baseline 2.5.25
> ----------------
>        alloc/free average cycles
>        -------------------------
> Runs:      1st              2nd          3rd
> 
> CPU0:    337/1163       336/1132      304/1100
> CPU1:    318/1164       309/1153      311/1127
> 
> 2.5.25+skbinit patch
> --------------------
> 
>        alloc/free average cycles
>        -------------------------
> Runs:      1st          2nd            3rd
> 
> CPU0:   447/1015       580/846        402/905
> CPU1:   419/1003       383/915        547/856
> 
> The above figures indicate that the cycles spent in alloc_skb and
> __kfree_skb have gained 5% in the patch case.  However if you
> take the absolute cycles and average them for the three runs it
> comes around 145 cycles saving that is close to what I posted earlier
> by measuring just the changed code. As the scope of the code measured
> widens the percentage improvement comes down.

Measuring just the initialization code yielded a reduction of 156 cycles.
Measuring alloc_skb and __kfree_skb yielded a reduction of 145 cycles.
This was on a 2 CPU system.

The worst case scenario would be allocating the skb header on one
CPU then freeing it on another CPU.  The best case would be doing 
all of the allocs and frees on one CPU.

You can use process/irq affinity to create both of these cases.
Can you measure these ?

Bill
