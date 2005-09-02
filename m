Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750921AbVIBTP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbVIBTP6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 15:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbVIBTP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 15:15:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8426 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750921AbVIBTP5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 15:15:57 -0400
Subject: Re: IDE HPA
From: Peter Jones <pjones@redhat.com>
Reply-To: pjones@redhat.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "ATARAID (eg, Promise Fasttrak, Highpoint 370) related discussions" 
	<ataraid-list@redhat.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1125687557.30867.26.camel@localhost.localdomain>
References: <87941b4c05082913101e15ddda@mail.gmail.com>
	 <87941b4c05083008523cddbb2a@mail.gmail.com>
	 <1125419927.8276.32.camel@localhost.localdomain>
	 <87941b4c050830095111bf484e@mail.gmail.com>
	 <62b0912f0509020027212e6c42@mail.gmail.com>
	 <1125666332.30867.10.camel@localhost.localdomain>
	 <62b0912f05090206331d04afd3@mail.gmail.com>
	 <E1EBCdS-00064p-00@chiark.greenend.org.uk>
	 <62b0912f05090209242ad72321@mail.gmail.com>
	 <1125680712.30867.20.camel@localhost.localdomain>
	 <62b0912f05090210441d3fa248@mail.gmail.com>
	 <1125684567.31292.2.camel@localhost.localdomain>
	 <1125687557.30867.26.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Red Hat, Inc.
Date: Fri, 02 Sep 2005 15:14:43 -0400
Message-Id: <1125688483.31292.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.8 (2.3.8-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-02 at 19:59 +0100, Alan Cox wrote:
> On Gwe, 2005-09-02 at 14:09 -0400, Peter Jones wrote:
> > (if there's already a straightforward way, feel free to clue me in --
> > but the default should almost certainly be to assume the HPA is set up
> > correctly, shouldn't it?)
> 
> The normal use of HPA is to clip drives to get them past BIOS boot
> checks.

Ugh.  So some BIOSes use it for legitimate reasons (like thinkpads), and
some use it to work around BIOS bugs.  Great.

>  The thinkpads come with a pre-installed partition table which
> will protect the HPA unless the user goes to town removing it.

Mine didn't, but it does have an HPA.  Thankfully we weren't disabling
it yet when I installed my laptop -- I know others who weren't so lucky.
So this partitioning scheme hasn't always been the case...

And it seems broken anyway.  The point of the HPA is to make the OS see
a smaller/different disk layout, unless it's actually trying to update
things that are "protected", right?  If so, the partition table pointing
outside of the the disk when the HPA configuration hasn't been changed
from the bootup default totally broken :/

It really sounds better (to my naive mind, at least) to whitelist the
known-broken BIOSes.

> The ideal case would be that the partition table is considered at boot
> to see if the HPA matches the partitiont table or not. You'd also then
> need dynamic HPA enable/disable for installers and other tools to go
> with that.

Well, installers probably should be aware, yes -- that's why I mentioned
userland interfaces to enabling/disabling.  But to me it still seems
like we want to disable the HPA during installation and bootup, but only
if your BIOS is doing things wrong.

> Send patches.

Point taken.
-- 
  Peter

