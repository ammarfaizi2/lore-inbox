Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbVJXV7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbVJXV7K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 17:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbVJXV7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 17:59:10 -0400
Received: from tim.rpsys.net ([194.106.48.114]:715 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751329AbVJXV7I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 17:59:08 -0400
Subject: Re: Sharp brick c-3000
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20051024211632.GA7127@elf.ucw.cz>
References: <20051024211632.GA7127@elf.ucw.cz>
Content-Type: text/plain
Date: Mon, 24 Oct 2005 22:59:04 +0100
Message-Id: <1130191145.8345.185.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2005-10-24 at 23:16 +0200, Pavel Machek wrote:
> I'm not sure what I did wrong... I can still access "flasher" menu, by
> holding down okay after reset, I press 4, 2, Y after that, screen just
> goes black, but I do not get "update screen" after that. SD inserted
> or not, no change. I'll play a bit more.

Ah, I can guess :-(. Have a look at this:
http://www.h5.dion.ne.jp/~rimemoon/zaurus/pic/nandmap.jpg (from
http://www.h5.dion.ne.jp/~rimemoon/zaurus/memo_006.htm)

updater.sh writes the kernel into the space marked "2nd Kernel" - 1264kb
long. I'd guess you wrote a kernel larger than this, you overwrite the
initrd.gz which is used to run updater.sh. We really need to add a size
check to the OE copy of updater.sh. Anyhow, the damage has been done and
that update route is now broken. I should have warned about this
although I assumed Sharp might have fixed it on newer devices :-/.

So I said the Zaurus is unbrickable and you appear to have bricked it?
There is another level of system restore thankfully. In the past, to fix
this problem on both a c700 and a c760 I've used the files from here:

http://pocketworkstation.org/files/recover/

(http://pocketworkstation.org/files/recover/README-flash-recover.txt is
the instructions I used.)

You need to find the files for the c3000 and then attempt this
procedure. I don't have the files for the c3000 but you should be able
to get from somewhere. When you find them, let me know as I might also
find them handy ;-).

Your other alternative is to perform a NAND Restore, if you can find a
NAND backup for the C3000. The D+M menu has an option for this and I'm
sure it will also be documented on the web. When in this state I
couldn't get that to work on my c760 though it could have been the image
I was trying to restore it with or my CF card...

Incidentally OE has safeguards that warn you if the kernel is too big...

Richard


