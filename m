Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268246AbTBYRn7>; Tue, 25 Feb 2003 12:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268244AbTBYRnq>; Tue, 25 Feb 2003 12:43:46 -0500
Received: from holomorphy.com ([66.224.33.161]:61622 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S268232AbTBYRmn>;
	Tue, 25 Feb 2003 12:42:43 -0500
Date: Tue, 25 Feb 2003 09:51:55 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: check cpu_online() in nr_running()
Message-ID: <20030225175155.GB10411@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030225163335.GD10396@holomorphy.com> <1046197963.4055.15.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1046197963.4055.15.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-02-25 at 16:33, William Lee Irwin III wrote:
>>  	for (i = 0; i < NR_CPUS; i++)
>> +		if (!cpu_online(i))
>> +			continue;
>>  		sum += cpu_rq(i)->nr_running;

On Tue, Feb 25, 2003 at 06:32:43PM +0000, Alan Cox wrote:
> I smell donkey poo 8)

I don't really like how this stuff got arranged either.

On Tue, Feb 25, 2003 at 06:32:43PM +0000, Alan Cox wrote:
> If the change is right, which seems reasonable then I think you
> need some { } 's too. Its also a hot path so it may be a lot
> cleaner to keep the jump out of this by just letting
> nr_running be zero for other processors ?

AFAICT its only usages are in /proc/ reporting and loadavg calculation,
which aren't hotpaths per-se, but shouldn't explode in complexity.
Similar things could be said for nr_uninterruptible() and nr_iowait(),
but some kind of unusual constraint is involved wrt. hotplug.

-- wli
