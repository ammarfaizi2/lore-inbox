Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267624AbSLFVNZ>; Fri, 6 Dec 2002 16:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267629AbSLFVNZ>; Fri, 6 Dec 2002 16:13:25 -0500
Received: from pc-80-195-35-2-ed.blueyonder.co.uk ([80.195.35.2]:20869 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S267624AbSLFVNZ>; Fri, 6 Dec 2002 16:13:25 -0500
Subject: Re: [patch] fix the ext3 data=journal unmount bug
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Chris Mason <mason@suse.com>
Cc: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
       ext3 users list <ext3-users@redhat.com>
In-Reply-To: <1039206858.9244.130.camel@tiny>
References: <3DF0F69E.FF0E513A@digeo.com> <1039203287.9244.97.camel@tiny> 
	<3DF0FE4F.5F473D5E@digeo.com> 
	<1039204675.5301.55.camel@sisko.scot.redhat.com> 
	<1039206858.9244.130.camel@tiny>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Dec 2002 21:22:53 +0000
Message-Id: <1039209773.5300.84.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2002-12-06 at 20:34, Chris Mason wrote:

> The bulk of the sync(2) will be async though, since most of the io is
> actually writing dirty data buffers out.  We already do that in two
> stages.

Not with data journaling.  That's the whole point: the VFS assumes too
much about where the data is being written, when.

> For 2.5, if an FS really wanted a two stage sync for it's non-data
> pages

But it's data that is the problem.  For sync() semantics,
data-journaling only requires that the pages have hit the journal.  For
umount, it is critical that we complete the final writeback before
destroying the inode lists.

Cheers,
 Stephen
