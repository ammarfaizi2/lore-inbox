Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293668AbSCFQoW>; Wed, 6 Mar 2002 11:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293675AbSCFQoN>; Wed, 6 Mar 2002 11:44:13 -0500
Received: from mail1.cirrus.com ([141.131.3.20]:11168 "EHLO mail1.cirrus.com")
	by vger.kernel.org with ESMTP id <S293668AbSCFQoA>;
	Wed, 6 Mar 2002 11:44:00 -0500
Message-ID: <973C11FE0E3ED41183B200508BC7774C022FBB51@csexchange.crystal.cirrus.com>
From: "Woller, Thomas" <tom.woller@cirrus.com>
To: "'David Ford'" <david+cert@blue-labs.org>,
        "Woller, Thomas" <tom.woller@cirrus.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: 2.4.3+ sound distortion
Date: Wed, 6 Mar 2002 10:43:53 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

david, et al
a) i am very sorry about the tinny sound you are experiencing. we
no longer have any DSP pc audio engineers working at cirrus, and
pc audio products are no longer developed or supported here at
cirrus. i have talked this problem over with the only person that
might help, and the debugging effort involved is extensive and
may not yield results.  we do not fully understand the issue, but
believe that several internal points in the DSP become misaligned
resulting in the tinny sound.
b) the static DSP image that is currently used with the linux
cs46xx driver, is not capable of any of the fancy extensive
feature set, and the work involved would require an engineer with
intimate knowledge of the DSP which no longer is present.
c) see b
d) i am always willing to assist the linux effort, it's just
difficult due to the lack of any support at cirrus for pc audio
any longer.  i am working on embedded RTOS in my official job,
but always try to fix any linux pc audio related bugs as i am
able. also, without any DSP engineers we can not create another
static DSP image with the additional tasks necessary to take
advantage of the wonderful features of cards with the cs46xx
controller. we are stuck with the current DSP images that are
available. 

there is a small glimmer of light concerning secondary codec
support and SPDIF support.  i had found 2 other "test" static DSP
images that might be useful.  
i placed 2 piles of code out on a cirrus ftp site (see below).
the first is a cs46xx driver with an untested static DSP image
that snoops the data to the primary codec and pumps it to the
secondary, so that there is sound coming from the rear speakers,
although the same as the the front.
the second pile of code (EOLT) contains a set of tests that we
used for testing the cs4630.  the static image used in these
tests contained in this directory functioned with SPDIF in/out. i
am unsure whether the other tasks are loaded in this image to
support the general audio data paths, so this static image may
not support more than spdif.  i tried using the static "spdif"
image on the latest cs46xx linux driver, but it did not work with
a simple static image replacement in the source. specific problem
definition and resolution using the spdif EOLT static image with
the linux cs46xx sources, has not been determined.  anyone and
everyone are welcome to look over these 2 piles of source, but my
time is very limited concerning any new development for spdif
and/or secondary codec.

here is the ftp site info. the cs46xx code is based on an older
version of the 2.4 kernel.

server: ftp1.cirrus.com
login: ftppclink
password: cSPxQMd

thanks
Tom Woller


-----Original Message-----
From: David Ford [mailto:david+cert@blue-labs.org]
Sent: Tuesday, March 05, 2002 11:08 PM
To: Woller, Thomas; linux-kernel
Subject: Re: 2.4.3+ sound distortion


I have several questions regarding the Santa Cruz Voyetra:

a) please read the below text and those in the know, please
advise me of 
any updates to the current situation where sound is very tinny.
at 
present i have to deal with this constantly.
b) there have been some vague references made to adjusting the
other 
line IN/OUT channels which in the source i read from, stated that
this 
seems to act as a fade control and was able to adjust the level
of 
tinniness that was heard.
c) are there any (linux/open source) mixers which have the
capability of 
controlling this card in any fashion that is better than the dark
age 
mixers currently found on freshmeat?  i.e., something that takes 
advantage of the gobs of onboard features such as the onboard
hardware 
equalizer, configurable in/out ports, etc.
d) if no to (c), is Mr. Woller from cirrus.com interested in
helping us 
develop such features in a mixer application?

David

Recap from April of 2001;

Woller, Thomas said:

David,
your report sounds like a problem that we have seen in the test
lab, but no
one has reported in the field... yet. :)
if the problem is the same as we have seen... unloading the
driver and
reloading the driver should also clear up the problem. but
typically the
problem only occurs after playing for several hours without a
break in the
audio stream.

we think that we understand the problem (theoretically), in that
we believe
that we need to manipulate a static DSP image location
periodically that
gets too far out of value. the issue is that internal variables
for the
static DSP image are not reinitialized on a task restart (e.g.
restarting up
an audio stream). reloading the static image (i.e. suspend/resume
or
reloading the driver) clears up the *tinny* sound here. it hadn't
been
reported, so I haven't taken the time to plough through the
static image map
to try to figure out where all the locations are for all the task
images
that need manipulation. might take a while, but since we now have
a problem
report, i'll try to find some time to start negotiating the DSP
map. i'll
send the fix to you for testing when/if... i can get the problem
resolved.
thanks

tom
twoller@crystal.cirrus.com <mailto:twoller@crystal.cirrus.com>

/> -----Original Message-----/
/> From: David [SMTP:david@blue-labs.org]/
/> Sent: Sunday, April 22, 2001 10:08 PM/
/> To: *linux*-kernel@vger.kernel.org
<mailto:linux-kernel@vger.kernel.org>/
/> Subject: Re: 2.4.3+ sound distortion/
/> /
/> I have noticed a problem with sound lately. I have a *cs46xx*
card and /
/> it randomly gets distorted. Normally I just reboot but on this
last /
/> occurence I simply left it as it was. The distortion sounds
someone /
/> punched the speaker core, it's *tinny* and mangled. Today it
fixed 
itself /
/> out of the blue in the middle of playing a sound. All sound
programs 
are /
/> equally affected./
/> /
/> It's only done this in the 2.4 series, I haven't had the
desire to look /
/> into it./
/> /
/> David/


