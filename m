Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751845AbWBXGCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845AbWBXGCu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 01:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751846AbWBXGCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 01:02:50 -0500
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:9654 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751845AbWBXGCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 01:02:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=fND9oyfatWEpxHGQ28JOP8jt9ch+yrGzA/hkIpYS6qmf5nDJ1+Nxxwv//nAQs+7XS29jJkq9zKUQ0Wt9csw2rmaAS1jPaX+7X52R8pum/xisObWIyKuXomKhjBh0YRY2sWZmyXLizqVVBYXuuMfpcTBIhughK7nOMe/W80LKa7Y=  ;
Message-ID: <43FEA182.2000904@yahoo.com.au>
Date: Fri, 24 Feb 2006 17:02:42 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Emmanuel Pacaud <emmanuel.pacaud@univ-poitiers.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: isolcpus weirdness
References: <1140614487.13155.20.camel@localhost.localdomain>	 <43FDA8DD.2000500@yahoo.com.au>	 <1140700054.8314.44.camel@localhost.localdomain>	 <43FDB910.1080402@yahoo.com.au> <1140703394.8314.59.camel@localhost.localdomain>
In-Reply-To: <1140703394.8314.59.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Emmanuel Pacaud wrote:
> Le vendredi 24 février 2006 à 00:30 +1100, Nick Piggin a écrit :
> 
>>Emmanuel Pacaud wrote: 
>>
>>>There's a difference between isolated cpus and other cpus: by default,
>>>there's almost no activity on isolated ones. That's what I want to be
>>>able to do.
>>>
>>
>>Nothing in kernel-parameters.txt says there will be almost no activity
>>on them. 
> 
> 
> isolcpus=   [KNL,SMP] Isolate CPUs from the general scheduler.
> +         Format: <cpu number>, ..., <cpu number>
> +         This option can be used to specify one or more CPUs
> +         to isolate from the general SMP balancing and scheduling
> +         algorithms.
> 
> If a cpu is isolated from general SMP balancing and scheduling algorithm
> (I know this isolation is not complete), there will be no activity on
> it, no ? Unless one explicitely move one process on this cpu.
> 

Well to me it says that SMP balancing and scheduling algorithms
will not consider tasks on this CPU. Ie. tasks on this CPU will
not be moved to another, or vice versa.

So I don't consider it a bug, but I'm looking at things from a
very scheduler-centric point of view. Perhaps it wouldn't be
unreasonable to exclude init from isolated CPUs at bootup... I
wouldn't be against such a patch.

> At least, that's what I've seen with my 2.6.15 vanilla kernel with
> hyperthreading activated, or with distribution supplied kernel
> (Scientific linux 4).  With these kernels, with isolcpus=n, there's
> almost no activity on cpun.
> 
> My problem is I'm not able to obtain this behaviour with a kernel.org
> 2.6.15 kernel, when HT is disabled, either in BIOS, kernel config or
> acpi=off parameter.
> 

I'm not sure how that would happen, if anything I think it would be
an implementation quirk that you should not rely on.

> 
> 	Emmanuel.
> 
> (FWIW, I'm working on a RTAI setup. Use of isolcpus in the context of a
> realtime setup is explained in their ISOLCPUS document:
> 
> http://cvs.gna.org/cvsweb/vulcano/README.ISOLCPUS?rev=1.6;cvsroot=rtai
> )
> 
> 

Very cool!

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
