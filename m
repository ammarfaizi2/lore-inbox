Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbVAWHuy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbVAWHuy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 02:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVAWHuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 02:50:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:59106 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261250AbVAWHti (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 02:49:38 -0500
X-Authenticated: #14349625
Message-Id: <5.2.1.1.2.20050123080400.00bc54e8@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Sun, 23 Jan 2005 08:37:01 +0100
To: Con Kolivas <kernel@kolivas.org>, "Jack O'Quin" <joq@io.com>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft
  rt  scheduling
Cc: Rui Nuno Capela <rncbc@rncbc.org>, linux <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, rlrevell@joe-job.com,
       paul@linuxaudiosystems.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se
In-Reply-To: <41F32D32.7050007@kolivas.org>
References: <87acr03g8e.fsf@sulphur.joq.us>
 <41EEE1B1.9080909@kolivas.org>
 <41EF00ED.4070908@kolivas.org>
 <873bwwga0w.fsf@sulphur.joq.us>
 <41EF123D.703@kolivas.org>
 <87ekgges2o.fsf@sulphur.joq.us>
 <41EF2E7E.8070604@kolivas.org>
 <87oefkd7ew.fsf@sulphur.joq.us>
 <10752.195.245.190.93.1106211979.squirrel@195.245.190.93>
 <65352.195.245.190.94.1106240981.squirrel@195.245.190.94>
 <41F19907.2020809@kolivas.org>
 <87k6q6c7fz.fsf@sulphur.joq.us>
 <41F1F735.1000603@kolivas.org>
 <41F1F7AF.7000105@kolivas.org>
 <41F1FC1D.10308@kolivas.org>
 <87wtu55i3x.fsf@sulphur.joq.us>
 <41F2F7C1.70404@kolivas.org>
 <87r7kcu9tt.fsf@sulphur.joq.us>
 <41F32832.50100@kolivas.org>
 <87acr03g8e.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=====================_93042140==_"
X-Antivirus: avast! (VPS 0453-1, 12/31/2004), Outbound message
X-Antivirus-Status: Clean
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=====================_93042140==_
Content-Type: text/plain; charset="us-ascii"; format=flowed

At 03:50 PM 1/23/2005 +1100, Con Kolivas wrote:
>Looks like the number of steps to convert a modern "standard setup" 
>desktop to a low latency one on linux aren't that big after all :)

Yup, modern must be the key.  Even Ingo can't help my little ole PIII/500 
with YMF-740C.  Dang thing can't handle -p64 (alsa rejects that, causing 
jackd to become terminally upset), and it can't even handle 4 clients at 
SCHED_FIFO despite latest/greatest RT preempt kernel without xruns.

Bugger... downloaded all that nifty sounding stuff for _nothing_ ;-)  See 
attached highly trimmed log for humorous results.  (and /tmp isn't the 
problem here)

         -Mike 
--=====================_93042140==_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="jack_test4-2.6.11-rc2-RT-V0.7.36-02-200501230904.log"

*** Started Sun Jan 23 09:04:41 CET 2005 ***

Seconds to run        (SECS) = 300
Number of clients  (CLIENTS) = 4
Ports per client     (PORTS) = 4
Frames per buffer   (PERIOD) = 256
Number of runs        (RUNS) = 1
Playback ports (PLYBK_PORTS) = 32

-----------------------
# uname -a
Linux mikeg 2.6.11-rc2-RT-V0.7.36-02 #3 Sun Jan 23 08:20:26 CET 2005 i686 unknown

-----------------------
# cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.8 (Thu Jan 13 09:39:32 2005 UTC).

-----------------------
# cat /proc/asound/cards
0 [YMF740C        ]: YMF740C - Yamaha DS-XG (YMF740C)
                     Yamaha DS-XG (YMF740C) at 0xeb000000, irq 9

