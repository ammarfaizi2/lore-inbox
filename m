Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261451AbTAQX4p>; Fri, 17 Jan 2003 18:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261568AbTAQX4p>; Fri, 17 Jan 2003 18:56:45 -0500
Received: from impact.colo.mv.net ([199.125.75.20]:4019 "EHLO
	impact.colo.mv.net") by vger.kernel.org with ESMTP
	id <S261451AbTAQX4o>; Fri, 17 Jan 2003 18:56:44 -0500
Message-ID: <3E289A53.40203@bogonomicon.net>
Date: Fri, 17 Jan 2003 18:05:39 -0600
From: Bryan Andersen <bryan@bogonomicon.net>
Organization: Bogonomicon
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21-pre3-ac4 oops in free_pages_ok
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I too have been seeing this oops crash problem.  I can
consistantly reproduce mine by running:

   $ mke2fs -c -j -i 16768 /dev/hdc6

The interesting thing is running:

   $ mke2fs -j -i 16768 /dev/hdc6

does not cause an oops crash.  The only difference being
the bad block scan.

These are the outputs of ksymoops for the stack trace part
of the oops output from.  Kernel version is
linux-2.4.21-pre3-ac4.

Adhoc c013f4b7 <try_to_free_buffers+c7/140>
Adhoc c013d8c9 <try_to_release_page+49/50>
Adhoc c01348ac <__free_pages+1c/20>
Adhoc c0133863 <shrink_cache+383/3b0>
Adhoc c01339f6 <shrink_caches+56/80>
Adhoc c0133a5c <try_to_free_pages_zone+3c/60>
Adhoc c013452e <balance_classzone+5e/1d0>
Adhoc c01347b2 <__alloc_pages+112/160>
Adhoc c012ebc1 <generic_file_write+3f1/710>
Adhoc c01344c6 <_alloc_pages+16/20>
Adhoc c012ebdd <generic_file_write+40d/710>
Adhoc c013b316 <sys_write+96/110>
Adhoc c0106f8b <system_call+33/38>

Adhoc c0134239 <__free_pages_ok+279/2a0>

I'm going to do further tests with the generic IDE
driver instead of the NVIDIA one.  Then I plan on
teasing out the NVIDIA2 specific stuff from the ac4
patch and only applying them to a pre3 patched kernel.

- Bryan

