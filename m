Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265150AbTLaPBy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 10:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265154AbTLaPBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 10:01:54 -0500
Received: from mail.aei.ca ([206.123.6.14]:12780 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S265150AbTLaPBv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 10:01:51 -0500
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0 - Watchdog patches (BK consistency checks)
Date: Wed, 31 Dec 2003 10:01:48 -0500
User-Agent: KMail/1.5.93
Cc: Andy Isaacson <adi@hexapodia.org>
References: <20030906125136.A9266@infomag.infomag.iguana.be> <200312300836.16559.edt@aei.ca> <20031230131350.A32120@hexapodia.org>
In-Reply-To: <20031230131350.A32120@hexapodia.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200312311001.48154.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 30, 2003 02:13 pm, Andy Isaacson wrote:
> On Tue, Dec 30, 2003 at 08:36:15AM -0500, Ed Tomlinson wrote:
> > On December 29, 2003 07:49 pm, Matthias Andree wrote:
> > > Well, talk about FAAAAAAST drives (10,025/min SCSI kind) unless you
> > > have time to waste on all those BK consistency checks (which are, of
> > > course, what #3 is all about).
> > >
> > > Or am I missing some obvious short cut?
> >
> > Is there a way to tell BK when to do consistency checks?  Here they
> > easily take 15-20 min each time.  I would love to be able to tell BK
> > to defer these checks.
>
> The consistency check definitely should not take 15 minutes.  It should
> be (much) less than 30 seconds.  What is the hardware you're running on?
>
> I'm running on an Athlon 2 GHz (XP 2400+) with 512MB and a 7200RPM IDE
> disk, and I can do a complete clone (with full data copy and consistency
> check) of the 2.4 tree in 1:40.  That was with cold caches; with the
> sfile copies and "checkout:get", a half-gig isn't enough to cache
> everything.  The consistency check is about 19 seconds (bk -r check -acv).

Its not a fast box.  Its an old K6-III 400 with 512MB with UDMA2 harddrives.

> If you keep all your trees on one filesystem, you can use "bk clone -l"
> to make hard-links for the s. files.  This means you can create a
> complete copy of the tree in about 6 MB, in 40 seconds or so.  BK is
> very careful to check the links and break them when necessary.

I use -ql for clones

> To save diskspace, you can turn off "checkout:get", like so:
>
> --- 1.4/BitKeeper/etc/config    Tue Dec 30 12:16:44 2003
> +++ edited/BitKeeper/etc/config Tue Dec 30 12:13:53 2003
> @@ -3,4 +3,3 @@
>  logging: logging@openlogging.org
>  email: torvalds@transmeta.com
>  [davem]checkout:none
> -[]checkout:get
>
> (Or, add a [$USER]checkout:none line if that is easier.)
>
> If the consistency check is problematic, let's fix that problem -- don't
> turn it off, it's valuable.  It's found IDE corruption, it's found BK
> bugs, it's found users who move s. files around behind BK's back.

I am not saying I do not want do have consistency checks done.  I do want
to control _when_ and how often they run

Ed
