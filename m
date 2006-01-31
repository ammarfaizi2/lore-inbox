Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751454AbWAaUUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbWAaUUE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 15:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbWAaUUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 15:20:04 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:48354 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751454AbWAaUUC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 15:20:02 -0500
Date: Wed, 1 Feb 2006 01:49:16 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Andrew Morton <akpm@osdl.org>, paulmck@us.ibm.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       hch@infradead.org
Subject: Re: [patch 2/2] fix file counting
Message-ID: <20060131201916.GB5633@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060126184010.GD4166@in.ibm.com> <20060126184127.GE4166@in.ibm.com> <20060126184233.GF4166@in.ibm.com> <43D92DD6.6090607@cosmosbay.com> <20060127145412.7d23e004.akpm@osdl.org> <20060127231420.GA10075@us.ibm.com> <20060127152857.32066a69.akpm@osdl.org> <20060130170028.GA6264@in.ibm.com> <43DF3D0D.6080409@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43DF3D0D.6080409@cosmosbay.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2006 at 11:33:49AM +0100, Eric Dumazet wrote:
> Dipankar Sarma a écrit :
> >>Putting an atomic op into the file_free path?
> >
> >Here are some numbers from a 32-way (HT) P4 xeon box with kernbench -
> >
> 
> Hi Dipankar, thank you very much for doing these tests.
> 
> To have an idea of the number of files that are allocated/freed during a 
> kernel build, I added 4 fields in struct files_stat.
> 
> # cat /proc/sys/fs/file-nr
> 153     0       206071  153     755767  755620  5119
> 
> So thats (755767-39169)/(4*60+56) = 2420 files opened per second.
> 
> Number of changes on central atomic_t was :
> (5119-1131)/(4*60+56) = 13 per second.
> 
> 13 atomic ops per second (instead of 2420*2 per second if I had one 
> atomic_t as in your patch), this is certainly not something we can notice 
> in a typical SMP machine... maybe on a big NUMA machine it could be 
> different ?

Depends on what you call big :) The one I ran on is a 2-node NUMA
16(32)-way with HT. I can't find anything bigger than this
in our server farm. On a 8-way ppc64 box too, there was no difference
at all.

Can you think of some non-microbenchish workload with more open/sec ?
I privately pointed out this thread to John Hawkes from SGI to see
if they care about the potential issues. In the mean while,
I will investigate some more.

Thanks
Dipankar

