Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261601AbULBNBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbULBNBk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 08:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbULBNBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 08:01:40 -0500
Received: from smtp2.netcabo.pt ([212.113.174.29]:47971 "EHLO
	exch01smtp11.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S261601AbULBNBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 08:01:25 -0500
Message-ID: <12808.195.245.190.93.1101992381.squirrel@195.245.190.93>
In-Reply-To: <47441.195.245.190.94.1101978748.squirrel@195.245.190.94>
References: <17532.195.245.190.94.1101829198.squirrel@195.245.190.94>      
    <20041201103251.GA18838@elte.hu>      
    <32831.192.168.1.5.1101905229.squirrel@192.168.1.5>      
    <20041201154046.GA15244@elte.hu> <20041201160632.GA3018@elte.hu>      
    <20041201162034.GA8098@elte.hu>      
    <33059.192.168.1.5.1101927565.squirrel@192.168.1.5>      
    <20041201212925.GA23410@elte.hu> <20041201213023.GA23470@elte.hu>      
    <32788.192.168.1.8.1101938057.squirrel@192.168.1.8>      
    <20041201220916.GA24992@elte.hu>   
    <32786.192.168.1.5.1101940309.squirrel@192.168.1.5>
    <47441.195.245.190.94.1101978748.squirrel@195.245.190.94>
Date: Thu, 2 Dec 2004 12:59:41 -0000 (WET)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-19
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       "Bill Huey" <bhuey@lnxw.com>, "Adam Heath" <doogie@debian.org>,
       "Florian Schmidt" <mista.tapas@gmx.net>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>,
       "Karsten Wiese" <annabellesgarden@yahoo.de>,
       "Gunther Persoons" <gunther_persoons@spymac.com>, emann@mrv.com,
       "Shane Shrybman" <shrybman@aei.ca>, "Amit Shah" <amit.shah@codito.com>,
       "Esben Nielsen" <simlo@phys.au.dk>, "Andrew Morton" <akpm@osdl.org>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20041202125941_28103"
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 02 Dec 2004 13:01:20.0227 (UTC) FILETIME=[0488F330:01C4D86F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_20041202125941_28103
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

>
> Next step is really trying to increase the stress and look after when it
> will break apart. It will not take too long...
>
> First attempts, by just increasing the client count from 16 to 20, are
> leading to what will be the next "horror show" :) CPU tops above 90%, and
> after a couple of minutes running steadly it enters into some kind of
> turbulence and hangs. Yeah, it just freezes completely.
>
> So I guess we're having a lot more food to mangle ;)
>

After a bit of investigation, I've found some evidence that the "horror
show" is primarily due to XRUN fprintf stderr storm. If I simply remove
that fprintf line from jack/drivers/alsa/alsa_driver.c (around line 1084),
I can run more than 20 jack_test3_client's without hosing the system.

Most probably, the main issue is about fprintf(stderr) being called in a
RT thread context. This is a jackd issue, not of RT kernel's. I remember
there's a jack patch, somewhere in the limbo, for queing all printable
messages out of the jackd RT threads.

I think I'm urging for that patch right now, even though I'm probably
pushing all this pressure into real/physical/hard limits ;) OK. I'll look
if I can take that back from the jackit-devel archives and see what I can
do about it.


Back to a latency-trace enabled RT-0V0.7.31-19, and a patched jackd
0.99.17cvs, I've trapped some more traces (on attachment). These were
taken while running some jack_test3 with light stress (10~12 clients, 4
ports each).

Bye now.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

------=_20041202125941_28103
Content-Type: application/x-gzip-compressed;
      name="xruntrace1-2.6.10-rc2-mm3-RT-V0.7.31-19-20041202095337.trc.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
      filename=
     "xruntrace1-2.6.10-rc2-mm3-RT-V0.7.31-19-20041202095337.trc.gz"

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
YOPrSnHS/dtKNhU3+hdkDshTZDgAAA==
------=_20041202125941_28103
Content-Type: application/x-gzip-compressed;
      name="xruntrace1-2.6.10-rc2-mm3-RT-V0.7.31-19-20041202100140.trc.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
      filename=
     "xruntrace1-2.6.10-rc2-mm3-RT-V0.7.31-19-20041202100140.trc.gz"

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
+2kF9kR/jpv9D4lCe944OAAA
------=_20041202125941_28103
Content-Type: application/x-gzip-compressed;
      name="xruntrace1-2.6.10-rc2-mm3-RT-V0.7.31-19-20041202101633.trc.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
      filename=
     "xruntrace1-2.6.10-rc2-mm3-RT-V0.7.31-19-20041202101633.trc.gz"

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
Ljg4AAA=
------=_20041202125941_28103--


