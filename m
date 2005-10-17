Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751413AbVJQXvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbVJQXvi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 19:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbVJQXvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 19:51:38 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:29428 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S1751413AbVJQXvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 19:51:37 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Muli Ben-Yehuda <mulix@mulix.org>, Andi Kleen <ak@suse.de>,
       discuss@x86-64.org, Ravikiran G Thirumalai <kiran@scalex86.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, shai@scalex86.org, clameter@engr.sgi.com,
       muli@il.ibm.com, jdmason@us.ibm.com
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <Pine.LNX.4.64.0510171200490.3369@g5.osdl.org>
References: <20051017093654.GA7652@localhost.localdomain> <200510172008.24669.ak@suse.de><20051017182755.GA26239@granada.merseine.nu> <200510172032.45972.ak@suse.de><20051017184523.GB26239@granada.merseine.nu> <Pine.LNX.4.64.0510171200490.3369@g5.osdl.org>
Date: Mon, 17 Oct 2005 16:50:54 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: [discuss] Re: x86_64: 2.6.14-rc4 swiotlb broken
In-Reply-To: <Pine.LNX.4.64.0510171200490.3369@g5.osdl.org>
Message-ID: <Pine.LNX.4.62.0510171648200.29558@qynat.qvtvafvgr.pbz>
References: <20051017093654.GA7652@localhost.localdomain>
 <200510172008.24669.ak@suse.de><20051017182755.GA26239@granada.merseine.nu>
 <200510172032.45972.ak@suse.de><20051017184523.GB26239@granada.merseine.nu>
 <Pine.LNX.4.64.0510171200490.3369@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Oct 2005, Linus Torvalds wrote:
>
> Why? Because the bootmem memory should still be allocated low-to-high by
> default, which means that as logn as NODE(0) has _enough_ memory in the
> DMA range, we should be ok.
>
> So I _think_ the simple one-liner NODE(0) patch is sufficient, and should
> work (and is a lot more acceptable for 2.6.14 than switching the node
> ordering around yet again, or doing bigger surgery on the bootmem code).
>
> So the only thing that worried me (and made me ask whether there might be
> machines where it doesn't work) is if some machines might have their high
> memory (or no memory at all) on NODE(0). It does sound unlikely, but I
> simple don't know what kind of strange NUMA configs there are out there.
>
> And I'm definitely only interested in machines that are out there, not
> some theoretical issues.

what about x86_64 machines with 8G of ram connected to each CPU (4x2G 
DIMMs), not exactly common, but also not that rare.

also if CPU's are registered from high to low would a 2 CPU box with 8G of 
ram connected to one CPU and no ram connected to the second CPU match your 
problem case (I know that's a sub-optimal layout, but it's legal)

David Lang


> 			Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
