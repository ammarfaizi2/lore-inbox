Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287875AbSABRxS>; Wed, 2 Jan 2002 12:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287871AbSABRxI>; Wed, 2 Jan 2002 12:53:08 -0500
Received: from web1.oops-gmbh.de ([212.36.232.3]:14340 "EHLO
	sabine.freising-pop.de") by vger.kernel.org with ESMTP
	id <S287870AbSABRwx>; Wed, 2 Jan 2002 12:52:53 -0500
Message-ID: <3C334762.CDC5FC34@sirius-cafe.de>
Date: Wed, 02 Jan 2002 18:46:10 +0100
From: Martin Knoblauch <knobi@sirius-cafe.de>
Reply-To: knobi@knobisoft.de
Organization: Knobisoft :-), Freising
X-Mailer: Mozilla 4.6 [en] (X11; I; IRIX 6.5 IP22)
X-Accept-Language: en
MIME-Version: 1.0
To: Steinar Hauan <hauan@cmu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: smp cputime issues
In-Reply-To: <Pine.GSO.4.33L-022.0201020832230.1894-100000@unix12.andrew.cmu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steinar Hauan wrote:
> 
> On Wed, 2 Jan 2002, Martin Knoblauch wrote:
> >  two points. First for clarification - do you see the effects also on
> > elapsed time? Or do you say that the CPU time reporting is screwed?
> 
> wall clock time is consistent with (cpu time) x (%utilization)
>

 OK, just asked to make sure I didn't misunderstand.
 
> >  Second - you mention that you see the effect mainly on linear algebra
> > stuff. Could it be that you are memory bandwidth limited if you run two
> > of them together? Are you using Intel CPUs (my guess) which have the FSB
> > concept that may make memory bandwidth scaling a problem, or AMD Athlons
> > which use the Alpha/EV6 bus and should be a bit more friendly.
> 
> these results are on Intel p3 and (p4) xeon cpu's, yes.
>

 OK, that is what I almost guessed.
 
> >  Finally, how big is "1/10th of physical" memory? What kind of memory.
> 
> the effects are reproducible with runs of size down to 40mb.
> (i've made a toy problem that runs in ~2 mins to isolate the effect)
> 
> i've used 4 machine types
> 
>   p3 800mhz @ apollo pro 133 with 1gb pc133 ecc mem
>   p3 1ghz @ apollo pro 266 with 1gb pc2100 ddr mem
>   p3 1ghz @ serverworks LE with 2gb pc133 reg ecc mem
> 
> for all of the above, the reported cpu usage is +25%. on the machine
> 
>   p4 xeon 1.7ghz @ intel i860 with 500mb pc800 reg ecc rdram
> 
> the effect is less pronounced (5-6%), thus confirming that memory
> bandwidth may be an issue. still, if that's the case; there's a
> significant difference in bandwith between the other 3 machines.
> (the serverworks chipset has dual channels)
> 

 You are probably not bound by the bandwidth between memory and the
"chipset", but the bandwidth on the FSB (or between FSB and Chipset).
This would explain why the Serverworks LE doesn't give you better
scaling than the other P3 systems.

 The P4 has a much higher FSB speed (400 MHz vs. 100/133 MHz). As a
result it has more headroom for scaling. You could look ath the Streams
results for an indicator.

http://www.cs.virginia.edu/stream/

 The P4s definitely show the best numbers in the "PC" category, a LOT
better than any P3 result, which seem to max out at about 450 MB/sec.
Unfortunatelly no dual entries.

Dell_8100-1500                     1   2106.0   2106.0   2144.0   2144.0
Intel_STL2-PIII-933                1    423.0    419.0    517.0    517.0
Intel_440BX-2_PIII-650             1    455.0    421.0    501.0    500.0

 It would be interesting to see your test performed on a dual Athlon
(comparable speed to the P4). There seems to be evidence that they scale
better for scientific stuff, although the streams results do not show a
very good scaling.

AMD_Athlon_1200                    2    922.0    916.4   1051.7   1053.4
AMD_Athlon_1200                    1    726.8    711.8    860.1    851.4

http://www.amdzone.com/releaseview.cfm?ReleaseID=764 (as a reference for
better Athlon scaling).

Martin
-- 
+-----------------------------------------------------+
|Martin Knoblauch                                     |
|-----------------------------------------------------|
|http://www.knobisoft.de/cats                         |
|-----------------------------------------------------|
|e-mail: knobi@knobisoft.de                           |
+-----------------------------------------------------+
