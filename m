Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316838AbSINNhl>; Sat, 14 Sep 2002 09:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316842AbSINNhl>; Sat, 14 Sep 2002 09:37:41 -0400
Received: from news.cistron.nl ([62.216.30.38]:5380 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S316838AbSINNhj>;
	Sat, 14 Sep 2002 09:37:39 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: Possible bug and question about ide_notify_reboot in
	drivers/ide/ide.c (2.4.19)
Date: Sat, 14 Sep 2002 13:42:06 +0000 (UTC)
Organization: Cistron
Message-ID: <alvebe$45r$1@ncc1701.cistron.net>
References: <20020914010101.75725.qmail@web40502.mail.yahoo.com> <20020914095356.GA28271@merlin.emma.line.org> <1032010655.12892.8.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=iso-8859-15
X-Trace: ncc1701.cistron.net 1032010926 4283 62.216.29.67 (14 Sep 2002 13:42:06 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1032010655.12892.8.camel@irongate.swansea.linux.org.uk>,
Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
>> How about this: The FLUSH CACHE command has only recently become a
>> mandatory command for non-PACKET devices, so there may be drives that do
>> implement a write cache, but do NOT implement the FLUSH CACHE -- and
>> still adhere to some older edition of the ATA standard.
>
>Worse than that. There are drives that did implement it - as a no-op.
>They didn't even say "Umm sorry no can do"

Putting the drive in stand-by mode has the side effect of flushing
the cache. So before poweroff, send the FLUSH CACHE command,
then send the standby command, hope that one of them works ..

I put put-the-drive-in-standby-mode stuff in halt.c of sysvinit
after several reports of fs corruption at poweroff and it seems
to have fixed the problems for the people who reported them.

Mike.

