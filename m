Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266148AbUA2LoI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 06:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266156AbUA2LoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 06:44:08 -0500
Received: from thunk.org ([140.239.227.29]:21163 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S266148AbUA2LoF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 06:44:05 -0500
Date: Thu, 29 Jan 2004 06:44:00 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Dittmer <j.dittmer@portrix.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 on raid5 failure
Message-ID: <20040129114400.GA27702@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Jan Dittmer <j.dittmer@portrix.net>, linux-kernel@vger.kernel.org
References: <400A5FAA.5030504@portrix.net> <20040118180232.GD1748@srv-lnx2600.matchmail.com> <20040119153005.GA9261@thunk.org> <4010D9C1.50508@portrix.net> <20040127190813.GC22933@thunk.org> <401794F4.80701@portrix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <401794F4.80701@portrix.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 28, 2004 at 11:54:44AM +0100, Jan Dittmer wrote:
> >>After 2 days in my freshly setup debian (2.6.1-bk6), same error. But 
> >>this time at least I know it's because I tried to delete those files in 
> >>the lost+found directory...
> >
> >
> >How did you come to that conclusion?
> 
> sfhq:/mnt/data/1/lost+found# ls -l
> total 76
> d-wSr-----    2 1212680233 136929556    49152 Jun  7  2008 #16370
> -rwx-wx---    1 1628702729 135220664    45056 May  4  1974 #16380

Ok, this looks like random garbage has gotten written into inode table.  

If you can make this happen consistently with 2.6 and not with 2.4,
then that would be useful to know.  There may be some kind of race
condition or problem with either the raid5 code, or the combination of
raid5 plus ext3.  It's unlikely this kind of error would be caused by
a flaw in the ext3 code alone, since this is indicative of complete
garbage written to the inode table, or a block intended for another
location on disk getting written to the inode table.  The natural
suspect is at the block device layer and below.

						- Ted
