Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273827AbRIREGL>; Tue, 18 Sep 2001 00:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273830AbRIREFw>; Tue, 18 Sep 2001 00:05:52 -0400
Received: from paloma16.e0k.nbg-hannover.de ([62.159.219.16]:38602 "HELO
	paloma16.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S273827AbRIREFo>; Tue, 18 Sep 2001 00:05:44 -0400
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Robert Love <rml@tech9.net>, Chris Mason <mason@suse.com>
Subject: Re: Feedback on preemptible kernel patch
Date: Tue, 18 Sep 2001 06:06:06 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <200109140302.f8E32LG13400@zero.tech9.net> <200109150444.f8F4iEG19063@zero.tech9.net> <1000530869.32365.21.camel@phantasy>
In-Reply-To: <1000530869.32365.21.camel@phantasy>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_6EBUCA9ETT9KDWGHCWC8"
Message-Id: <20010918040550Z273827-761+10122@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_6EBUCA9ETT9KDWGHCWC8
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Am Samstag, 15. September 2001 07:14 schrieb Robert Love:
> On Sat, 2001-09-15 at 00:25, Dieter Nützel wrote:
> > > > >  ReiserFS may be another problem.
> > > >
> > > > Can't wait for that.
> >
> > Most wanted, now.
>
> I am working on it, but I am unfamilar with it all.
>
> Are you seeing any specific problems, now?  With the latest preemption
> patch on 2.4.10-pre9, do you crash? oops?

No, nothing with 2.4.10-pre9 + patch-rml-2.4.10-pre9-preempt-kernel-1 and 
your MMX/3Dnow! fix.

2.4.10-pre10 + patch-rml-2.4.10-pre10-preempt-kernel-1 seems to be a winner!

See my results below.

> The only outstanding issue now is ReiserFS issues.

Yes, but no crash or oops for me.
"Only" some "stalls" during MPEG/Ogg-Vorbis playback (2-5 sec) :-(

> > It seems to be that kswap put some additional "load" on the disk from
> > time to time. Or is it the ReiserFS thing, again?
>
> I don't think its related to ReiserFS.

I think you are right.

> What sort of activity are you seeing?  How often?  How do you know its
> kswapd?

I saw it with "top" at the first line (but only some few percent).
It was during untarring some mid-sized archives (DRI) which took normally ~10 
sec, but with kswap and 2.4.9-pre9+your patches ~30 sec. Even "sync" needed 
some additional seconds.

Are there some reschedule/context switch (kernel lock release) statements 
missing in ReiserFS?

Is this possible? Chris?

> I am glad the patch fixed it, the final version of that is going into
> the next preemption patch.  Stay tuned.

I am very happy with patch-rml-2.4.10-pre10-preempt-kernel-1.

> These results are pretty good.  Throughput seems down 2-3% in many
> cases, although latency is greatly improved.  Look at those latency
> changes!  From thousands of ms to hundreds of us in bonnie.  Wow.

So look at my latest numbers. This time preempt only, sorry.
If you need 2.4.10-pre10 only, too please ask.

> Even if you don't care about latency (I'm not an audio person or
> anything), these changes should be worth it.

I do. Or better, one of my friend's father will do some digital video editing 
with Linux:-)

> > Deleting with ReiserFS and the preempt kernel is GREAT!
>
> Good. I/O latency should be great now, with little change in
> throughput...

It is.

> > But I get some hiccup during noatun (mp3, ogg, etc. player for KDE-2.2)
> > or plaympeg together with dbench (16, 32). ReiserFS needs some preemption
> > fixes, too?
>
> You may still get some small hiccups ( < 1 second?) even with the
> preemption patch, as kernel locks prevent preemption (the patch can't
> guarentee low latency, just preemption outside of the locks).

Sadly 2-5 seconds at the beginning of dbench and during bonnie++ block 
operations (huge IO pressure, ~20% system, 3-5% user, 116308 kilobytes paged 
out).

> However, how bad was the hiccups with preemption disabled?  I have heard
> reports where it is 3-5sec at times.

Yes, nearly the same.

> As the kernel becomes more scalable (finer-grain locking), preemption
> will improve.  Past that, perhaps during 2.5, we can work on some other
> things to improve preemption.

Is this a ReiserFS only problem? Uninteruptable IO?

> > I've attached two small compressed bonnie++ HTML files.
>
> These were neat, thanks.

One more.

> Thank you for your feedback and support.  Stay current with the kernel
> and the preemption patches,

I will.

> and I will try to figure the ReiserFS crashes out.

No crashes for me only the stalls.

Regards,
	Dieter

2.4.10-pre10 + patch-rml-2.4.10-pre10-preempt-kernel-1

dbench-1.1 32
Throughput 26.2881 MB/sec (NB=32.8601 MB/sec  262.881 MBit/sec)
14.320u 54.140s 2:41.70 42.3%   0+0k 0+0io 911pf+0w
load: 2931
Throughput 27.3814 MB/sec (NB=34.2267 MB/sec  273.814 MBit/sec)
14.040u 55.920s 2:35.29 45.0%   0+0k 0+0io 911pf+0w
load: 2955

dbench 16
Throughput 32.9183 MB/sec (NB=41.1479 MB/sec  329.183 MBit/sec)
6.790u 26.580s 1:05.17 51.2%    0+0k 0+0io 511pf+0w