-----------------------
# cat /proc/interrupts
           CPU0       
  0:    2129651          XT-PIC  timer  0/29651
  1:       3914          XT-PIC  i8042  0/3914
  2:          0          XT-PIC  cascade  0/0
  4:         11          XT-PIC  serial  1/11
  8:          2          XT-PIC  rtc  0/2
  9:     116530          XT-PIC  eth0, YMFPCI  0/16530
 12:      27462          XT-PIC  i8042  1/27462
 14:      27748          XT-PIC  ide0  0/27747
 15:         12          XT-PIC  ide1  0/11
NMI:          0 
LOC:          0 
ERR:         11

- - - - - - - - - - - -
  PID   TID CLS RTPRIO  NI PRI %CPU STAT COMMAND
    2     2 FF      49   0  89  0.9 SW   IRQ 0
  660   660 FF      48  -5  88  0.0 SW<  IRQ 8
  673   673 FF      47  -5  87  0.0 SW<  IRQ 12
  687   687 FF      46  -5  86  0.0 SW<  IRQ 6
  697   697 FF      45  -5  85  0.0 SW<  IRQ 14
  699   699 FF      44  -5  84  0.0 SW<  IRQ 15
  717   717 FF      43  -5  83  0.0 SW<  IRQ 1
  824   824 FF      42  -5  82  0.0 SW<  IRQ 4
  825   825 FF      41  -5  81  0.0 SW<  IRQ 3
  900   900 FF      40  -5  80  0.2 SW<  IRQ 9

09:04:42 cpu    2   0   0   0   0   0 int  404 ctx  1211 bio  0  0 mem  17M
09:04:43 cpu    0   0   0   0   0   0 int  1001 ctx  3007 bio  0  0 mem  17M
09:04:44 cpu    0   0   0   0   0   0 int  1004 ctx  3027 bio  0  4096 mem  17M
-----------------------
# jackd -Rv -P60 -p64 -dalsa -dhw:0 -r44100 -p256 -n2 -P
getting driver descriptor from /usr/lib/jack/jack_alsa.so
09:04:45 cpu    7   3   0  29   0   0 int  1104 ctx  3352 bio  888832  0 mem  18M
getting driver descriptor from /usr/lib/jack/jack_dummy.so
getting driver descriptor from /usr/lib/jack/jack_oss.so
jackd 0.99.48
Copyright 2001-2005 Paul Davis and others.
jackd comes with ABSOLUTELY NO WARRANTY
This is free software, and you are welcome to redistribute it
under certain conditions; see the file COPYING for details

