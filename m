Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261554AbVGYUKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbVGYUKt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 16:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbVGYUKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 16:10:20 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:21256 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261560AbVGYUKH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 16:10:07 -0400
Message-ID: <42E54813.5050202@tmr.com>
Date: Mon, 25 Jul 2005 16:14:11 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marc Ballarin <Ballarin.Marc@gmx.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Power consumption HZ250 vs. HZ1000
References: <20050725161333.446fe265.Ballarin.Marc@gmx.de>
In-Reply-To: <20050725161333.446fe265.Ballarin.Marc@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Ballarin wrote:
> Hi,
> I did some measurements in order to compare power drain with HZ250 and
> HZ1000.
> To measure the actual drain, I used the "smart" battery's internal measurement.
> (Available with acpi-sbs in /proc/acpi/sbs/SBS0/SB0/state.)
> No clue how accurate this is.
> 
> Here some battery details, in case someone knows:
> charge reporting error:  25%
> SB specification:        v1.1 (with PEC)
> manufacturer name:       Panasonic
> manufacture date:        2004-11-27
> device name:             02ZL
> device chemistry:        Lion
> 
> Kernel: 2.6.13-rc3-mm1 + acpi-sbs
> 
> CPU:
> cpu family	: 6
> model		: 13
> model name	: Intel(R) Pentium(R) M processor 1.60GHz
> stepping		: 6
> 
> The "ondemand" governor was running, using acpi_cpufreq. (Idle at 600MHz).
> 
> Systems was running X11/KDE to get a more or less realistic scenario. No
> cron jobs, network traffic or additional applications. WLAN and built-in
> display were disabled completely, all fans and LEDs were off, internal hard
> disc was running. Additional peripherals: external keyboard, mouse, display
> and externally-powered hard disk (USB).
> 
> The results are quite simple:
> In both configurations the current settles between 727-729 mA
> (Voltage ~16.5 V).
> 
> Some issues:
> 
> - C-states look strange:
> active state:            C2
> max_cstate:              C8
> bus master activity:     00887fff
> states:
>     C1:                  type[C1] promotion[C2] demotion[--]   latency[000] usage[00000010]
>   *C2:                  type[C2] promotion[C3] demotion[C1] latency[001] usage[01367471]
>     C3:                  type[C3] promotion[--]   demotion[C2] latency[085] usage[00000000]
> 
> - I don't know, how much polling of the battery affects results. Reads always
> block for ~10 seconds, and I used this behaviour for rate-limiting.
> 
> - Is this approach valid at all?
> 
> - I could repeat the test in single user mode with internal hard disc turned off.
> 
I think what you did is the most valid test. Testing with any 
configuration other than the one you actually use may give some specious 
appearance of saving, but unless you actually use the system in the 
reduced configuration I don't see how you would save anything by going 
to the lower clock.

A configuration without any external kb/mouse connections would be 
something which many people do use, so that would be meaningful to some 
people if not you. I'm guessing it won't change much, but to satisfy the 
people who think USB precludes power saving you could make the test.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
