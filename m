Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263276AbTARHtW>; Sat, 18 Jan 2003 02:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263321AbTARHtW>; Sat, 18 Jan 2003 02:49:22 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:42715 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S263276AbTARHtV>;
	Sat, 18 Jan 2003 02:49:21 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15913.2330.891678.16666@napali.hpl.hp.com>
Date: Fri, 17 Jan 2003 23:58:18 -0800
To: Andrew Morton <akpm@digeo.com>
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, anton@samba.org,
       linux-kernel@vger.kernel.org
Subject: Re: recent change to exit_mmap
In-Reply-To: <20030117235317.01ad6b7b.akpm@digeo.com>
References: <20030118060522.GE7800@krispykreme>
	<20030117224444.08c48290.akpm@digeo.com>
	<15913.1396.22808.83238@napali.hpl.hp.com>
	<20030117235317.01ad6b7b.akpm@digeo.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 17 Jan 2003 23:53:17 -0800, Andrew Morton <akpm@digeo.com> said:

  Andrew> David Mosberger <davidm@napali.hpl.hp.com> wrote:
  >>  >>>>> On Fri, 17 Jan 2003 22:44:44 -0800, Andrew Morton
  >> <akpm@digeo.com> said:

  Andrew> Looks like ia64 needs work, too...
  >>  Yes, should be the same problem there.  The fix looks fine to
  >> me.  (Let's just hope I remember it when Linus puts it in his
  >> tree...).

  Andrew> I've updated that patch to cover ia64, but I think we'll run
  Andrew> with the other approach - just remove those calls to
  Andrew> SET_PERSONALITY().

  Andrew> They just seem illogical anyway - why are we switching into
  Andrew> the new image's personality prior to unmapping the old
  Andrew> image's memory?

I don't know why SET_PERSONALITY() came to be where it is now, but it
does make some sense to me.  One thing that comes to mind: on ia64, we
normally don't map data segments with execute permission but for
backwards-compatibility, we need to do that for x86 binaries.  I think
there might be a problem with that if SET_PERSONALITY() was done too
late.  Certainly something that could be fixed, but I suspect a
similar ordering issue (perhaps on SPARC?) might have triggered the
current placement of SET_PERSONALITY().

	--david