JACK compiled with System V SHM support.
server `default' registered
loading driver ..
registered builtin port type 32 bit float mono audio
new client: alsa_pcm, id = 1 type 1 @ 0x8058658 fd = -1
apparent rate = 44100
creating alsa driver ... hw:0|-|256|2|44100|0|0|nomon|swmeter|-|32bit
control device hw:0
configuring for 44100Hz, period = 256 frames, buffer = 2 periods
Couldn't open hw:0 for 32bit samples trying 24bit instead
Couldn't open hw:0 for 24bit samples trying 16bit instead
nperiods = 3 for playback
new buffer size 256
registered port alsa_pcm:playback_1, offset = 0
registered port alsa_pcm:playback_2, offset = 0
++ jack_rechain_graph():
client alsa_pcm: internal client, execution_order=0.
-- jack_rechain_graph()
20726 waiting for signals

>>>>SNIP ZILLION LINES<<<<

late driver wakeup: nframes to process = 512.
late driver wakeup: nframes to process = 512.
late driver wakeup: nframes to process = 512.
late driver wakeup: nframes to process = 512.
late driver wakeup: nframes to process = 512.
late driver wakeup: nframes to process = 512.
delay of 10197.000 usecs exceeds estimated spare time of 5755.000; restart ...
delay of 10197.000 usecs exceeds estimated spare time of 5755.000; restart ...
late driver wakeup: nframes to process = 512.
late driver wakeup: nframes to process = 512.
late driver wakeup: nframes to process = 512.
late driver wakeup: nframes to process = 512.
late driver wakeup: nframes to process = 512.
late driver wakeup: nframes to process = 512.
late driver wakeup: nframes to process = 512.
delay of 10193.000 usecs exceeds estimated spare time of 5755.000; restart ...
delay of 10193.000 usecs exceeds estimated spare time of 5755.000; restart ...
late driver wakeup: nframes to process = 512.
late driver wakeup: nframes to process = 512.
late driver wakeup: nframes to process = 512.
late driver wakeup: nframes to process = 512.
late driver wakeup: nframes to process = 512.
late driver wakeup: nframes to process = 512.
late driver wakeup: nframes to process = 512.
delay of 10198.000 usecs exceeds estimated spare time of 5755.000; restart ...
delay of 10198.000 usecs exceeds estimated spare time of 5755.000; restart ...
late driver wakeup: nframes to process = 512.
late driver wakeup: nframes to process = 512.
late driver wakeup: nframes to process = 512.
late driver wakeup: nframes to process = 512.
late driver wakeup: nframes to process = 512.
late driver wakeup: nframes to process = 512.
delay of 10196.000 usecs exceeds estimated spare time of 5755.000; restart ...
delay of 10196.000 usecs exceeds estimated spare time of 5755.000; restart ...
late driver wakeup: nframes to process = 512.
late driver wakeup: nframes to process = 512.
late driver wakeup: nframes to process = 512.
late driver wakeup: nframes to process = 512.
late driver wakeup: nframes to process = 512.
late driver wakeup: nframes to process = 512.
late driver wakeup: nframes to process = 512.
delay of 10198.000 usecs exceeds estimated spare time of 5755.000; restart ...
delay of 10198.000 usecs exceeds estimated spare time of 5755.000; restart ...
late driver wakeup: nframes to process = 512.
late driver wakeup: nframes to process = 512.
late driver wakeup: nframes to process = 512.
late driver wakeup: nframes to process = 512.
late driver wakeup: nframes to process = 512.
late driver wakeup: nframes to process = 512.
late driver wakeup: nframes to process = 512.
delay of 10197.000 usecs exceeds estimated spare time of 5755.000; restart ...
delay of 10197.000 usecs exceeds estimated spare time of 5755.000; restart ...
late driver wakeup: nframes to process = 512.
late driver wakeup: nframes to process = 512.
jack main caught signal 15
starting server engine shutdown
stopping driver
late driver wakeup: nframes to process = 512.
unloading driver
freeing shared port segments
stopping server thread
stopping watchdog thread
last xrun delay: 10197.000 usecs
max delay reported by backend: 19498.000 usecs
freeing engine shared memory
max usecs: 4132.000, engine deleted
WARNING: 2 message buffer overruns!
cleaning up shared memory
cleaning up files
unregistering server `default'

09:10:06 cpu    8   1   0   1   0   0 int  1143 ctx  3805 bio  22528  9216 mem  17M
09:10:07 cpu    3   1   0   0   0   0 int  1000 ctx  3070 bio  0  0 mem  17M
*** Terminated Sun Jan 23 09:10:07 CET 2005 ***
************* SUMMARY RESULT ****************
Total seconds ran . . . . . . :   300
Number of clients . . . . . . :     4
Ports per client  . . . . . . :     4
Frames per buffer . . . . . . :   256
Number of runs  . . . . . . . :(    1)
*********************************************
Timeout Count . . . . . . . . :(    0)
XRUN Count  . . . . . . . . . :     2
Delay Count (>spare time) . . : 40267
Delay Count (>1000 usecs) . . : 40267
Delay Maximum . . . . . . . . : 19498   usecs
Cycle Maximum . . . . . . . . :  4132   usecs
Average DSP Load. . . . . . . :    63.9 %
Average CPU System Load . . . :    18.0 %
Average CPU User Load . . . . :     2.0 %
Average CPU Nice Load . . . . :     0.0 %
Average CPU I/O Wait Load . . :     0.2 %
Average CPU IRQ Load  . . . . :     0.0 %
Average CPU Soft-IRQ Load . . :     0.0 %
Average Interrupt Rate  . . . :   843.8 /sec
Average Context-Switch Rate . :  7839.9 /sec
*********************************************
Delta Maximum . . . . . . . . : 0.00000
*********************************************

--=====================_93042140==_--

