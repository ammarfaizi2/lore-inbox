Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267593AbSLFTsf>; Fri, 6 Dec 2002 14:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267594AbSLFTsf>; Fri, 6 Dec 2002 14:48:35 -0500
Received: from pc-80-195-35-2-ed.blueyonder.co.uk ([80.195.35.2]:45188 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S267593AbSLFTse>; Fri, 6 Dec 2002 14:48:34 -0500
Subject: Re: [patch] fix the ext3 data=journal unmount bug
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Chris Mason <mason@suse.com>, lkml <linux-kernel@vger.kernel.org>,
       ext3 users list <ext3-users@redhat.com>
In-Reply-To: <3DF0FE4F.5F473D5E@digeo.com>
References: <3DF0F69E.FF0E513A@digeo.com> <1039203287.9244.97.camel@tiny> 
	<3DF0FE4F.5F473D5E@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Dec 2002 19:57:55 +0000
Message-Id: <1039204675.5301.55.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2002-12-06 at 19:45, Andrew Morton wrote:

> > I see what ext3 gains from your current patch in the unmount case, but
> > the sync case is really unchanged because of interaction with kupdate.
> 
> True.  And I'd like /bin/sync to _really_ be synchronous because
> I use `reboot -f' all the time.  Even though SuS-or-POSIX say that
> sync() only needs to _start_ the IO.  That's rather silly.

But at the same time I'd like to avoid sync becoming serialised on its
writes.  If you've got a lot of filesystems mounted, doing each
filesystem's sync sequentially and synchronously is going to be a lot
slower than allowing async syncs.  In other words, for sync(2) we really
want async commit submission followed by a synchronous wait for
completion.  And that's probably more churn than I'd like to see at this
stage for 2.4.

Cheers, 
 Stephen

