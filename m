Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262998AbUC2RQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 12:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbUC2RP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 12:15:26 -0500
Received: from gprs214-218.eurotel.cz ([160.218.214.218]:36738 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263010AbUC2RNB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 12:13:01 -0500
Date: Mon, 29 Mar 2004 19:12:45 +0200
From: Pavel Machek <pavel@ucw.cz>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040329171245.GB1478@elf.ucw.cz>
References: <20040320083411.GA25934@wohnheim.fh-wedel.de> <s5gznab4lhm.fsf@patl=users.sf.net> <20040320152328.GA8089@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040320152328.GA8089@wohnheim.fh-wedel.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > What happens if the disk fills while you are making the copy?  Will
> > open(2) on an *existing file* then return ENOSPC?
> 
> Correct.  It would be possible to always succeed and return -ENOSPC
> on every write().  But then mmap() has the same problem again, so
> serious headache would be the only gain from this little excercise.

> > I do not think you can implement this without changing the interface
> > to open(2).  Which means applications have to be made aware of it
> > anyway.  Which means you might as well leave your implementation as-is
> > and let userspace worry about creating the copy (and dealing with the
> > resulting errors).
> 
> Good point.  Vote is now 2:0 for the simple approach.

Well, 99% need no special handling on ENOSPC during open just
now. However, implementing file copying to each one would be serious
headache.

Applications can not be sure that it is existing file. If you
do stat followed by open, someone may have removed the file in
between. So it is not so new case.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