dbench 8
Throughput 34.8936 MB/sec (NB=43.617 MB/sec  348.936 MBit/sec)
3.300u 12.760s 0:31.27 51.3%    0+0k 0+0io 311pf+0w

dbench 4
Throughput 38.3568 MB/sec (NB=47.946 MB/sec  383.568 MBit/sec)
1.770u 6.160s 0:14.77 53.6%     0+0k 0+0io 211pf+0w
SunWave1>sync

dbench 2
Throughput 53.3066 MB/sec (NB=66.6333 MB/sec  533.066 MBit/sec)
0.940u 2.970s 0:05.95 65.7%     0+0k 0+0io 161pf+0w

dbench 1
Throughput 24.0354 MB/sec (NB=30.0442 MB/sec  240.354 MBit/sec)
0.470u 1.460s 0:06.49 29.7%     0+0k 0+0io 136pf+0w
Throughput 39.1102 MB/sec (NB=48.8878 MB/sec  391.102 MBit/sec)
0.400u 1.530s 0:04.38 44.0%     0+0k 0+0io 136pf+0w
Throughput 44.6889 MB/sec (NB=55.8611 MB/sec  446.889 MBit/sec)
0.500u 1.430s 0:03.96 48.7%     0+0k 0+0io 136pf+0w


Version 1.92a       ------Sequential Output------ --Sequential Input- 
--Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- 
--Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec 
%CP
SunWave1      1248M   107  96 16513  21  9004   9   163  98 27844  18 256.9   
3
Latency               115ms    2872ms    1743ms     121ms   64671us    3273ms
Version 1.92a       ------Sequential Create------ --------Random 
Create--------
SunWave1            -Create-- --Read--- -Delete-- -Create-- --Read--- 
-Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec 
%CP
                 16  6029  69 +++++ +++ 13252  94  6762  82 +++++ +++ 11342  
94
Latency               338ms   16041us   16309us   24248us     367us   17045us
load: 292
--------------Boundary-00=_6EBUCA9ETT9KDWGHCWC8
Content-Type: application/x-bzip2;
  name="2.4.10-pre10.html.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="2.4.10-pre10.html.bz2"

QlpoOTFBWSZTWbFIYjYAAXbfgHAQegv//z/v37A/7//6UAOr27lyCA6tsEkkIaaQ009TbU1PUbSe
oaaADQ0A0eoAaDTUmJoyKeUBkZANMRgRk0yaYQBoYSJBBE1HtI9UHqeoNAGh4oYTR6EAAHNMjIZM
ENGEwRpo0YgaZMjAAEEVEyAlN4ptTTTKZGQHqDQPUND1ADQZGK2MlQjAsMnnjqrje/cLTCSlBWDP
naGOAt2ucAM/Wj3AgUAcs/RIecxgBIwUDnSTZ6B5hyWcFZqAjj5DyOxYSbULQHdR+KVpgAGYTtA8
aZoEQgSAYhcAvcKZp3wvJ2Pqzkx7GBLIMkl2Mkkj0ZEsmC42DC6fpz59lMDXBPRv9nKlPXsiQHbP
JZpYyM0Fo2Mlb4iRCWZkOJEAkASCAhFICg3IKFV00ATMVRMzwdFT20UvbSuV7ROx6mtYGselM65S
FFinmVYkffKWSTi6x3UrbK510MLXFl3CvUHB9pBslw6SOqe7KNh4AYiR/0q6MK4pQB1QLiUdhEOe
kFlor4I59G03cxRxV16yUpRrsga6p43333wB2wUAM5DOshQrtADac7bQLiaXHOS64LWDS2QQREDI
ggbGDG0HOL5cqJMo0gxYcExWIndUAL3FtRCvGDGJCbCsFhScIJ1lIvGqwpUKSvOm18TEBrFtF8Tx
SlRvFdFuG45R1IV8ISOllrGbwhJE2nhh0ZrSwxzv5gAw6rt4tv3AtDeucAJiuGoylQSjcVWb59QA
qwTxBp7MIUkdGkuNCAVmyoJ0iByYlQq1b1pegGQqx4MMb4CBhUDKwvvgJZmz00pAALU6IIuU5hOD
wCrKUAAwgqy52IjIFSDCG+aQoChIGJhqRrlveouMW4AOX7vcR6XbuDUdJ49woVBxGo1CUWwBDdQG
P6Pc0Ch0P0XhsqMaiLBSB8esZ9RhUEoMPlkZKbQ2ohy5cZ37T5J+qwoKi+kOD7u3GNOFD4cKUodq
3it+YcMjVqdFIuxdriHm03ziORTRcmnezAPG92YofDPUTTUcwmtmbZ1s2Xfr74bOMIy4mVwldFwx
AOnLwjbL178iETPFv45oyoDKmHWIS1B3Ip3qaFk0l2rv46hjbY5u+YoTQdgONlicOYUJ129YThmO
HTWUlEQyTQEjlTJHdfFFBf0J3XUYFYxYvWt27xmWUpokT4KHIoJicDXA/xdyRThQkLFIYjY=

--------------Boundary-00=_6EBUCA9ETT9KDWGHCWC8--
