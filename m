Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293394AbSCFJQi>; Wed, 6 Mar 2002 04:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293408AbSCFJQ0>; Wed, 6 Mar 2002 04:16:26 -0500
Received: from mailhost.mipsys.com ([62.161.177.33]:12275 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S293394AbSCFJQK>; Wed, 6 Mar 2002 04:16:10 -0500
From: <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Martin Dalecki <dalecki@evision-ventures.com>
Cc: <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.6-pre2 IDE cleanup 16
Date: Wed, 6 Mar 2002 10:15:52 +0100
Message-Id: <20020306091552.19301@mailhost.mipsys.com>
In-Reply-To: <E16iPUx-0004vD-00@the-village.bc.nu>
In-Reply-To: <E16iPUx-0004vD-00@the-village.bc.nu>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I intend to kill the largely overdesigned taskfile stuff. It's broken
>> by design to provide this micro level of device access to *anybody*.
>> Operating systems should try to present the functionality of devices
>> in a convenient way to the user and not just mapp it directly to
>> user space.
>
>Martin - please go and use a macintosh for 8 weeks then come back. The
>unix philosophy is make the simple things easy make the complex possible. 
>Without that low level IDE access you might as well stop hacking on the IDE
>code because eventually nobody will be able to use your IDE code anyway

I would add to that than rather than killing the taskfile stuff, it
should instead be generalized and any IDE access be done via a taskfile.

I don't comment on the actual implementation quality as I didn't look
into it closely, but the point of passing requests as taskfile's
down to the lowest level driver allow more consistency between the
various pieces of the driver, more easily hooking of the low level
taskfile "apply" code to accomodate MMIO or strangely mapped IDE
controllers, etc...

Alan: BTW, Apple's Darwin has a nice ATA layer implementation that
happens to be completely taskfile based :) Ask Andre what he thinks
about their ATA & SCSI layer, except from bloat due to their C++
implementation, their overall design is actually really nice !

Ben.


