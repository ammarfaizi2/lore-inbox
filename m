Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262793AbUCOWLI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 17:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262824AbUCOWLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 17:11:08 -0500
Received: from mail.tpgi.com.au ([203.12.160.58]:21890 "EHLO mail2.tpgi.com.au")
	by vger.kernel.org with ESMTP id S262793AbUCOWKv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 17:10:51 -0500
Subject: Re: Dealing with swsusp vs. pmdisk
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Reply-To: ncunningham@users.sourceforge.net
To: Pavel Machek <pavel@ucw.cz>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "Theodore Ts'o" <tytso@mit.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040314003717.GI549@elf.ucw.cz>
References: <20040312224645.GA326@elf.ucw.cz>
	 <20040313004756.GB5115@thunk.org> <1079146273.1967.63.camel@gaston>
	 <20040313123620.GA3352@openzaurus.ucw.cz>
	 <1079223482.1960.113.camel@gaston>  <20040314003717.GI549@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1079381114.5349.62.camel@calvin.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5-2.norlug 
Date: Tue, 16 Mar 2004 09:05:14 +1300
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sun, 2004-03-14 at 13:37, Pavel Machek wrote:
> On Ne 14-03-04 11:18:02, Benjamin Herrenschmidt wrote:
> > 2.6. I don't see any problem merging it at this point as long as
> > it's not invasive (I haven't looked at the code though). If it's
> > self-contained, it's more/less like adding a driver.

Hi.

The most intrusive parts are:

- Freezer hooks (I can easily get suspend2 working with the old freezer
until people are convinced it's not up to the task). This accounts for
the vast majority of those file changes.
- Changes in vmscan to separate out freeing a single LRU page. When
reading/writing an image, suspend shots down pages added to the LRU list
as a result of it's activities, so as to keep the contents of the LRU
the same as at the start of the cycle. I reckon this might be done by
stopping the pages from being added to the LRU in the first place, but
haven't gotten around to asking whether this can be safely done. (The
current method works, so I haven't made it a priority before now). Short
summary: I freely admit this is ugly and could be done less invasively,
especially with help from some of the MM guys.
- I still have to get the console stuff using file descriptors for I/O
rather than direct calls; I have code there, but it's not being used yet
because it worked and then got broken. (Shouldn't take much to fix).

Regards,

Nigel
-- 
Nigel Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6253 0250 (home)

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

