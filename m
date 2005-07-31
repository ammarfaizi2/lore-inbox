Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261991AbVGaWOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbVGaWOL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 18:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbVGaWOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 18:14:11 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.83]:38031 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S261991AbVGaWMg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 18:12:36 -0400
Message-ID: <42ED4CCF.6020803@andrew.cmu.edu>
Date: Sun, 31 Jul 2005 18:12:31 -0400
From: James Bruce <bruce@andrew.cmu.edu>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Lee Revell <rlrevell@joe-job.com>, Marc Ballarin <Ballarin.Marc@gmx.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
References: <20050730004924.087a7630.Ballarin.Marc@gmx.de> <1122678943.9381.44.camel@mindpipe> <20050730120645.77a33a34.Ballarin.Marc@gmx.de> <1122746718.14769.4.camel@mindpipe> <20050730195116.GB9188@elf.ucw.cz> <1122753864.14769.18.camel@mindpipe> <20050730201049.GE2093@elf.ucw.cz> <42ED32D3.9070208@andrew.cmu.edu> <20050731211020.GB27433@elf.ucw.cz>
In-Reply-To: <20050731211020.GB27433@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Then the second test was probably flawed, possibly because we have
> some more work to do. No display is irrelevant, HZ=100 will still save
> 0.5W with running display. Spinning disk also does not produce CPU
> load (and we *will* want to have disk spinned down). No daemons... if
> some daemon wakes every msec, we want to fix the daemon. 

I was talking about percentage saved; That 5.2% easily drops below 2% 
once other things start sucking up power.  I was thinking that way since 
the percentage saved is what determines the overall battery life 
increase.  You're right in that the absolute power draw difference 
should stay the same, and that seems to be the case is Marc's tests 
(ignoring the brokenness of artsd).

> Kernel defaults are irelevant; distros change them anyway. [But we
> probably want to enable ACPI and cpufreq by default, because that
> matches what 99% of users will use.]

True, but I think a lot of distros treat the values as recommendations. 
  I guess we'll find out what they do with this option soon enough.

>>I have a fixed-framerate app that had to busywait in the days of 2.4.x. 
>> It was nice in 2.6.x to not have to busywait, but with 250HZ that code 
>>will be coming back again.  And unfortunately this app can't be made 
>>variable-framerate, as it is simulating video hardware.  The same goes 
>>for apps playing movies/animations; Sometimes programs just need a 
>>semi-accurate sleep, and can't demand root priveledges to get it.
> 
> I really don't think default HZ in kernel config is such a big
> deal. You'll want to support HZ=100 on 2.6.X, anyway...

Yeah, but if its only the default value for servers and laptops they 
won't normally be running my app.  I'll be truly happy the day I can 
delete all the busy-waiting code, as I think its about the ugliest 
workaround in modern computing.

> defconfig on i386 is Linus' configuration. Maybe server-config and
> laptop-config would be good idea...

Well maybe if we can get enough people who agree then it could happen. 
I think a "laptop-config" and "server-config" file could fit nicely into 
the current arch/*/config/ directory structure.  I'm not sure how those 
defconfig files are kept up to date though.

  - Jim
