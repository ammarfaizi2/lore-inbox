Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262915AbUCPBmi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 20:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263199AbUCPBlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 20:41:44 -0500
Received: from mail.tpgi.com.au ([203.12.160.100]:3305 "EHLO mail5.tpgi.com.au")
	by vger.kernel.org with ESMTP id S262927AbUCPBdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 20:33:07 -0500
Subject: Re: Remove pmdisk from kernel
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Reply-To: ncunningham@users.sourceforge.net
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <20040316005618.GB1883@elf.ucw.cz>
References: <20040315195440.GA1312@elf.ucw.cz>
	 <20040315125357.3330c8c4.akpm@osdl.org> <20040315205752.GG258@elf.ucw.cz>
	 <20040315132146.24f935c2.akpm@osdl.org>
	 <1079379519.5350.20.camel@calvin.wpcb.org.au>
	 <20040316005618.GB1883@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1079393256.2043.5.camel@calvin.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5-2.norlug 
Date: Tue, 16 Mar 2004 12:27:36 +1300
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2004-03-16 at 13:56, Pavel Machek wrote:
> Hi!
> 
> > Most of those changes are hooks to make the freezer for more reliable.
> > That part of the functionality could be isolated from the bulk of
> > suspend2. Would that make you happy?
> 
> Yes, that would be very good. It would make it easy to see actual
> changes..
> 
> [I still do not understand why those hooks are neccessary... kill
> -SIGSTOP works, right?]

Not always. Take for example the case where you have an NFS mount and
happen to be doing an ls when the suspend cycle is started. If you
signal the NFSd threads before the ls thread, the NFS threads will
refrigerate okay, but the ls thread will fail to stop because it's
waiting for data from the nfsd threads.

The best way to test the reliability of the current freezer
implementation is to grab Michael's test patches. They can load the
system down with NFS access, kernel compiles, benchmarks and so on.
You'll quickly see the freezer fail. My implementation handles those
loads flawlessly, and where problems are found, they're easily fixed.

Regards,

Nigel
-- 
Nigel Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6253 0250 (home)

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

