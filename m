Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWJLUr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWJLUr4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 16:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbWJLUr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 16:47:56 -0400
Received: from iriserv.iradimed.com ([69.44.168.233]:28388 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1750746AbWJLUrz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 16:47:55 -0400
Message-ID: <452EA9FF.2040602@cfl.rr.com>
Date: Thu, 12 Oct 2006 16:47:59 -0400
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Alasdair G Kergon <agk@redhat.com>, Phillip Susi <psusi@cfl.rr.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Heinz Mauelshagen <mauelshagen@redhat.com>
Subject: Re: dm stripe: Fix bounds
References: <20060316151114.GS4724@agk.surrey.redhat.com> <452DBE11.2000005@cfl.rr.com> <20061012135945.GV17654@agk.surrey.redhat.com> <452E5FD0.8060309@cfl.rr.com> <20061012160515.GD17654@agk.surrey.redhat.com> <452E85ED.1040409@cfl.rr.com> <20061012183529.GF17654@agk.surrey.redhat.com>
In-Reply-To: <20061012183529.GF17654@agk.surrey.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Oct 2006 20:48:10.0146 (UTC) FILETIME=[BA3BA820:01C6EE3F]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14748.000
X-TM-AS-Result: No--12.608800-5.000000-2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alasdair G Kergon wrote:
> On Thu, Oct 12, 2006 at 02:14:05PM -0400, Phillip Susi wrote:
>> So you are saying that dmraid should build 3 tables: 1 for the bulk of 
>> the array, 1 for only the last stripe, and 1 linear to connect them?
>  
> No.  1 table.  2 consecutive targets with different stripe sizes, if that's
> how the data is actually laid out.
> 

One stripe table can only contain one stripe size, so to have two would 
require two tables, and a third table to tie them back together.

>> the only problem comes from the last 
>> stripe.  How else could you map the last stripe other than laying down x 
>> sectors onto y drives as x / y sectors on each drive in sequence?
>  
> Depends whether or not you give precedence to the stripe size.
> The underlying device might be much larger - dm doesn't know or care - and
> the intention of userspace might have been to truncate a larger striped
> device part-way through one of the stripes - an equally reasonable thing to
> do.

The entire idea of a stripe is that you are using multiple identical 
drives ( or partitions ), so it doesn't make any sense to be able to 
truncate one of the drives.  In any case, this is not something you can 
do now, so the fact that you could not do it then either does not seem 
to be a good argument against allowing partial tails.


