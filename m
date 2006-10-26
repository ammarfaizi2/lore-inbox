Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423474AbWJZNBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423474AbWJZNBX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 09:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423476AbWJZNBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 09:01:23 -0400
Received: from raven.upol.cz ([158.194.120.4]:41146 "EHLO raven.upol.cz")
	by vger.kernel.org with ESMTP id S1423474AbWJZNBW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 09:01:22 -0400
Date: Thu, 26 Oct 2006 15:07:20 +0200
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re:[patch, rfc] kbuild: implement checksrc without building Cources...
Message-ID: <20061026130720.GA2765@flower.upol.cz>
References: <20061023153540.4d467a88.rdunlap@xenotime.net> <slrnejscd5.93p.olecom@flower.upol.cz> <slrnejsrjq.93p.olecom@flower.upol.cz> <20061024134508.adb14be6.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061024134508.adb14be6.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Oleg Verych <olecom@flower.upol.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2006 at 01:45:08PM -0700, Randy Dunlap wrote:
> On Tue, 24 Oct 2006 19:43:40 +0000 (UTC) Oleg Verych wrote:
> > This doesn't work, use ifs instead. Updated.
> > I have no idea what to do with generated sources and headers.
> > One may be: check target `if_changed' to be %.c or %.h and let it be
> > built.
> 
> Hi Oleg,
> 
> Yes, it works for me, with the exception of host-generated
> files, as you mentioned.  I ran into those with:
> IKCONFIG (the one that you mentioned), ATM_FORE200E firmware,
> IEEE 1394 OUI database (which I sent a patch for -- it should
> not be generated when the config option is not enabled),
> RAID456 tables, VIDEO_LOGO files, and CRC32 table.

I'm glad, that semi-working thing was helpful. But it's ugly hack.

Idea is to substitute objects (*.o) with sparse output, thus targets
like
,--
|%.o : %.c
+--
will be updated and new check will pass them (force check may be applied).
Also having results in files (even in so messy called *.o) is good for
collecting and sorting errors. Headers will be generated as needed.

Finally short statistics maybe printed in the end of the check:
[(stat -c %s *.o > 0 | wc -l) / find --name *.o]
  ^ with error file size > 0  / overall error files

But implementing all this in non-hack way isn't easy. Maybe Sam will
came back and will do it magically quickly. Until that, i'll try to
fight with current makefiles myself.

> Thanks for your time and effort.  Maybe Sam will have some ideas.

I've found "sparse" and read some philosophy from README. Nice.
Thanks you also !
____
