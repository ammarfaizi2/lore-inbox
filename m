Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266221AbTGJAwP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 20:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266224AbTGJAwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 20:52:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48010 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266221AbTGJAwA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 20:52:00 -0400
Message-ID: <3F0CBC08.1060201@pobox.com>
Date: Wed, 09 Jul 2003 21:06:16 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@digeo.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: RFC:  what's in a stable series?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So, I was wondering if it is possible to find a consensus on what sorts 
of changes are ok in a stable series, as it matures.  This mainly 
applies to 2.4 right now, but I am interested in thoughts on 2.6.x also.


The recent "big fuss over a small change", the direct_IO API change, is 
indicative to me of a larger question:  what sort of API changes are 
acceptable in a stable series?

Linux has traditionally been fairly loose with caring about API changes. 
  We "try" to make sure major changes all occur during the development 
series, but reality doesn't always play out so nicely.  The 
oft-mentioned chicken-n-egg situation:  people really only test the 
stable series' heavily, so problems that should have been caught during 
development (if the world was perfect) are instead caught during the 
stable series.  New hardware and features appear, that our existing APIs 
do not take into account.

First example is the direct_IO change.  There are valid reasons to 
include the change, and valid reasons to avoid it.  Vendors (and 
-ac/-aa?) appear to be shipping this non-standard direct_IO API.  It's a 
good change and has definite value, so why not include it in the 2.4.x 
kernel?  The other side of the argument is breakage not immediately 
visible:  the people maintaining drivers that support multiple kernels 
must deal with N variations of the same API, within the stable series.

I know the gut reaction on lkml is often to trash these people, but 
let's be realistic.  Linux is huge these days.  Drivers normally start 
life outside the tree, and then once acceptable, are merged.  Other 
drivers must be cross-kernel compatible in order to support all the 
customers that the hardware vendor decides to support.  Red Hat, SuSE, 
Mandrake, etc. distros in the field are not automagically upgraded -- so 
if a driver for those existing releases is desired, one must deal with 
all the API changes.  API changes in a stable series instantly make life 
harder on all these people.

The flip side of the coin is progress.

If most vendors are shipping a non-mainstream change, why not make it 
mainstream?
Linux users buying new, cool hardware would logically want a driver from 
the stable series to drive their hardware.  If API changes are required 
to support this hardware, why not go ahead and make the change?  It will 
increase Linux acceptable, market penetration, make people happy, etc., etc.

Adding into the mix, until recently, the 2.4.x series was proceeding at 
a glacial pace.  I think Marcelo has demonstrated that this situation is 
changes, but we still need to consider it's effects.  2.4.21 was a 
fairly large chunk of changes, because it took so long.  2.4.22 is 
absorbing the after-effects of those changes.  So one would expect that, 
(a) with such a time lag between 2.4.x releases (previously), and (b) no 
2.6.0 kernel yet, it is understandable that driver authors are 
concentrating on 2.4, because that's where the users are right now.

What do to?

Currently we are really operating on the "hope and pray" system.  Nobody 
(IMO) really pays much attention to the API changes, since the 2.4.x 
releases were so far apart.  Between releases, "features depending on 
features depending features" situations were created.  However, since 
Marcelo has fixed this problem, I feel that some reflection on what a 
stable series means is called for.

Does it mean, no API changes except for security (or similarly severe) bugs?
Does it mean, no userland ABI changes, but API changes affecting onto 
the kernel are ok?
Does it mean, "just don't break things such that people are pissed off"?

I request the community's input, particularly those CC'd, for some sort 
of direction or consensus on this.

In any case, I personally feel that increased stability of the API, 
coupled with the increased frequency of releases, will make the most 
people happy.  I would prefer some sort of 2.4.x API freeze, say 
post-2.4.22, but maybe that's too radical?

	Jeff



