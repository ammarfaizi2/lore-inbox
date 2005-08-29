Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750999AbVH2NZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbVH2NZv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 09:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbVH2NZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 09:25:51 -0400
Received: from lmv.inov.pt ([146.193.64.2]:25867 "EHLO lmv.inov.pt")
	by vger.kernel.org with ESMTP id S1750956AbVH2NZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 09:25:50 -0400
Message-ID: <43130CCC.3070802@inov.pt>
Date: Mon, 29 Aug 2005 14:25:32 +0100
From: Jose Miguel Goncalves <jose.goncalves@inov.pt>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050322
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hiroshi Miura <miura@da-cha.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problem with cpufreq on Geode GX1
References: <430F5901.2070606@inov.pt> <87mzn22u5k.wl%miura@da-cha.org>
In-Reply-To: <87mzn22u5k.wl%miura@da-cha.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hiroshi,

Here goes the extra info that you asked for:

$ cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
performance
$ cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
300759
$ cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq
300759
$ echo powersave > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
$ cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
powersave
$ cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
23042
$ cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq
23042

One other strange thing that I've noticed is that I'll never get the same
frequency when switching to powersave govenor. It allways gets increased a
little bit. For example:

$ echo powersave > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
$ cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
24453
$ echo powersave > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
$ cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
27779
$ echo powersave > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
$ cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
29947
$ echo powersave > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
$ cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
32400

Thanks for checking this.

Jose Goncalves


Hiroshi Miura wrote:
> Hi,
> 
> I will check code in several days, but I cannot re-produce a problem in a moment
> because I am away from home for business trip.
> 
> In my understand, the driver recognize the CPU properly. 
> 
> At Fri, 26 Aug 2005 19:01:37 +0100,
> Jose Miguel Goncalves wrote:
> 
>>Hi all,
>>
>>I'm trying to use cpufreq on my Geode GX1 board with linux-2.6.12.5, but,
>>while everything seems OK, i.e., I can change from performance to powersave
>>governor and back and /proc/cpuinfo reports me frequency changes, I can
>>get no effective frequency/CPU power change because I check it with
>>the Whetstone benchmark and it allways give me the same value (~100 MWIPS).
>>Any ideas from were could be the problem?
> 
> 
> Can you try to check also follows?
> 
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
> /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq
> 
> With this driver, it will significantly slow down by setting powersave mode.
> It seems some bus in the driver.
> 
> Thank you for report.
> 
> Hiroshi
> 
