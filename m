Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbUCPWeI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 17:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbUCPWeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 17:34:08 -0500
Received: from mail.tpgi.com.au ([203.12.160.100]:60891 "EHLO
	mail5.tpgi.com.au") by vger.kernel.org with ESMTP id S261778AbUCPWeB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 17:34:01 -0500
Subject: Re: [Swsusp-devel] Re: The verdict on the future of suspending to
	disk?
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Reply-To: ncunningham@users.sourceforge.net
To: Pavel Machek <pavel@ucw.cz>
Cc: Michael Frank <mhf@linuxmail.org>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Suspend development list <swsusp-devel@lists.sourceforge.net>
In-Reply-To: <20040316151003.GA24837@atrey.karlin.mff.cuni.cz>
References: <1079408330.3403.5.camel@calvin.wpcb.org.au>
	 <20040316113717.GB2282@elf.ucw.cz> <20040316121524.GI2175@elf.ucw.cz>
	 <opr4yiu1ar4evsfm@smtp.pacific.net.th>
	 <20040316151003.GA24837@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Message-Id: <1079468912.3400.96.camel@calvin.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5-2.norlug 
Date: Wed, 17 Mar 2004 09:28:32 +1300
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2004-03-17 at 04:10, Pavel Machek wrote:
> It should suspend at any load, but AFAICR those hooks are not for
> that. They are neccessary for "crashed nfs server case", which kill
> -SIGSTOP does not handle. (IMNSHO thats bug in -SIGSTOP and pretty
> orthogonal to swsusp).

The NFS example was just one example; they are intended for 'suspend at
any load'. Actually, I should say, they're intended for 'suspend first
time at any load'. Maybe I should go back into the mailing list logs
from around the time when we made the change, to see again the kind of
issues we were attacking.

> O. Do not impair system reliablity *when swsusp is not in use*.
>    Do not make further development of system harder by putting too
>    much hooks into other code.

I believe we achieve that. All the hooks do is atomically adjust a
counter of the number of busy processes, adjust process flags (in the
case of processes running sync), and check that we're not trying to
suspend. None of those things should affect reliability, and months of
testing by many users has not given any indication that they do.

> > 3. Can be argued about: Compression or no compression, reboot functionality
> >    for multi boot or not, Escape or no Escape (I need it every day) -
> >    If you ever would dare to suspend you would want an Escape function too! 
> >    :-)
> 
> For first merge, I'd like to have simplest possible version, that's no
> compression, powerdown at the end, no escape.

Not arguing there. I either want to merge the whole lot at once
(unlikely, I know), or in discrete patches. I'm sure there must be some
bugs left somewhere that people will spot.

Nigel
-- 
Nigel Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6253 0250 (home)

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

