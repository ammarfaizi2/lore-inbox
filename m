Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264535AbTL3TNx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 14:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265306AbTL3TNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 14:13:53 -0500
Received: from pirx.hexapodia.org ([65.103.12.242]:32586 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S264535AbTL3TNw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 14:13:52 -0500
Date: Tue, 30 Dec 2003 13:13:50 -0600
From: Andy Isaacson <adi@hexapodia.org>
To: Ed Tomlinson <edt@aei.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0 - Watchdog patches (BK consistency checks)
Message-ID: <20031230131350.A32120@hexapodia.org>
References: <20030906125136.A9266@infomag.infomag.iguana.be> <Pine.LNX.4.58.0312291226400.2113@home.osdl.org> <20031230004907.GA29143@merlin.emma.line.org> <200312300836.16559.edt@aei.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200312300836.16559.edt@aei.ca>; from edt@aei.ca on Tue, Dec 30, 2003 at 08:36:15AM -0500
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 30, 2003 at 08:36:15AM -0500, Ed Tomlinson wrote:
> On December 29, 2003 07:49 pm, Matthias Andree wrote:
> > Well, talk about FAAAAAAST drives (10,025/min SCSI kind) unless you have
> > time to waste on all those BK consistency checks (which are, of course,
> > what #3 is all about).
> >
> > Or am I missing some obvious short cut?
> 
> Is there a way to tell BK when to do consistency checks?  Here they
> easily take 15-20 min each time.  I would love to be able to tell BK
> to defer these checks.

The consistency check definitely should not take 15 minutes.  It should
be (much) less than 30 seconds.  What is the hardware you're running on?

I'm running on an Athlon 2 GHz (XP 2400+) with 512MB and a 7200RPM IDE
disk, and I can do a complete clone (with full data copy and consistency
check) of the 2.4 tree in 1:40.  That was with cold caches; with the
sfile copies and "checkout:get", a half-gig isn't enough to cache
everything.  The consistency check is about 19 seconds (bk -r check -acv).

If you keep all your trees on one filesystem, you can use "bk clone -l"
to make hard-links for the s. files.  This means you can create a
complete copy of the tree in about 6 MB, in 40 seconds or so.  BK is
very careful to check the links and break them when necessary.  

To save diskspace, you can turn off "checkout:get", like so:

--- 1.4/BitKeeper/etc/config    Tue Dec 30 12:16:44 2003
+++ edited/BitKeeper/etc/config Tue Dec 30 12:13:53 2003
@@ -3,4 +3,3 @@
 logging: logging@openlogging.org
 email: torvalds@transmeta.com
 [davem]checkout:none
-[]checkout:get

(Or, add a [$USER]checkout:none line if that is easier.)

If the consistency check is problematic, let's fix that problem -- don't
turn it off, it's valuable.  It's found IDE corruption, it's found BK
bugs, it's found users who move s. files around behind BK's back.

-andy
