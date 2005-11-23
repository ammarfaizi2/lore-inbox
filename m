Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932513AbVKWEgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513AbVKWEgv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 23:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbVKWEgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 23:36:51 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:27836 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S932513AbVKWEgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 23:36:51 -0500
Date: Tue, 22 Nov 2005 23:36:48 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Linux 2.6.15-rc2
In-reply-to: <4383CC4E.40206@m1k.net>
To: linux-kernel@vger.kernel.org
Message-id: <200511222336.48506.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: Multipart/Mixed; boundary="Boundary-00=_gH/gDccvs+90ADF"
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org>
 <200511202049.30952.gene.heskett@verizon.net> <4383CC4E.40206@m1k.net>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_gH/gDccvs+90ADF
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 22 November 2005 20:56, Michael Krufky wrote:
>Gene Heskett wrote:
>>WARNING:/lib/modules/2.6.15-rc2/kernel/drivers/media/video/cx88/cx88-d
>>vb .ko needs unknown symbol nxt200x_attach.
>
>Gene has sent me a copy of his .config ... here are the relevant lines:
>
>[snip]
>
>CONFIG_VIDEO_CX88=m
>CONFIG_VIDEO_CX88_DVB=m
># CONFIG_VIDEO_CX88_DVB_ALL_FRONTENDS is not set
># CONFIG_VIDEO_CX88_DVB_MT352 is not set
>CONFIG_VIDEO_CX88_DVB_OR51132=m
># CONFIG_VIDEO_CX88_DVB_CX22702 is not set
># CONFIG_VIDEO_CX88_DVB_LGDT330X is not set
># CONFIG_VIDEO_CX88_DVB_NXT200X is not set
>
>[snip]
>
>CONFIG_DVB_NXT2002=m
># CONFIG_DVB_NXT200X is not set
># CONFIG_DVB_OR51211 is not set
>CONFIG_DVB_OR51132=m
># CONFIG_DVB_BCM3510 is not set
>CONFIG_DVB_LGDT330X=m
>
>[snip]
>
>A configuration like this should have compiled cx88-dvb without any
>references to nxt200x at all.
>
>Gene, do you have v4l-kernel cvs installed on top of kernel 2.6.15-rc2?

No, not since back at about 2.6.4 or so when I needed the ieee1394
stuff.  This is a 2.6.14, with the 2.6.15-rc2 patch applied straight
out of the box.

>Unless I'm missing something, it seems that this is the only way that
>you could have nxt200x support in cx88-dvb without having built the
>nxt200x module itself.  The v4l-kernel cvs build environment has
> nxt200x enabled by default when building against kernels 2.6.15 and
> later.
>
Well, I just went thru it again, and turned off everything but the
cx8800 and ORv51132 stuffs, and now I get this at the and of the
'makeit' script I use here:

WARNING:
/lib/modules/2.6.15-rc2/kernel/drivers/media/video/cx88/cx88-dvb.ko
needs unknown symbol mt352_attach
WARNING:
/lib/modules/2.6.15-rc2/kernel/drivers/media/video/cx88/cx88-dvb.ko
needs unknown symbol nxt200x_attach
WARNING:
/lib/modules/2.6.15-rc2/kernel/drivers/media/video/cx88/cx88-dvb.ko
needs unknown symbol mt352_write
WARNING:
/lib/modules/2.6.15-rc2/kernel/drivers/media/video/cx88/cx88-dvb.ko
needs unknown symbol lgdt330x_attach
WARNING:
/lib/modules/2.6.15-rc2/kernel/drivers/media/video/cx88/cx88-dvb.ko
needs unknown symbol cx22702_attach

So that definitely was a non-no.  That .config is also attached.

>If this is true, then you can either disable nxt200x in
>v4l-kernel/v4l/Makefile, or re-build the cvs modules using the dvb +
> v4l merged-tree build environment.
>http://linuxtv.org/v4lwiki/index.php/How_to_build_from_CVS
>
>This would, in effect, give the same result as if you had selected
>CONFIG_VIDEO_CX88_DVB_ALL_FRONTENDS (selected by default in Kconfig)
>
>...or maybe you initially started a kernel build with the nxt200x
> module selected, then stopped the compile, unselected nxt200x, and
> continued the build process without cleaning in between, and after
> cx88-dvb had already been built?  Hmm... I guess that might be a bit
> far-fetched... but to be sure, you can wipe out your kernel tree and
> rebuild it again from scratch using the same .config .

The first thing my makeit script does is a make clean.  So it should be
self-cleaning in that scenario.

My buildit26 script also starts everything from scratch, moving old
base version trees out of the way until the new one can be renamed
properly.  But theres nothing in it precious, so I can nuke 2.6.15-rc2
and retry again.  This time makeing no adjustments to the make xconfig
it finishes up with.  So that build from scratch is underway.

And I note that when its going thru the make oldconfig, that nxt2002 is
set as a module, however it is not now loaded into 2.6.14.2, and tvtime
works ok without it, so somehow its getting turned on.  Humm, grepping
the .config in the 2.6.14.2 tree shows that it is set as a module.  So
thats where that came from.  Not sure why I turned it on in the first
place, scratching aching head. (I've got a cold, good thing you can't
catch this virus by email :)

And, I just noticed this go by during the compile of the modules:
  Building modules, stage 2.
  MODPOST
*** Warning: "nxt200x_attach" [drivers/media/video/cx88/cx88-dvb.ko]
undefined!

It was probably there all the time and I just missed it as its many
pages back up in the history.  The depmod at the end of the compile
also reports this again:
WARNING:
/lib/modules/2.6.15-rc2/kernel/drivers/media/video/cx88/cx88-dvb.ko
needs unknown symbol nxt200x_attach

>If my assumption above is incorrect, then this will need to be looked
>into a bit deeper.  Please, let me know.

Looks like the magnifying glass needs to come out.

>Regards,
>
>Michael Krufky

Thanks Michael.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.36% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.




--Boundary-00=_gH/gDccvs+90ADF
Content-Type: application/x-gzip;
  name="config-2.6.15-rc2.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="config-2.6.15-rc2.gz"

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
AAA=

--Boundary-00=_gH/gDccvs+90ADF--
