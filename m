Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266413AbUFQI10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266413AbUFQI10 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 04:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266414AbUFQI10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 04:27:26 -0400
Received: from tor.morecom.no ([64.28.24.90]:49033 "EHLO tor.morecom.no")
	by vger.kernel.org with ESMTP id S266413AbUFQI1T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 04:27:19 -0400
Subject: Re: mode data=journal in ext3. Is it safe to use?
From: Petter Larsen <pla@morecom.no>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: linux-kernel@vger.kernel.org, ext3 <ext3-users@redhat.com>
In-Reply-To: <200406160734.i5G7YZwV002051@car.linuxhacker.ru>
References: <40FB8221D224C44393B0549DDB7A5CE83E31B1@tor.lokal.lan>
	 <1087322976.1874.36.camel@pla.lokal.lan>
	 <200406160734.i5G7YZwV002051@car.linuxhacker.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1087460837.2765.31.camel@pla.lokal.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 17 Jun 2004 10:27:17 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I comment inline..

> PL> Can anybody of you acknowledge or not if mode data=journal in ext3 is
> PL> safe to use in Linux kernel 2.6.x?
> PL> Wee need to have a very consistent and integrity for our filesystem, and
> PL> it would then be desired to journal both data and metadata.
> 
> OLEG> Actually data=journal mode would gain you mostly zero extra consistency compared
> to data=ordered mode. (the only more consistency bit that you get is
> correct mtime on files that have their pages overwritten, I think).
> You have zero control over transaction boundaries in ext3, so you still need
> to design your applications in such a way that they have their own
> sort of transactions (if this is needed).

So your conclusion is that data=journal mode is useless if you do not
want a correct mtime?

It would be a littles sense in developing the data=journal mode if this
is the only benefit, don't you think?

>From the Linux/Documentation/filesystems/ext3.txt

data=journal            All data are committed into the journal prior
                        to being written into the main file system.

data=ordered    (*)     All data are forced directly out to the main
file                    system prior to its metadata being committed to
                        the journal.

My problem is that ext3 in the latest kernel, 2.6.x and the latest
2.4.x, are not well documented around the web. Whitepapers and so are
pretty old. Much have changed I belive in ext3 since it was first
introduced by Dr. Tweedie. The first release was journaling both data
and metadata, se also the transcript from Dr. Tweedie from the Ottawa
Linux Symposium 20th July 2000.
http://olstrans.sourceforge.net/release/OLS2000-ext3/OLS2000-ext3.html

There he says that they are journaling both metadata and data, but that
the design goal is not to do that. So can this be interpreted that mode
data=journal is only there for historic reasons?
 

> PL> Data integrity is much more important for us than speed.
> 
> OLEG> It is not clear what sort of extra data integrity do you expect from data
> journaling mode and why do you think it is there.

I would belive that the goal for such a mode data=journal would gain
extra data integrity because it also journals data. Why should it not? I
would belive that it makes sense to have these different modes so people
can choose the best mode for there applications.

> OLEG> Garbage in files should not happen in data ordered mode as data pages are
> written first before metadata updates are committed.

Are you sure?


Petter


