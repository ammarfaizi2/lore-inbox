Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264907AbTASKw6>; Sun, 19 Jan 2003 05:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264986AbTASKw6>; Sun, 19 Jan 2003 05:52:58 -0500
Received: from impact.colo.mv.net ([199.125.75.20]:19124 "EHLO
	impact.colo.mv.net") by vger.kernel.org with ESMTP
	id <S264907AbTASKw5>; Sun, 19 Jan 2003 05:52:57 -0500
Message-ID: <3E2A85A3.4090402@bogonomicon.net>
Date: Sun, 19 Jan 2003 05:01:55 -0600
From: Bryan Andersen <bryan@bogonomicon.net>
Organization: Bogonomicon
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21-pre3-ac4 oops in free_pages_ok
References: <3E289A53.40203@bogonomicon.net>
In-Reply-To: <3E289A53.40203@bogonomicon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As I thought and others felt too.  It looks like the -ac4
patch for 2.4.21-pre3 has some error in it that causes an
oops.  I've tested a 2.4.21-pre3 with only the nvidia2
related patches from -ac4 added to it and it appears to be
stable.  A few kernel comples and 53 mke2fs with bad block
scan runs and it stayed up.  I'm now running memtest86 over
night to be pedantic that it isn't a memory error.  Sofar
it passed the first pass of the tests, we'll see what
happens over night.

What are some good system abuse test suites?  In the past
I've used kernel compiles in an endless loop.  I'd do one
run then compare the outputs from each run to the first
run.  Any difference constitutes a failure.

Bryan Andersen wrote:
> I too have been seeing this oops crash problem.  I can
> consistantly reproduce mine by running:
> 
>   $ mke2fs -c -j -i 16768 /dev/hdc6
> 
> The interesting thing is running:
> 
>   $ mke2fs -j -i 16768 /dev/hdc6
> 
> does not cause an oops crash.  The only difference being
> the bad block scan.
> 
> These are the outputs of ksymoops for the stack trace part
> of the oops output from.  Kernel version is
> linux-2.4.21-pre3-ac4.
> 
> Adhoc c013f4b7 <try_to_free_buffers+c7/140>
> Adhoc c013d8c9 <try_to_release_page+49/50>
> Adhoc c01348ac <__free_pages+1c/20>
> Adhoc c0133863 <shrink_cache+383/3b0>
> Adhoc c01339f6 <shrink_caches+56/80>
> Adhoc c0133a5c <try_to_free_pages_zone+3c/60>
> Adhoc c013452e <balance_classzone+5e/1d0>
> Adhoc c01347b2 <__alloc_pages+112/160>
> Adhoc c012ebc1 <generic_file_write+3f1/710>
> Adhoc c01344c6 <_alloc_pages+16/20>
> Adhoc c012ebdd <generic_file_write+40d/710>
> Adhoc c013b316 <sys_write+96/110>
> Adhoc c0106f8b <system_call+33/38>
> 
> Adhoc c0134239 <__free_pages_ok+279/2a0>
> 
> I'm going to do further tests with the generic IDE
> driver instead of the NVIDIA one.  Then I plan on
> teasing out the NVIDIA2 specific stuff from the ac4
> patch and only applying them to a pre3 patched kernel.
> 
> - Bryan
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

