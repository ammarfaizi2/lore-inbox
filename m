Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267633AbSLFWPo>; Fri, 6 Dec 2002 17:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267635AbSLFWPo>; Fri, 6 Dec 2002 17:15:44 -0500
Received: from pc-80-195-35-2-ed.blueyonder.co.uk ([80.195.35.2]:9094 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S267633AbSLFWPn>; Fri, 6 Dec 2002 17:15:43 -0500
Subject: Re: [patch] fix the ext3 data=journal unmount bug
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Chris Mason <mason@suse.com>
Cc: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
       ext3 users list <ext3-users@redhat.com>
In-Reply-To: <1039212420.9244.173.camel@tiny>
References: <3DF0F69E.FF0E513A@digeo.com> <1039203287.9244.97.camel@tiny> 
	<3DF0FE4F.5F473D5E@digeo.com> 
	<1039204675.5301.55.camel@sisko.scot.redhat.com> 
	<1039206858.9244.130.camel@tiny> 
	<1039209773.5300.84.camel@sisko.scot.redhat.com> 
	<1039212420.9244.173.camel@tiny>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Dec 2002 22:25:13 +0000
Message-Id: <1039213513.4189.124.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2002-12-06 at 22:07, Chris Mason wrote:

> But with data journaling, there's a limited amount data pending that
> needs to be sent to the log.  It isn't like the data pages in the
> data=writeback, where there might be gigs and gigs worth of pages.  

That's true right now, but it may not be for other cases.  For example,
a phase-tree type of filesystem may have huge amounts of data
accumulated behind the commit, and any filesystem doing deferred block
allocation will also have a lot of data which needs to be synced
intelligently, not just by the VM walking the dirty buffer lists itself.

> It seems like a natural progression to start adding journal address
> spaces to deal with this instead of extra stuff in the super code, where
> locking and super flag semantics make things sticky.

Absolutely, and I think an entirely separate ->sync_fs method is the way
to go, as it doesn't assume any specific semantics about what data
structure is getting locked in what fashion.

--Stephen

