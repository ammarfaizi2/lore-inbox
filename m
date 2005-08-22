Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751002AbVHVUQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbVHVUQQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 16:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbVHVUQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 16:16:15 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:26580 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751002AbVHVUQN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 16:16:13 -0400
Date: Tue, 23 Aug 2005 01:48:02 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: John Hawkes <hawkes@jackhammer.engr.sgi.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, pj@sgi.com, nickpiggin@yahoo.com.au,
       akpm@osdl.org
Subject: Re: [PATCH] ia64 cpuset + build_sched_domains() mangles structures
Message-ID: <20050822201802.GA5083@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <43074328.MailOXV1UXUHF@jackhammer.engr.sgi.com> <20050822070834.GA16722@elte.hu> <20050822141414.GB7686@in.ibm.com> <20050822160719.GB6652@elte.hu> <20050822201626.GC7686@in.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <20050822201626.GC7686@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 23, 2005 at 01:46:26AM +0530, Dinakar Guniguntala wrote:
> On Mon, Aug 22, 2005 at 06:07:19PM +0200, Ingo Molnar wrote:
> > great! Andrew, i'd suggest we try the merged patch attached below in 
> > -mm.
> > 
> 
> Ingo, unfortunately I am hitting panic's on stress testing. The panic
> screen is attached in the .png below.

Sorry, forgot to add the .png. Here it is...

> 
> On debugging I found that the panic happens consistently in this line
>  of code in function find_busiest_group
> 
> 	*imbalance = min((max_load - avg_load) * busiest->cpu_power,
>                                 (avg_load - this_load) * this->cpu_power)
>                         / SCHED_LOAD_SCALE;
> 
> Here I find that the "this" pointer is still NULL. I verified this by
> a quick hack as below in the same function and with this hack it seems 
> to run for hours
> 
> -	if (!busiest || this_load >= max_load)
> +	if (!this || !busiest || this_load >= max_load)
> 
> This can only happen if the none of the sched groups pointed to by the 
> 'sd' of the current cpu contain the current cpu. I was wondering if
> this had anything to do with the way that we are using RCU to assign/
> read the 'sd' pointer.
> 
> Any thoughts ??
> 
> 	-Dinakar
> 

--17pEHd4RhPHOinZp
Content-Type: image/png
Content-Disposition: attachment; filename="sd-panic.png"
Content-Transfer-Encoding: base64

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
YII=

--17pEHd4RhPHOinZp--
