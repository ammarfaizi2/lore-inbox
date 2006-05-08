Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWEHLiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWEHLiW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 07:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWEHLiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 07:38:22 -0400
Received: from fw5.argo.co.il ([194.90.79.130]:40719 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S932081AbWEHLiW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 07:38:22 -0400
Message-ID: <445F2DAA.30301@argo.co.il>
Date: Mon, 08 May 2006 14:38:18 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: rmk+lkml@arm.linux.org.uk
CC: Arjan van de Ven <arjan@infradead.org>,
       Erik Mouw <erik@harddisk-recovery.com>, Andrew Morton <akpm@osdl.org>,
       Jason Schoonover <jasons@pioneer-pra.com>, linux-kernel@vger.kernel.org
Subject: Re: High load average on disk I/O on 2.6.17-rc3
References: <200605051010.19725.jasons@pioneer-pra.com> <20060507095039.089ad37c.akpm@osdl.org> <20060508111345.GA1875@harddisk-recovery.com> <1147087356.2888.9.camel@laptopd505.fenrus.org> <20060508112831.GA14206@flint.arm.linux.org.uk>
In-Reply-To: <20060508112831.GA14206@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 May 2006 11:38:19.0909 (UTC) FILETIME=[E7AA3B50:01C67293]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> Why do you think that?  exim uses the load average to work out whether
> it's a good idea to spawn more copies of itself, and increase the load
> on the machine.
>
> Unfortunately though, under 2.6 kernels, the load average seems to be
> a meaningless indication of how busy the system is from that point of
> view.
>
> Having a single CPU machine with a load average of 150 and still feel
> very interactive at the shell is extremely counter-intuitive.
>   

It's even worse: load average used to mean the number of runnable 
processes + number of processes waiting on disk or NFS I/O to complete, 
a fairly bogus measure as you have noted, but with the aio interfaces 
one can issue enormous amounts of I/O without it being counted in the 
load average.

To make such decisions real, one needs separate counters for cpu load 
and for disk load on the devices one is actually using.

-- 
error compiling committee.c: too many arguments to function

