Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315915AbSEGRaQ>; Tue, 7 May 2002 13:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315916AbSEGRaP>; Tue, 7 May 2002 13:30:15 -0400
Received: from mailhost.mipsys.com ([62.161.177.33]:37830 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S315915AbSEGRaO>; Tue, 7 May 2002 13:30:14 -0400
From: <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
Date: Tue, 7 May 2002 19:30:34 +0200
Message-Id: <20020507173034.14013@mailhost.mipsys.com>
In-Reply-To: <Pine.LNX.4.44.0205071021290.2509-100000@home.transmeta.com>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>On Tue, 7 May 2002 benh@kernel.crashing.org wrote:
>>
>> One interesting thing here would be to have some optional link between
>> the bus-oriented device tree and the function-oriented tree (ie. devfs
>> or simply /dev).
>
>There isn't any 1:1 thing - the device/bus-oriented one should _not_ show
>virtual things like partitions etc that have no relevance for a driver,
>while /dev (and thus devfs) obviously think that that is the important
>part, much more important than how we actually got to the device.
>
>I think we need to have some way of getting a mapping from /dev ->
>devicefs, but I don't think that has to be a filesystem thing (it might
>even be as simple as just one ioctl or new system call: 'get the "path" of
>this device').
>
>There aren't that many people who actually care, I suspect.

Sure, It's obviously not 1:1, what I had in mind was for the controller
to show what devices it exports in the sense of raw devices, but I agree
the other way makes a lot more sense. My problem was how to be devfs
agnostic, but you answered with "ioctl or syscall" and that would indeed
be ok. The ioctl things make it appliable to network interfaces as well,
which is good.

The need to do this link from a /dev to the driverfs, I suspect, will exist
only for case like setting up the firmware, though I can imagine one may
want to tweak some IDE settings (available via driverfs in your proposed
scheme) knowing only the /dev node.

Ben.



