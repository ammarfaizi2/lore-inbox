Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbUGLUrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbUGLUrS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 16:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263003AbUGLUrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 16:47:18 -0400
Received: from out003pub.verizon.net ([206.46.170.103]:49044 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S262114AbUGLUrI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 16:47:08 -0400
Message-Id: <200407122047.i6CKl6XR002663@localhost.localdomain>
To: Mark Hahn <hahn@physics.mcmaster.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: desktop and multimedia as an afterthought? 
In-reply-to: Your message of "Mon, 12 Jul 2004 15:12:04 EDT."
             <Pine.LNX.4.44.0407121507530.20260-100000@coffee.psychology.mcmaster.ca> 
Date: Mon, 12 Jul 2004 16:47:06 -0400
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [141.151.61.237] at Mon, 12 Jul 2004 15:47:07 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I could be wrong, but it seems to me that at least a part of the kernel
>> development team has the desktop and multimedia issues very low on the
>> priority list.
>
>no, that implies that desktop/media is somehow opposed to other development.
>that's the real issue: is there some reason to believe that this opposition
>exists, that tuning for desktop/media is tuning away from other serverish
>uses?  people like Linus want to push the agenda that the same kernel can 
>do both, until there's some definitive proof otherwise.

there's no definitive proof, but one can say up front that the demands
have long been recognized as fairly different, and that tends to leads
to different design strategies which in turn can compromise the
response to the demands.

the key characteristic of multimedia work, audio and video in
particular (realtime 3d postscript-driven sculpture devices are still
rare at this point) is that it needs to satisfy pseudo-hard realtime
deadlines. i say pseudo only because nobody dies if the deadlines are
missed. you miss the deadline for an audio device just once, and the
entire group of people listening to the output can hear it loud and
clear. 

the serverish space never has this requirement. the main requirement
there is stability and throughput, where throughput generally
considers of delivery varying-sized chunks of data to a network
interface as a result of various types of network-delivered
requests. a server has only one catastrophic condition: failure to
serve requests. degradation in performance is expected as load rises,
and although tweaks may change the curve, its considered OK for a
machine to perform variably as a server depending on the load. 

the focus on the second of these two quite different sets of
performance requirements tends to push the kernel in one direction,
with occasional major concessions to the other. more abstractly, the
tension tends to be characterized as between throughput and response
("latency"), but this is excessively simplistic. audio work (and to
some extent video as well) requires deadline satisfaction, serverish
work requires predictable degradation in response to workload. these
are not inherently opposed to each other, but measuring the behaviour
of one rarely touches the behaviour of the other.

>> The CK patches floated around as separate patches for a long time, even
>> though they brought significant improvements to the kernel w.r.t.
>> desktop and media.
>
>how do you show this?  measured how, under what load, with what
>> benefits?

the classic example is benno sennoner's latencytest, which has been
cited in all the reports here on latency issues, along with andrew
mortons schedlat utilities like realfeel.

at the RMLL/LSM in bordeaux last week, takashi iwai of the alsa
project demonstrated very convincingly that the isochronous scheduler
(for example) is of major benefit to non-SCHED_{FIFO,RR} media
applications. this is just for stuff like people running xmms and its
cousins while doing other work.

there really is no room for disagreement here: every linux developer
and user who does serious audio work runs a patched kernel and sees
clearly measurable (and in some cases, absolutely required) benefits.

>> And rightly so. If i reboot my computer into Windows and perform the
>> same multimedia tasks, there are fewer chances of it skipping frames or
>
>this normally shows only that windows drivers are better.

this is an absurd claim. i suppose that beos' outstanding performance
with media, or the excellent performance of osx simply shows that
their drivers are better? when JACK was ported to OSX, it somewhat
embarassingly performed better on OSX than it does on Linux. thats not
because of device drivers, its because the Mach part of Darwin has
superb facilities to support the kind of stuff that JACK needs.

--p

