Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265165AbUAEQsf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 11:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265168AbUAEQsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 11:48:35 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:2493 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S265165AbUAEQsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 11:48:30 -0500
Subject: Re: Possibly wrong BIO usage in ide_multwrite
From: Christophe Saout <christophe@saout.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <200401051712.41695.bzolnier@elka.pw.edu.pl>
References: <1072977507.4170.14.camel@leto.cs.pocnet.net>
	 <200401032302.32914.bzolnier@elka.pw.edu.pl>
	 <1073237458.6069.31.camel@leto.cs.pocnet.net>
	 <200401051712.41695.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain
Message-Id: <1073321295.7121.8.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 05 Jan 2004 17:48:15 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mo, den 05.01.2004 schrieb Bartlomiej Zolnierkiewicz um 17:12:

> > The IDE_TASKFILE_IO gets things right (from my point of view) and is
> > also much cleaner. (I would personally vote for dropping the non
> > TASKFILE_IO code, it would make my problem go away :D - why is it still
> > marked as experimental BTW? I've been using it since it was introduced,
> > without any problems)
> 
> There are still some issues to be resolved:
> - hangs during reading /proc/ide/<cdrom>/identify on some drives
>   (workaround is now known thanks to debugging done by Andi+BenH+Andre)
> - unexplained fs corruption on x86-64 with AMD IDE chipsets
>   (the real showstopper)
> - somebody needs to test taskfile code on old Promise PDC4030 controller
>   (low priority)

Unexplained corruptions. Coder's nightmare. ;) Yes, that's always really
bad. Unfortunately I don't have such a machine so I can't help trying to
nail it down.

> > Perhaps I can think of something else. It's really tricky...
> 
> I would like to remove non CONFIG_IDE_TASKFILE_IO paths in 2.6.x
> (after issues are resolved) instead of trying to fix them.

Sure, we agree on that point. I think everyone does.

BTW, I've found a not too complicated workaround for my particular
original problem so the bi_idx issue isn't a showstopper for my
device-mapper target. But apart from that the rewinding bi_idx to zero
thing still gives me headaches just being there. A small non-invasive
workaround won't make it much worse, it's hopefully going to die anyway.

Thanks for being patient with me. :-)
(and not raising new paranoia theories ;-))


