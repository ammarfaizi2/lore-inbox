Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932633AbWBTWMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932633AbWBTWMN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 17:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932639AbWBTWMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 17:12:13 -0500
Received: from lucidpixels.com ([66.45.37.187]:17544 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S932633AbWBTWML (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 17:12:11 -0500
Date: Mon, 20 Feb 2006 17:12:09 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: Jesse Brandeburg <jesse.brandeburg@gmail.com>
cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: Intel CSA Gigabit Bug in IC7-G Motherboards- Affects Windows/Linux
In-Reply-To: <4807377b0602192359g39c3a2fbnffaead2694788783@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0602201709510.3941@p34>
References: <Pine.LNX.4.64.0602191807001.7212@p34>  <1140392860.2733.433.camel@mindpipe>
  <Pine.LNX.4.64.0602191848230.7212@p34> <4807377b0602192359g39c3a2fbnffaead2694788783@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dreadful Denial of Service!!

Here is the story.

1) NAPI = ENABLED, The kernel does not crash IMMEDIATELY.
2) NAPI = DISABLED, KILLS THE VIDEO, FORCES AN IMMEDIATE REBOOT OF THE BOX

Note: When I leave the cp trying to copy the death.dat, my box hangs, will 
not come up, has other problems UNTIL I disconnect or reboot the box that 
originally did the cp file /nfs/directory.

The good: I got a dump of what was in dmesg before it locked up in #1.
The bad: I could do nothing in #2, it simply was like someone pressed the 
reboot button on my machine!!!

Here is the log:

$ cp .stuff/mobo/death.dat /p34/x

.. then I get these in dmesg ..

   then > 60 seconds the box is frozen

.. ..



Here is from part #1:

[  251.277315] e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
[  251.277317]   TDH                  <af>
[  251.277318]   TDT                  <b3>
[  251.277319]   next_to_use          <b3>
[  251.277320]   next_to_clean        <af>
[  251.277320] buffer_info[next_to_clean]
[  251.277321]   dma                  <36970802>
[  251.277322]   time_stamp           <ffff4113>
[  251.277323]   next_to_watch        <af>
[  251.277324]   jiffies              <ffff485c>
[  251.277325]   next_to_watch.status <0>
[  253.274703] e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
[  253.274704]   TDH                  <af>
[  253.274706]   TDT                  <b3>
[  253.274706]   next_to_use          <b3>
[  253.274707]   next_to_clean        <af>
[  253.274708] buffer_info[next_to_clean]
[  253.274709]   dma                  <36970802>
[  253.274710]   time_stamp           <ffff4113>
[  253.274711]   next_to_watch        <af>
[  253.274712]   jiffies              <ffff502d>
[  253.274713]   next_to_watch.status <0>
[  255.270969] e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
[  255.270971]   TDH                  <af>
[  255.270972]   TDT                  <b3>
[  255.270973]   next_to_use          <b3>
[  255.270974]   next_to_clean        <af>
[  255.270975] buffer_info[next_to_clean]
[  255.270976]   dma                  <36970802>
[  255.270977]   time_stamp           <ffff4113>
[  255.270978]   next_to_watch        <af>
[  255.270979]   jiffies              <ffff57fc>
[  255.270980]   next_to_watch.status <0>
[  257.267361] e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
[  257.267363]   TDH                  <af>
[  257.267364]   TDT                  <b3>
[  257.267365]   next_to_use          <b3>
[  257.267366]   next_to_clean        <af>
[  257.267367] buffer_info[next_to_clean]
[  257.267368]   dma                  <36970802>
[  257.267369]   time_stamp           <ffff4113>
[  257.267370]   next_to_watch        <af>
[  257.267371]   jiffies              <ffff5fcc>
[  257.267372]   next_to_watch.status <0>
[  258.248353] NETDEV WATCHDOG: eth0: transmit timed out
[  261.321533] e1000: eth0: e1000_watchdog_task: NIC Link is Up 1000 Mbps 
Full Duplex



On Sun, 19 Feb 2006, Jesse Brandeburg wrote:

> On 2/19/06, Justin Piszcz <jpiszcz@lucidpixels.com> wrote:
>> Essentially, when you copy large amounts of data across the NIC it will
>> "freeze" the box in Linux (any 2.6.x kernel, have not tried 2.4.x) or
>> Windows XP SP2.
>
> I've heard isolated reports about issues with the CSA connected NIC,
> but we've not been able to reproduce much in our labs and (mostly)
> people haven't been complaining about it.
>
>> If you checkout the thread, it occurs for multiple people under various
>> OS' but in *some* cases if they use ABIT's IC7-G CSA/INTEL driver, they
>> their problems go away.
>
>> In Linux when I used to use the onboard NIC, it froze the box, I did not
>> have sysrq enabled at the time when this happened but frozen I mean screen
>> is frozen, no ping, box is inoperative.
>
> Have you tried running without NAPI? (disable it in your config in the
> e1000 section)
>
>> Nothing pecuilar was ever found in any of the logs or dmesg output
>> regarding the crash.
>>
>> Basically its the first revision of CSA gigabit on a motherboard from what
>> I read in the forums and unless you use ABIT's specially crafted driver,
>> it will crash the machine when you copy either:
>>
>> a) large amounts of data over a gigabit link
>> or
>> b) that death.zip file (unzipped of course) which contains the bad "bits"
>> that are probably seen/repeated when copying large amounts of data
>
> I'll have our lab attempt to reproduce the bug (again) this time using
> the special file.  I can't speak to the windows crash, sorry.
>
> please send your .config, cat /proc/interrupts, dmesg after driver is
> up, whether NAPI is on, what exact steps you use to reproduce the
> problem, what your environment is (i.e. copying to a windows server,
> etc) pretty much follow the instructions in
> http://www.kernel.org/pub/linux/docs/lkml/reporting-bugs.html
>
> Jesse
>
