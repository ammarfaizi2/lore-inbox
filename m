Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261782AbREYThm>; Fri, 25 May 2001 15:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261790AbREYThc>; Fri, 25 May 2001 15:37:32 -0400
Received: from qn-212-127-144-62.quicknet.nl ([212.127.144.62]:39174 "HELO
	smcc.demon.nl") by vger.kernel.org with SMTP id <S261782AbREYThM>;
	Fri, 25 May 2001 15:37:12 -0400
Message-ID: <XFMail.010525213709.nemosoft@smcc.demon.nl>
X-Mailer: XFMail 1.3 [p0] on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <E153Jyl-0006iS-00@the-village.bc.nu>
Date: Fri, 25 May 2001 21:37:09 +0200 (MEST)
Organization: I'm not organized
From: "Nemosoft Unv." <nemosoft@smcc.demon.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, johannes@erdfelt.com
Subject: Re: ac15 and 2.4.5-pre6, pwc format conversion
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        <J.A.K.Mouw@ITS.TUDelft.NL (Erik Mouw)>, randy.dunlap@intel.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Coalescing two messages in one:

On 25-May-01 Alan Cox wrote:
> Nope. Its been policy since 2.0. Its both v4l1 and v4l2 policy. In fact its
> fairly nonsensical to handle any format conversions in kernel unless the
> device outputs a unique format of its own.

Oh come on. 2.0 has been out since, what? 1996? Methinks you have had plenty
of time to really do something about it then. You are now simply too late.

> It breaks apps by doing conversions, and it breaks important apps like H263
> codecs not silly little camera viewers, because you trash the performance

This is a NULL argument. First, it doesn´t break anything; I think H263 is
smart to pick a YUV format if it´s available. Second, conversion has to be
done at one point or another. If the native format of the camera is RGB,
H263 will have to convert to YUV. Wether or not this is done in kernel space
or user space doesn´t matter: it has to be done. And in case the native
format of the camera doesn´t resemble anything in V4L, you will have TWO
conversion: first, in kernel from native to V4L palette, and then in your
tool from V4L to whatever format you need, while maybe the driver could do
it all in one stage.

On 25-May-01 Alan Cox wrote:
>> > that none of the sound drivers does sample rate conversion although
>> > some sound chips are locked at 48kHz only.
>> 
>> True, but a number of audio tools will break, because they don=B4t supp=
> 
> So fix the tools
> 
>> if you limit the number of available palettes per driver. Plus, you wil=
>> l get
>> severe fragmentation of which program works with which driver. Which is
>> unacceptable, in my opinion (and certainly NOT the idea behind a common=
>>  API!)
> 
> Fix the tools.

Gee, ¨Fix the tools¨ seems to be your mantra :-(. Anyway, breaking the tools
doesn´t necessarely mean they are going to get fixed; not all are
being actively maintained at the moment (okay, that´s a pity; still it´s a
shame).

And you are probably not going to get the endless streams of mails to the
webcam developers which state: ¨I upgraded my kernel to 2.4.X and my webcam
broke!¨ Do you really think we will enjoy replying time after time: ¨Yes, I
know, but Alan Cox told me to do so¨. No. To a lot of users, and even
application developers, this just plainly sucks.

>> routines, while (nearly) nothing has been said about other (USB) webcam
>> drivers which have conversion routines.
> 
> I have those in my firing line too. It has always been the policy that
> format
> conversions go in user space. The kernel is an arbitrator of resources it
> is not a shit bucket for solving other peoples incompetence.

Now you are being insulting, really. There are a lot of competent people
who put a lot of time and effort into these tools. But the Video4Linux API
is not complete and not completely suitable for webcams. For example, it
misses the quite fundamental call to query the available palettes; nor does
the V4L API give any hint that the number of palettes might be severely
limited. The first tools that were created had the luxury of hardware that
did all the work for them, so why not use it? Webcams are not so lucky.
There´s no need to penalize them, because if the change goes through, a lot
of tools will not work with webcams but with TV cards.

                                         ...

Anyway, I am not going to debate this any further at this point. Johannes,
please remove my webcam driver from the USB source tree, until the software
YUV/RGB conversion has been removed from ALL other video devices (preferably
all at the same time). I will *not* have a crippled driver into the Linux
kernel. If this is going to be policy, fine. But then this policy will apply
to ALL drivers equally, not just mine because suddenly Alan realizes he has
been sleeping for the past 5 years and decides to implement a policy hardly
noone ever knew existed.

 - Nemosoft

-----------------------------------------------------------------------------
Try SorceryNet!   One of the best IRC-networks around!   irc.sorcery.net:9000
URL: never        IRC: nemosoft      IscaBBS (bbs.isca.uiowa.edu): Nemosoft
                        >> Never mind the daylight << 
