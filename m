Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbUCDUjN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 15:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbUCDUjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 15:39:13 -0500
Received: from 18-165-237-24-mvl.nwc.gci.net ([24.237.165.18]:60350 "EHLO
	nevaeh-linux.org") by vger.kernel.org with ESMTP id S262129AbUCDUjM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 15:39:12 -0500
Date: Thu, 4 Mar 2004 11:39:09 -0900 (AKST)
From: Arthur Corliss <corliss@digitalmages.com>
X-X-Sender: acorliss@bifrost.nevaeh-linux.org
To: Rik van Riel <riel@redhat.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] 2.6.x BSD Process Accounting w/High UID
In-Reply-To: <Pine.LNX.4.44.0403041451360.20043-100000@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.58.0403041103500.24930@bifrost.nevaeh-linux.org>
References: <Pine.LNX.4.44.0403041451360.20043-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Mar 2004, Rik van Riel wrote:

> On Thu, 4 Mar 2004, Arthur Corliss wrote:
>
> > The patch only changes two lines which redefine the ac_uid/ac_gid fields as
> > uid_t/gid_t respectively.  Fixes accounting for high uid/gids.
>
> Do the userspace commands that parse the acct files
> know how to deal with this format change ?

Well, that's the ugly part.  I had to munge glibc's sys/acct.h to reflect the
same changes as well to get the gnu tools to read the file correctly (the
accounting file does need to be started fresh with this struct, btw).

Here's the problem:  the kernel uses 32 bit uids internally, but external code
would default to 16 bit due to the ifdefs.

Unfortunately, I don't how else to support accounting with high uids.  All it
takes is two lines each in two files (linux/acct.h & sys/acct.h) to get
everything to work correctly.

So, what's the consensus:  are we going to leave accounting broken for high
uids, or support only low uids?  If I can get a patch accepted by the glibc
maintainers as well this will work for everyone.

I actually use high uids, so this is production issue for me.  :-P

	--Arthur Corliss
	  Bolverk's Lair -- http://arthur.corlissfamily.org/
	  Digital Mages -- http://www.digitalmages.com/
	  "Live Free or Die, the Only Way to Live" -- NH State Motto
