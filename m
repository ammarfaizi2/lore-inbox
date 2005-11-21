Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932487AbVKUXjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbVKUXjN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 18:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbVKUXjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 18:39:12 -0500
Received: from smtp1.Stanford.EDU ([171.67.16.123]:3001 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S932487AbVKUXjK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 18:39:10 -0500
Subject: Re: test time-warps [was: Re: 2.6.14-rt13]
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@us.ibm.com>,
       "K.R. Foley" <kr@cybsft.com>, Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>, pluto@agmk.net,
       john cooper <john.cooper@timesys.com>,
       Benedikt Spranger <bene@linutronix.de>,
       Daniel Walker <dwalker@mvista.com>,
       Tom Rini <trini@kernel.crashing.org>,
       George Anzinger <george@mvista.com>
In-Reply-To: <20051121221941.GA11102@elte.hu>
References: <20051115090827.GA20411@elte.hu>
	 <1132608728.4805.20.camel@cmn3.stanford.edu>
	 <20051121221511.GA7255@elte.hu>  <20051121221941.GA11102@elte.hu>
Content-Type: text/plain
Date: Mon, 21 Nov 2005 15:38:21 -0800
Message-Id: <1132616301.4805.63.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-21 at 23:19 +0100, Ingo Molnar wrote:
> * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> > I just had a short burst of key repeats and saw one random screen 
> > blank. Right now everything seems normal but I was not allucinating 
> > :-)
> 
> is this on the dual-core X2 box, running 32-bit code? Did it happen with 
> idle=poll? Without idle=poll the TSCs run apart and a number of 
> artifacts may happen. With idle=poll specified the TSC _should_ be fully 
> synchronized.
> 
> To make sure could you run the attached time-warp-test utility i wrote 
> today? Compile it with:
> 
>   gcc -Wall -O2 -o time-warp-test time-warp-test.c
> 
> it detects and reports time-warps (and does a maximum search for them 
> over time, that way you can see systematic drifts too). (It auto-detects 
> the # of CPUs and runs the appropriate number of tasks.)

Ok, here are some test runs:

Athlon X2, 2.6.14-rt13, __not__ booting idle=poll
cat /sys/devices/system/clocksource/clocksource0/clocksource 
  acpi_pm jiffies *tsc pit

[hacked Jack with gettimeofday fails with "delay exceeded..." messages]

# ./time-warp-test #CPUs: 2
running 2 tasks to check for time-warps.
warp ..  -2735313 cycles, ... 000014b9f770036f -> 000014b9f746469e ?
WARP ..     -1224 usecs, .... 0004061b6acd7dc6 -> 0004061b6acd78fe ?
WARP ..     -1237 usecs, .... 0004061b6acd7e07 -> 0004061b6acd7932 ?
warp ..  -2735317 cycles, ... 000014b9f7773a97 -> 000014b9f74d7dc2 ?
WARP ..     -1238 usecs, .... 0004061b6acd7e65 -> 0004061b6acd798f ?
warp ..  -2736775 cycles, ... 000014b9f77a9bd0 -> 000014b9f750d949 ?
warp ..  -2736848 cycles, ... 000014b9f77c83aa -> 000014b9f752c0da ?
warp ..  -2736953 cycles, ... 000014b9f77e82a6 -> 000014b9f754bf6d ?
warp ..  -2737060 cycles, ... 000014b9f7831875 -> 000014b9f75954d1 ?
warp ..  -2737090 cycles, ... 000014b9f792d70b -> 000014b9f7691349 ?
warp ..  -2737265 cycles, ... 000014b9f79c9509 -> 000014b9f772d098 ?
warp ..  -2737387 cycles, ... 000014ba0129c8e7 -> 000014ba010003fc ?
warp ..  -2737405 cycles, ... 000014ba0b696ad1 -> 000014ba0b3fa5d4 ?
WARP .. -4398045268 usecs, .... 0004061c70fdbd6e -> 0004061b6ad8e51a ?
WARP .. -4398045269 usecs, .... 0004061c70fdbe56 -> 0004061b6ad8e601 ?
warp ..  -2737407 cycles, ... 000014c0f4960dfd -> 000014c0f46c48fe ?
warp ..  -2737435 cycles, ... 000014c100f929b5 -> 000014c100cf649a ?
warp ..  -2737450 cycles, ... 000014ef1eff0250 -> 000014ef1ed53d26 ?
warp ..  -2737470 cycles, ... 000014ef2a976748 -> 000014ef2a6da20a ?
warp ..  -2737472 cycles, ... 000014ef98ee8f62 -> 000014ef98c4ca22 ?
warp ..  -2737494 cycles, ... 000014efac5b0d44 -> 000014efac3147ee ?
warp ..  -2737506 cycles, ... 000014f42d48833f -> 000014f42d1ebddd ?
WARP .. -4398046507 usecs, .... 0004061c788544c5 -> 0004061b7260679a ?
warp ..  -2737535 cycles, ... 000014ffb2b84ca9 -> 000014ffb28e872a ?
warp ..  -2737678 cycles, ... 0000150b8cae9ad3 -> 0000150b8c84d4c5 ?
warp ..  -2737847 cycles, ... 0000153e388bc05d -> 0000153e3861f9a6 ?
warp ..  -2737851 cycles, ... 0000153e3b472185 -> 0000153e3b1d5aca ?
warp ..  -2737871 cycles, ... 0000153e3b94270d -> 0000153e3b6a603e ?
warp ..  -2737872 cycles, ... 0000153e3c3d4034 -> 0000153e3c137964 ?
warp ..  -2737891 cycles, ... 0000153e51313527 -> 0000153e51076e44 ?
warp ..  -2737935 cycles, ... 0000153e55df386a -> 0000153e55b5715b ?
warp ..  -2737987 cycles, ... 0000153ec3280132 -> 0000153ec2fe39ef ?
warp ..  -2738044 cycles, ... 00001542b6d5c7bd -> 00001542b6ac0041 ?
warp ..  -2738056 cycles, ... 0000154332e5f8dd -> 0000154332bc3155 ?
warp ..  -2738059 cycles, ... 000015433aa0e85b -> 000015433a7720d0 ?
warp ..  -2738087 cycles, ... 0000154363eb9eb5 -> 0000154363c1d70e ?
warp ..  -2738100 cycles, ... 00001547a3407554 -> 00001547a316ada0 ?
warp ..  -2738101 cycles, ... 00001547a342315e -> 00001547a31869a9 ?
warp ..  -2738131 cycles, ... 00001547a36dca74 -> 00001547a34402a1 ?
warp ..  -2738251 cycles, ... 00001547a67672fd -> 00001547a64caab2 ?
warp ..  -2738253 cycles, ... 0000154811d20a22 -> 0000154811a841d5 ?
warp ..  -2738261 cycles, ... 00001548bd4fe888 -> 00001548bd262033 ?
warp ..  -2738270 cycles, ... 00001549e8ba9459 -> 00001549e890cbfb ?
warp ..  -2738284 cycles, ... 0000154bca42c59f -> 0000154bca18fd33 ?
warp ..  -2738287 cycles, ... 0000154c15d10b04 -> 0000154c15a74295 ?
warp ..  -2738393 cycles, ... 00001559054f8a3b -> 000015590525c162 ?
warp ..  -2738445 cycles, ... 00001559055cd294 -> 0000155905330987 ?
warp ..  -2738462 cycles, ... 00001559057d79e3 -> 000015590553b0c5 ?
warp ..  -2738482 cycles, ... 00001559221f9b08 -> 0000155921f5d1d6 ?
warp ..  -2738486 cycles, ... 000015593f6a2298 -> 000015593f405962 ?
warp ..  -2738602 cycles, ... 000015594da97b42 -> 000015594d7fb198 ?
warp ..  -2738607 cycles, ... 0000155a41e90e62 -> 0000155a41bf44b3 ?
warp ..  -2738621 cycles, ... 0000155e0f15910d -> 0000155e0eebc750 ?
warp ..  -2738650 cycles, ... 0000155f746123f6 -> 0000155f74375a1c ?
warp ..  -2738653 cycles, ... 000015610cbc0276 -> 000015610c923899 ?
warp ..  -2738655 cycles, ... 0000156241a4f73a -> 00001562417b2d5b ?

Now with 
cat /sys/devices/system/clocksource/clocksource0/clocksource 
  *acpi_pm jiffies tsc pit

[hacked Jack with gettimeofday works fine]

# ./time-warp-test
#CPUs: 2
running 2 tasks to check for time-warps.
warp ..  -2709892 cycles, ... 000015870e3c5333 -> 000015870e12f9af ?
warp ..  -2709931 cycles, ... 000015870e611d33 -> 000015870e37c388 ?
warp ..  -2714592 cycles, ... 000015871b20ef38 -> 000015871af78358 ?
warp ..  -2714599 cycles, ... 0000158727b08141 -> 000015872787155a ?
warp ..  -2714610 cycles, ... 00001587341f8c9c -> 0000158733f620aa ?
warp ..  -2714611 cycles, ... 0000158740a746a4 -> 00001587407ddab1 ?
warp ..  -2714632 cycles, ... 000015874d202559 -> 000015874cf6b951 ?
warp ..  -2714672 cycles, ... 000015875aa36481 -> 000015875a79f851 ?
warp ..  -2714674 cycles, ... 000015876eabae9b -> 000015876e824269 ?
warp ..  -2714676 cycles, ... 0000158c00b9eec1 -> 0000158c0090828d ?
warp ..  -2714851 cycles, ... 000015a87d87fdf7 -> 000015a87d5e9114 ?
warp ..  -2714868 cycles, ... 000015a91f8611c6 -> 000015a91f5ca4d2 ?
warp ..  -2714900 cycles, ... 000015d4abcac875 -> 000015d4aba15b61 ?
warp ..  -2714932 cycles, ... 000016722ed1bafe -> 000016722ea84dca ?
warp ..  -2714933 cycles, ... 000016722edb5d24 -> 000016722eb1efef ?
warp ..  -2714960 cycles, ... 000016722edf16d0 -> 000016722eb5a980 ?
warp ..  -2715093 cycles, ... 0000167241711403 -> 000016724147a62e ?
warp ..  -2715369 cycles, ... 0000167254f44d20 -> 0000167254cade37 ?
warp ..  -2715372 cycles, ... 000016727c056ff2 -> 000016727bdc0106 ?
warp ..  -2715382 cycles, ... 0000167294580d33 -> 00001672942e9e3d ?
warp ..  -2715386 cycles, ... 00001672acf231c5 -> 00001672acc8c2cb ?
warp ..  -2715394 cycles, ... 00001672c5a30efc -> 00001672c5799ffa ?
warp ..  -2715397 cycles, ... 00001672f3946ebc -> 00001672f36affb7 ?
warp ..  -2715417 cycles, ... 000016733b4806b8 -> 000016733b1e979f ?
warp ..  -2715464 cycles, ... 00001675810adae0 -> 0000167580e16b98 ?
warp ..  -2715471 cycles, ... 0000174825657d7a -> 00001748253c0e2b ?

I both cases messages seem to come in bunches. I get 5 to 15 on startup
of the test no matter what. After that it is more sporadic. 

-- Fernando


