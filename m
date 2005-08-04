Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262489AbVHDLub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262489AbVHDLub (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 07:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262494AbVHDLua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 07:50:30 -0400
Received: from mail09.syd.optusnet.com.au ([211.29.132.190]:33937 "EHLO
	mail09.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262489AbVHDLuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 07:50:24 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Gabriel Devenyi <ace@staticwave.ca>
Subject: Re: [ck] [ANNOUNCE] Interbench 0.27
Date: Thu, 4 Aug 2005 21:46:13 +1000
User-Agent: KMail/1.8.2
Cc: ck@vds.kolivas.org, linux-kernel@vger.kernel.org,
       Jake Moilanen <moilanen@austin.ibm.com>
References: <200508031758.31246.kernel@kolivas.org> <200508041004.46675.kernel@kolivas.org> <42F1FF89.5030903@staticwave.ca>
In-Reply-To: <42F1FF89.5030903@staticwave.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508042146.13710.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Aug 2005 21:44, Gabriel Devenyi wrote:
> Hi Con,
>
> You must hate me by now...

No. A bug report is a bug report. I hate the fact that I coded up 2000 lines 
of code and am still suffering from a problem in the same 10 lines that I did 
in version .01. PEBKAC. 

> The "Gaming" benchmark has the same issue with nan coming out of the
> STDEV calculations, probably requires the same fix as before.

Anyway Peter Williams has promised to fix it for me (yay!).

> Secondly, the benchmarking of loops_per_ms is running forever, and I
> managed to determine where its happening.
>
> In calibrate loops you run a while loop and iterate to get 1000 for
> run_time, then you calculate it one more time to ensure it was right
> *however* you put a sleep(1) before that. It seems to seriously skew the
> results, as it consistently adds ~500 to run_time, as run_time is now
> 1500, it jumps back up to redo because of the goto statement, and runs
> the while loop again, continue ad nausium. I added some simple debugging
> output which prints run time at the end of each while loop, and right
> before the goto if statement, this is the output.

> The solution I used is of course to simply comment out the sleep
> statement, then everything works nicely, however your comments appear to
> indicate that the sleep is there to make the system settle a little,
> perhaps another method needs to be used. Thanks for your time!

I have to think about it. This seems a problem only on one type of cpu for 
some strange reason (lemme guess; athlon?) and indeed leaving out the sleep 1 
followed by the check made results far less reliable. This way with the sleep 
1 I have not had spurious results returned by the calibration. I'm open to 
suggestions if anyone's got one.

Cheers,
Con
