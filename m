Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbWAJOky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWAJOky (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 09:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWAJOky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 09:40:54 -0500
Received: from sunrise.pg.gda.pl ([153.19.40.230]:45772 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP id S932166AbWAJOkx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 09:40:53 -0500
To: "Jaroslav Kysela" <perex@suse.cz>
Cc: "Takashi Iwai" <tiwai@suse.de>, linux-sound@vger.kernel.org,
       "ALSA development" <alsa-devel@alsa-project.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Alsa-devel] Re: [OT] ALSA userspace API complexity
References: <20050726150837.GT3160@stusta.de> <20060103193736.GG3831@stusta.de> <Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl> <mailman.1136368805.14661.linux-kernel2news@redhat.com> <20060104030034.6b780485.zaitcev@redhat.com> <Pine.LNX.4.61.0601041220450.9321@tm8103.perex-int.cz> <Pine.BSO.4.63.0601051253550.17086@rudy.mif.pg.gda.pl> <Pine.LNX.4.61.0601051305240.10350@tm8103.perex-int.cz> <Pine.BSO.4.63.0601051345100.17086@rudy.mif.pg.gda.pl> <s5hmziaird8.wl%tiwai@suse.de> <Pine.LNX.4.61.0601060028310.27932@zeus.compusonic.fi> <s5h7j9chzat.wl%tiwai@suse.de> <Pine.LNX.4.61.0601080225500.17252@zeus.compusonic.fi> <Pine.LNX.4.61.0601081007550.9470@tm8103.perex-int.cz> <Pine.LNX.4.61.0601090010090.31763@zeus.compusonic.fi> <Pine.LNX.4.61.0601101144130.10330@tm8103.perex-int.cz> <Pine.LNX.4.61.0601101550390.24146@zeus.compusonic.fi> <Pine.LNX.4.61.0601101508560.10330@tm8103.perex-int.cz>
Message-ID: <op.s2520tt5q5yxc3@merlin>
Date: Tue, 10 Jan 2006 15:39:55 +0100
From: =?iso-8859-2?B?QWRhbSBUbGGza2E=?= <atlka@pg.gda.pl>
Organization: =?iso-8859-2?B?R2Rh8XNrIFVuaXZlcnNpdHkgb2YgVGVjaG5vbG9neQ==?=
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.61.0601101508560.10330@tm8103.perex-int.cz>
User-Agent: Opera M2/8.51 (Linux, build 1462)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia 10-01-2006 o 15:17:21 Jaroslav Kysela <perex@suse.cz> napisa³:

> On Tue, 10 Jan 2006, Hannu Savolainen wrote:
>
>> On Tue, 10 Jan 2006, Jaroslav Kysela wrote:
>>
>> > >
>> > > Then you can include a libOSSlib.o library in ALSA with all the OSS
>> > > emulation stuf inside.
>> >
>> > You should do the clear statement that the direct using of syscalls  
>> is not
>> > recommented for application developers. Unfortunately at this time, I
>> > admit, it would be very difficult to change the existing applications.
>
>> Sorry. That breaks backward compatibility with systems that don't have
>> libOSSlib (all current and past Linux distros, all BSD variants,
>> everything but systems with our official OSS package installed). Such
>> statement can be added in 2010 but provided that all Linux distros and
>> other environments having OSS compatible implementations add the  
>> osslib_*
>> routines within this year.
>
> I meant that you can originate to move the OSS entry point to somewhere
> else (library) and try to persuade developers to use library than direct
> calls.
>
> Of course, we cannot change current applications, but we can start the
> movement now. I just ask you to do it now. Nothing else. It will be a  
> slow
> process but it should be started now.
>
> Also, I don't think that it will break something. The application
> developers can use your code in their applications directly when the
> distribution does not have the OSS access library package.
  ger atlka@sunrise.pg.gda.pl

Doing every call through some lib even if it's only a wrapper leading
to kernel syscall doesn't look very interesting.
Some people need statically lined apps and minimum usable distro without
bloated libs. What about Unix device abstraction?
Are we going the current Windows way?

Anyway Windows is stearing to the microkernel approach (approaching Vista)
and it looks that we are going to the current Windows model while MS  
developers
are going far away. Hurd looks nice but it is not good enough now.
But the idea is good and needs more people to improve it.

So we could have Unix device approach with drivers running as separate  
processes
not in kernel space. With proper kernel scheduling and being non-swappable
we could get good security, stability and additionally enough simple
 from app point of view approach. Going through libs we are going through
all the LD_PRELOAD and LD_LIBRARY_PATH and linker security hell.

Kernel approach looks good enough for me now. But it is not so secure of  
course.
So we need some process->kernel-device->driver RT/non-swappable/correctly
scheduled process IPC so we can do it the other way. IMHO that's the future
if we don't want drivers in the kernel.

Best regards
--
Adam Tla³ka      mailto:atlka@pg.gda.pl    ^v^ ^v^ ^v^
System  & Network Administration Group           ~~~~~~
Computer Center,  Gdañsk University of Technology, Poland
PGP public key:   finger atlka@sunrise.pg.gda.pl
