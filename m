Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262834AbUCOWWV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 17:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262825AbUCOWUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 17:20:35 -0500
Received: from mail.tpgi.com.au ([203.12.160.61]:9920 "EHLO mail4.tpgi.com.au")
	by vger.kernel.org with ESMTP id S262819AbUCOWUJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 17:20:09 -0500
Subject: Re: Remove pmdisk from kernel
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Reply-To: ncunningham@users.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Michael Frank <mhf@linuxmail.org>
In-Reply-To: <20040315135328.0f704933.akpm@osdl.org>
References: <20040315195440.GA1312@elf.ucw.cz>
	 <20040315125357.3330c8c4.akpm@osdl.org> <20040315205752.GG258@elf.ucw.cz>
	 <20040315132146.24f935c2.akpm@osdl.org>
	 <1079379519.5350.20.camel@calvin.wpcb.org.au>
	 <20040315135328.0f704933.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1079381659.5356.73.camel@calvin.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5-2.norlug 
Date: Tue, 16 Mar 2004 09:14:19 +1300
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2004-03-16 at 10:53, Andrew Morton wrote:
> Nigel Cunningham <ncunningham@users.sourceforge.net> wrote:
> >
> > On Tue, 2004-03-16 at 10:21, Andrew Morton wrote:
> > > Pavel Machek <pavel@ucw.cz> wrote:
> > > >
> > > > I believe that you don't want swsusp2 in 2.6. It has hooks all over
> > > > the place:
> > > > ...
> > > > 109 files changed, 3254 insertions(+), 624 deletions(-)
> > > 
> > > Ahem.  Agreed.
> >
> > Most of those changes are hooks to make the freezer for more reliable.
> > That part of the functionality could be isolated from the bulk of
> > suspend2. Would that make you happy?
> 
> It would make us happier.  Even happier would be a series of small, well
> explained patches which bring swsusp into a final shape upon which more
> than one developer actually agrees.

I'd love to do that too. Unfortunately I'm really busy with my new job,
so things have progressed far more slowly than I'd have liked. I'm also
not sure how to deal with some of the changes that just about completely
rewrite sections.

> These wholesale replacements and deletions are an indication that something
> has gone wrong with the development process here.

I spent a long time trying to get the freezer working reliably with the
kind of implementation Pavel uses. The problem I kept running into time
and again was that you can't know dependancies between processes when it
comes to signalling them; process A might happily be frozen, but then
process B can't be frozen becaue it is waiting on something process A
has (eg ls/nfsd). By tracking which processes are in those
'can't-be-frozen-here' sections, I have managed to make the freezer far
more reliable, even under high load. Michael Frank has done some extreme
stress testing and can verify this.

Nigel
-- 
Nigel Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6253 0250 (home)

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

