Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751375AbVJKFrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbVJKFrM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 01:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbVJKFrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 01:47:12 -0400
Received: from web35505.mail.mud.yahoo.com ([66.163.179.129]:27742 "HELO
	web35505.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751375AbVJKFrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 01:47:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=M31cY3YIkLP+U+8JAZJecpuEB/WES2ioV0CI4CkEA4Z9WFUNm67eYFX8vVubDj6OTiv62Ju2UuitBMl+gK1Tp22YlNFup6gja3ySFXOh7g+dkt/l6fXSEJ65y3U2YW5vmNAkYFyfPS78fQSRw2drzmJPUlGgqEijotfEiAZDCyY=  ;
Message-ID: <20051011052444.26533.qmail@web35505.mail.mud.yahoo.com>
Date: Mon, 10 Oct 2005 22:24:44 -0700 (PDT)
From: Dan C Marinescu <dan_c_marinescu@yahoo.com>
Subject: If anyone needs Adaptec VideOh USB 2 Alpha (32/64-bit) Linux Drivers
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

We have drivers for Adaptec VideOh USB 2 (working
great on 32 && 64-bit 2.6.x -- currently running on
2.6.13.4) They have been in testing for few weeks by
now, if anyone wants to use this great device in a
decent (non windowz) environment send us an email and
we'll send you the drivers. Also, note that Adaptec
does not provide 64-bit drivers... So, the only 64-bit
platform you can use this device is... Linux! 

Technical details:

kernel-space: avc2210k.ko
user-space (control): avcctrl
user-space (capture) avcap

if you go like cat /dev/avcap00 > mybirthday.mpg

you get 720x480 MPEG-2 (or MPEG-1) with dvdpcm audio.
of course, both NTSC (29.970FPS) and PAL (25.000FPS)
are supported. quality settings still need some work
:-( currently we cannot reduce quality lower than
BEST. very easy to detach and remultiplex (for VOB
sectors) with mplayer, mencoder && mplex like:

mplayer $1 -dumpaudio -dumpfile $1.lpcm
mencoder -of rawvideo -nosound -ovc copy $1 -o $1.m2v
mplex -V -f 8 -b 400 -o $1.vob.mpg $1.m2v $1.lpcm

it takes about 10 minutes to instert dvdauthor VOB
sectors for a 1.5 hours production. capture's (both
video and audio) quality is outstanding (way better
than any other card for around $100-$130). drivers
support the entire familly (mainly, all Adaptec USB
capture devices, with or without tuner). John is
working on tuner and remote control support // don't
have that yet, the only available inputs are currently
s-video and composite :-(

drivers are clean, they've been stress tested 24x7 for
the last couple of weeks, no hangs, no corruptions, no
nothing...

you have to use the firmware comming with your box
cd...

now, few comparative results (very same hardware):

32-bit:
command line capture latency: linux 0.5%CPU; windowz
not available
gui capture latency (using Xine/WinDVR): linux 20%CPU;
windowz 48%CPU
max quality: linux >BEST; windowz BEST

64-bit
linux: even lower CPU usage! windows not available

plus, on user-land, we wrote avcap (acting kinda like
tee but buffered):

avcap mymovie.mpg < /dev/avcap00 | xine stdin://

note that you can use the player of your choice to
watch what you are capturing in real-time!

but hey, there is more! if you send avcap USR1 && USR2
signals, the capture to the file stops while the
player of your choice is still running! this is
extremely useful to pause capture during tv adds and
other cr*p like that... :-) of course, capability not
currently supported with windvr (windowz). also, you
don't need to restart the device couple of times a
day... (like in windowz environments) and, finally,
when your x runs in dual/multi head configurations,
the player of your choice will run on every single
display (windowz limits that to the primary display
and windvr window takes several secons to wake up
after migrating from a display to another)

in couple of days (when it's ready) will will have
full support for remote control and tuner (already
hacked the protocol, it's just a matter of time for
implementation). so, in user-land, there will be an
app like avcchan or avctune to select the desired tv
input channel. having elementary (thin) modules ofers
you the flexibility and level of choice you deserve in
terms of: platform (32/64bit), viewer of your choice
(can use mplayer, xine, caffeine, etc), standard
signals for pause control (kill -10 avcap_pid will
pause capture && kill -12 avcap_pid will resume it)
and schedulling at your fingertips... well, that
simply doesn't exist in other platforms... feel free
to contact us for driver requests (in source code)
over email:

this email is mine (dr dan) and dr john is reacheable
at: J.A.Gow@furrybubble.co.uk

we would both like to hear from you... (test drivers
needed... :-)

ps.
this is not (yet) a kernel driver admission request...
however, drivers work without __any__ problems with
2.6.13.4 and 2.6.14.rc2 (both 32 && 64) -- not tuner
&& remote ctrl yet :-(

   daniel


	
		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
