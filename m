Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268039AbUIKAGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268039AbUIKAGU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 20:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268040AbUIKAGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 20:06:20 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:24303 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S268039AbUIKAGS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 20:06:18 -0400
Message-ID: <41424169.3020302@mvista.com>
Date: Fri, 10 Sep 2004 17:06:01 -0700
From: Todd Poynor <tpoynor@mvista.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Bird <tim.bird@am.sony.com>
CC: colin <colin@realtek.com.tw>, David Woodhouse <dwmw2@infradead.org>,
       Paulo Marques <pmarques@grupopie.com>, linux-kernel@vger.kernel.org
Subject: Re: What File System supports Application XIP
References: <009901c4964a$be2468e0$8b1a13ac@realtek.com.tw>	 <4140200B.9060408@grupopie.com> <1094722976.4083.1550.camel@hades.cambridge.redhat.com> <4140865A.5030304@am.sony.com>
In-Reply-To: <4140865A.5030304@am.sony.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Bird wrote:
...
> The patches I've seen require setting the CRAMFS_LINEAR option, to turn on
> linear addressing for cramfs, and CRAMFS_LINEAR_XIP.  The result of these
> is to dispense with compression.

Compression is skipped for the XIP files, which are typically marked via 
the sticky bit.  You'll also need a version of mkcramfs that creates the 
image without compressing those files.

...
> FYI - Here are some rough numbers:
> Time to run shell script which starts TinyX X server and "xsetroot -solid red",
> then shuts down:
> 
> First invocation: Non-XIP 3.195 seconds, XIP 2.035 seconds
> Second invocation: Non-XIP 1.744 seconds, XIP 1.765 seconds
> 
> I think this was on a 133 MHz PPC, but I'm not positive.  In both cases
> the filesystem was in flash.  

It was measured on a 168MHz ARM 925T TI OMAP 1510.

Others' advice that "you probably don't want XIP" is true in most cases. 
  But in producing a battery-operated product with certain requirements 
for performance, power savings (due to reduced RAM requirements), 
startup time (depending on the platform and software stack the 
difference can be significant), etc. XIP is an option chosen by some CE 
designers, who are willing to accept the performance penalty on a 
product that will still run adequately for its intended uses.  It would 
be interesting to see an in-depth analysis of these topics on an actual 
Linux-based product such as a cell phone.  There are, of course, a 
number of ways to address all these issues, not just XIP...

-- 
Todd Poynor
MontaVista Software

