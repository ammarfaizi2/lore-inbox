Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318911AbSHEWPH>; Mon, 5 Aug 2002 18:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318912AbSHEWPH>; Mon, 5 Aug 2002 18:15:07 -0400
Received: from pdbn-d9b8ca79.pool.mediaWays.net ([217.184.202.121]:13321 "EHLO
	korben.citd.de") by vger.kernel.org with ESMTP id <S318911AbSHEWPC>;
	Mon, 5 Aug 2002 18:15:02 -0400
Date: Tue, 6 Aug 2002 00:17:26 +0200
From: Matthias Schniedermeyer <ms@citd.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Heavy Clock-Drift after update from Kernel 2.4.9 to 2.4.19
Message-ID: <20020805221726.GA22331@citd.de>
References: <Pine.LNX.4.44.0208052251170.21076-100000@korben.citd.de> <1028586383.18478.100.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1028586383.18478.100.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2002 at 11:26:23PM +0100, Alan Cox wrote:
> On Mon, 2002-08-05 at 22:03, Matthias Schniedermeyer wrote:
> 
> > A bit strange is that it seems to depend on load. Higher load seems to
> > cause less/none clock drift.
> > (e.g. when i compile something in background, the "rotating thing" in
> > mozilla doesn't spin to fast)
> > 
> > Hardware is a Dual-PIII-933Mhz. Kernel is configured as SMP.
> > Any more details needed?
> 
> Can you grab /proc/interrupts every 5 minutes for an hour and send me
> the resulting file ?

I guessed wrong.

USB is the problem.

When i move my USB-Mouse i can see the seconds pass by. (Heavy moving
causes up to 2-3x higher "speed".)

Then maybe the USB-Keyboard problem is related. Every now and then a key
gets "stuck" and is repeated until i press another key. (Very annying
when you press "CTRL-n" in Mozilla for getting a new window. Personal
"record" was about 50 Windows)
(Currently i'm typing with the "normal" Keyboard)



But here is the wanted info

Record with this from another machine:
-- time.sh --
#!/bin/sh
while true
do
  echo -n "Localtime: "
  date
  echo -n "Remotetime: "
  ssh <remote> date \; cat /proc/interrupts
  sleep 5m
done
-- End --

-- Begin --
Localtime: Mon Aug  5 23:18:03 CEST 2002
Remotetime: Mon Aug  5 23:18:34 CEST 2002
           CPU0       CPU1       
  0:     687154     685272    IO-APIC-edge  timer
  1:       6478       6372    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  4:      38180      38195    IO-APIC-edge  serial
  8:          8          4    IO-APIC-edge  rtc
 10:      90159      89996   IO-APIC-level  usb-ohci
 14:         18         14    IO-APIC-edge  ide0
 18:    1946893    1959777   IO-APIC-level  EMU10K1
 22:        243        244   IO-APIC-level  sym53c8xx
 23:    2256667    2258749   IO-APIC-level  eth0
 24:         12         14   IO-APIC-level  ide2, ide3
 26:      31751      31651   IO-APIC-level  ide4
 28:          3          3   IO-APIC-level  sym53c8xx
 29:      14542      14420   IO-APIC-level  sym53c8xx
NMI:          0          0 
LOC:    1083892    1083828 
ERR:          2
MIS:          0
Localtime: Mon Aug  5 23:23:04 CEST 2002
Remotetime: Mon Aug  5 23:23:35 CEST 2002
           CPU0       CPU1       
  0:     702302     700216    IO-APIC-edge  timer
  1:       6495       6394    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  4:      38773      38794    IO-APIC-edge  serial
  8:          8          4    IO-APIC-edge  rtc
 10:      90159      89996   IO-APIC-level  usb-ohci
 14:         18         14    IO-APIC-edge  ide0
 18:    1951998    1964779   IO-APIC-level  EMU10K1
 22:        243        244   IO-APIC-level  sym53c8xx
 23:    2288054    2292385   IO-APIC-level  eth0
 24:         12         14   IO-APIC-level  ide2, ide3
 26:      32160      32065   IO-APIC-level  ide4
 28:          3          3   IO-APIC-level  sym53c8xx
 29:      14574      14452   IO-APIC-level  sym53c8xx
NMI:          0          0 
LOC:    1113987    1113923 
ERR:          2
MIS:          0
Localtime: Mon Aug  5 23:28:05 CEST 2002
Remotetime: Mon Aug  5 23:28:36 CEST 2002
           CPU0       CPU1       
  0:     717649     714961    IO-APIC-edge  timer
  1:       6547       6455    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  4:      39386      39373    IO-APIC-edge  serial
  8:          8          4    IO-APIC-edge  rtc
 10:      90159      89996   IO-APIC-level  usb-ohci
 14:         18         14    IO-APIC-edge  ide0
 18:    1958804    1971693   IO-APIC-level  EMU10K1
 22:        243        244   IO-APIC-level  sym53c8xx
 23:    2312661    2316329   IO-APIC-level  eth0
 24:         12         14   IO-APIC-level  ide2, ide3
 26:      33205      33106   IO-APIC-level  ide4
 28:          3          3   IO-APIC-level  sym53c8xx
 29:      14614      14489   IO-APIC-level  sym53c8xx
NMI:          0          0 
LOC:    1144083    1144018 
ERR:          2
MIS:          0
Localtime: Mon Aug  5 23:33:06 CEST 2002
Remotetime: Mon Aug  5 23:33:54 CEST 2002
           CPU0       CPU1       
  0:     735216     732129    IO-APIC-edge  timer
  1:       6777       6666    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  4:      40052      40079    IO-APIC-edge  serial
  8:          8          5    IO-APIC-edge  rtc
 10:      91593      91536   IO-APIC-level  usb-ohci
 14:         18         14    IO-APIC-edge  ide0
 18:    1960578    1973582   IO-APIC-level  EMU10K1
 22:        243        244   IO-APIC-level  sym53c8xx
 23:    2319176    2322831   IO-APIC-level  eth0
 24:         12         14   IO-APIC-level  ide2, ide3
 26:      33246      33164   IO-APIC-level  ide4
 28:          3          3   IO-APIC-level  sym53c8xx
 29:      14870      14751   IO-APIC-level  sym53c8xx
NMI:          0          0 
LOC:    1174177    1174113 
ERR:          2
MIS:          0
Localtime: Mon Aug  5 23:38:07 CEST 2002
Remotetime: Mon Aug  5 23:40:22 CEST 2002
           CPU0       CPU1       
  0:     754736     751466    IO-APIC-edge  timer
  1:       6967       6890    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  4:      40846      40825    IO-APIC-edge  serial
  8:          8          5    IO-APIC-edge  rtc
 10:      94361      94214   IO-APIC-level  usb-ohci
 14:         18         14    IO-APIC-edge  ide0
 18:    1963168    1976115   IO-APIC-level  EMU10K1
 22:        243        244   IO-APIC-level  sym53c8xx
 23:    2627805    2631421   IO-APIC-level  eth0
 24:         17         22   IO-APIC-level  ide2, ide3
 26:      37713      37638   IO-APIC-level  ide4
 28:          3          3   IO-APIC-level  sym53c8xx
 29:      15005      14900   IO-APIC-level  sym53c8xx
NMI:          0          0 
LOC:    1204272    1204208 
ERR:          2
MIS:          0
Localtime: Mon Aug  5 23:43:08 CEST 2002
Remotetime: Mon Aug  5 23:47:07 CEST 2002
           CPU0       CPU1       
  0:     774954     771719    IO-APIC-edge  timer
  1:       6974       6899    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  4:      41592      41679    IO-APIC-edge  serial
  8:          8          5    IO-APIC-edge  rtc
 10:      97489      97273   IO-APIC-level  usb-ohci
 14:         18         14    IO-APIC-edge  ide0
 18:    1963168    1976115   IO-APIC-level  EMU10K1
 22:        243        244   IO-APIC-level  sym53c8xx
 23:    2633541    2637118   IO-APIC-level  eth0
 24:         18         22   IO-APIC-level  ide2, ide3
 26:      37713      37638   IO-APIC-level  ide4
 28:          3          3   IO-APIC-level  sym53c8xx
 29:      15124      15015   IO-APIC-level  sym53c8xx
NMI:          0          0 
LOC:    1234366    1234302 
ERR:          2
MIS:          0
Localtime: Mon Aug  5 23:48:09 CEST 2002
Remotetime: Mon Aug  5 23:55:13 CEST 2002
           CPU0       CPU1       
  0:     799080     796181    IO-APIC-edge  timer
  1:       7049       6986    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  4:      42535      42656    IO-APIC-edge  serial
  8:          8          5    IO-APIC-edge  rtc
 10:     102866     102704   IO-APIC-level  usb-ohci
 14:         18         14    IO-APIC-edge  ide0
 18:    1963168    1976115   IO-APIC-level  EMU10K1
 22:        243        244   IO-APIC-level  sym53c8xx
 23:    2639067    2642585   IO-APIC-level  eth0
 24:         18         22   IO-APIC-level  ide2, ide3
 26:      37713      37638   IO-APIC-level  ide4
 28:          3          3   IO-APIC-level  sym53c8xx
 29:      15189      15089   IO-APIC-level  sym53c8xx
NMI:          0          0 
LOC:    1264459    1264395 
ERR:          2
MIS:          0
Localtime: Mon Aug  5 23:53:10 CEST 2002
Remotetime: Tue Aug  6 00:01:21 CEST 2002
           CPU0       CPU1       
  0:     817664     814472    IO-APIC-edge  timer
  1:       7060       7005    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  4:      43328      43323    IO-APIC-edge  serial
  8:          8          5    IO-APIC-edge  rtc
 10:     104976     104754   IO-APIC-level  usb-ohci
 14:         18         14    IO-APIC-edge  ide0
 18:    1963168    1976115   IO-APIC-level  EMU10K1
 22:        243        244   IO-APIC-level  sym53c8xx
 23:    2644790    2648281   IO-APIC-level  eth0
 24:         18         22   IO-APIC-level  ide2, ide3
 26:      37713      37638   IO-APIC-level  ide4
 28:          3          3   IO-APIC-level  sym53c8xx
 29:      15273      15178   IO-APIC-level  sym53c8xx
NMI:          0          0 
LOC:    1294553    1294489 
ERR:          2
MIS:          0
Localtime: Mon Aug  5 23:58:11 CEST 2002
Remotetime: Tue Aug  6 00:07:00 CEST 2002
           CPU0       CPU1       
  0:     834386     831554    IO-APIC-edge  timer
  1:       7179       7136    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  4:      44050      43941    IO-APIC-edge  serial
  8:          8          5    IO-APIC-edge  rtc
 10:     106138     105949   IO-APIC-level  usb-ohci
 14:         18         14    IO-APIC-edge  ide0
 18:    1964452    1977390   IO-APIC-level  EMU10K1
 22:        243        244   IO-APIC-level  sym53c8xx
 23:    2650015    2653482   IO-APIC-level  eth0
 24:         18         22   IO-APIC-level  ide2, ide3
 26:      37713      37638   IO-APIC-level  ide4
 28:          3          3   IO-APIC-level  sym53c8xx
 29:      15366      15263   IO-APIC-level  sym53c8xx
NMI:          0          0 
LOC:    1324646    1324582 
ERR:          2
MIS:          0
Localtime: Tue Aug  6 00:03:12 CEST 2002
Remotetime: Tue Aug  6 00:13:06 CEST 2002
           CPU0       CPU1       
  0:     852576     850055    IO-APIC-edge  timer
  1:       7288       7279    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  4:      44750      44693    IO-APIC-edge  serial
  8:          8          5    IO-APIC-edge  rtc
 10:     108250     107946   IO-APIC-level  usb-ohci
 14:         18         14    IO-APIC-edge  ide0
 18:    1965663    1978588   IO-APIC-level  EMU10K1
 22:        243        244   IO-APIC-level  sym53c8xx
 23:    2655858    2659332   IO-APIC-level  eth0
 24:         18         22   IO-APIC-level  ide2, ide3
 26:      37713      37638   IO-APIC-level  ide4
 28:          3          3   IO-APIC-level  sym53c8xx
 29:      15462      15359   IO-APIC-level  sym53c8xx
NMI:          0          0 
LOC:    1354741    1354677 
ERR:          2
MIS:          0
Localtime: Tue Aug  6 00:08:13 CEST 2002
Remotetime: Tue Aug  6 00:19:27 CEST 2002
           CPU0       CPU1       
  0:     871488     869187    IO-APIC-edge  timer
  1:       7532       7549    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  4:      46054      46001    IO-APIC-edge  serial
  8:          8          5    IO-APIC-edge  rtc
 10:     110569     110264   IO-APIC-level  usb-ohci
 14:         18         14    IO-APIC-edge  ide0
 18:    2067941    2081901   IO-APIC-level  EMU10K1
 22:        243        244   IO-APIC-level  sym53c8xx
 23:    2661907    2665401   IO-APIC-level  eth0
 24:         18         22   IO-APIC-level  ide2, ide3
 26:      37713      37638   IO-APIC-level  ide4
 28:          3          3   IO-APIC-level  sym53c8xx
 29:      17333      17198   IO-APIC-level  sym53c8xx
NMI:          0          0 
LOC:    1384837    1384773 
ERR:          2
MIS:          0
Localtime: Tue Aug  6 00:13:14 CEST 2002
Remotetime: Tue Aug  6 00:26:21 CEST 2002
           CPU0       CPU1       
  0:     892223     889872    IO-APIC-edge  timer
  1:       8208       8256    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  4:      47433      47480    IO-APIC-edge  serial
  8:          8          5    IO-APIC-edge  rtc
 10:     113972     113615   IO-APIC-level  usb-ohci
 14:         18         14    IO-APIC-edge  ide0
 18:    2172921    2186315   IO-APIC-level  EMU10K1
 22:        243        244   IO-APIC-level  sym53c8xx
 23:    2668715    2672278   IO-APIC-level  eth0
 24:         18         22   IO-APIC-level  ide2, ide3
 26:      37713      37638   IO-APIC-level  ide4
 28:          3          3   IO-APIC-level  sym53c8xx
 29:      17465      17332   IO-APIC-level  sym53c8xx
NMI:          0          0 
LOC:    1414934    1414870 
ERR:          2
MIS:          0
-- End --



Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

