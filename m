Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbWDZEjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbWDZEjI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 00:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbWDZEjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 00:39:08 -0400
Received: from fw5.argo.co.il ([194.90.79.130]:51719 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S932358AbWDZEjH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 00:39:07 -0400
Message-ID: <444EF964.30704@argo.co.il>
Date: Wed, 26 Apr 2006 07:39:00 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Alexander Shishckin <alexander.shishckin@gmail.com>
CC: Valdis.Kletnieks@vt.edu, Bongani Hlope <bhlope@mweb.co.za>,
       Kyle Moffett <mrmacman_g4@mac.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Compiling C++ modules
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com>	 <9E05E1FA-BEC8-4FA8-811E-93CBAE4D47D5@mac.com>	 <444E524A.10906@argo.co.il> <200604252211.52474.bhlope@mweb.co.za>	 <444E85E9.70300@argo.co.il>	 <200604252102.k3PL2iQJ013299@turing-police.cc.vt.edu>	 <444E9174.8040909@argo.co.il> <71a0d6ff0604251646g4fc90b3dr30a03b8606360e7f@mail.gmail.com>
In-Reply-To: <71a0d6ff0604251646g4fc90b3dr30a03b8606360e7f@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Apr 2006 04:39:05.0682 (UTC) FILETIME=[599ECB20:01C668EB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Shishckin wrote:
> On 4/26/06, Avi Kivity <avi@argo.co.il> wrote:
>   
>> Not in this case. The constructor is an assignment. The destructor is an
>> if () followed by a delete. In this case, the if () is optimized away so
>> you are left with less generated code than the C case, for the
>> non-exceptional path.
>>     
> Relying on compiler optimisations is just as well stupid as hunting
> trialing writespaces in a dark room miles away.
>   

It'd like to see the output of 'size vmlinux' with optimizations turned 
off. The kernel is full of forwarding functions and constructs that 
optimize away to nothing.

Last time I tried, the kernel wouldn't even compile at -O0, but that may 
have changed with the always_inline work.

And it is *not relying* on compiler optimizations that is stupid. It 
means you're throwing away the work of the compiler folk, and doing it 
instead *by hand* at every piece of code you write.

> It's almost about time to quit this thread and show us some code that
> works. (Forked from 2.6.16, bootable on an average amount of
> architectures...)
>   

Ha ha.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

