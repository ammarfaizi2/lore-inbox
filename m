Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264957AbUGMMxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264957AbUGMMxd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 08:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264961AbUGMMxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 08:53:32 -0400
Received: from ktown.kde.org ([131.246.103.200]:41122 "HELO ktown.kde.org")
	by vger.kernel.org with SMTP id S264957AbUGMMx1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 08:53:27 -0400
Date: Tue, 13 Jul 2004 14:53:21 +0200
From: Oswald Buddenhagen <ossi@kde.org>
To: kde-core-devel@kde.org, linux-kernel@vger.kernel.org
Subject: Re: kconfig's file handling (was: XFS: how to NOT null files on fsck?)
Message-ID: <20040713125321.GA12130@ugly.local>
Mail-Followup-To: kde-core-devel@kde.org, linux-kernel@vger.kernel.org
References: <20040713110520.GB8930@ugly.local> <200407131431.43478.bastian@kde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407131431.43478.bastian@kde.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2004 at 02:31:43PM +0200, Waldo Bastian wrote:
> There is nothing to fix, we already use a tempfile + rename, it's in
> KSaveFile since 1999.
>
oh, indeed. i didn't dig deep enough. sorry for the noise.
the symlink case is handled differently, though (and it falls back to
in-place rewriting too early - the symlink target could be potentially
handled without in-place rewriting as well). consequently the paragraph
about in-place rewriting is valid, even if it is only a border case.

another thing to consider is a complete audit of kde regarding the
creation of files; i'm sure not everybody uses KSaveFile or equivalent
code. no, i don't volunteer. :}

> As far as I can see the problem is that the filesystem writes out the
> meta data before the actual file data hits the disk which creates a
> period of time in which the on-disk state of the filesystem contains
> trashed files.
>
yup

> I believe ReiserFS actually has an option to do things in a sane order
> so that it doesn't trash recently used files on an unclean shutdown.
> 
not only reiserfs.

> The sentiment among filesystem developers seem to be that they don't
> care if they trash files as long as the filesystem itself remains in a
> consistent state. This kind of dataloss is the result of that
> attitude, either go complain with them if it bothers you, or use a
> filesystem that does it right.
> 
the code is there, the additional integrity just doesn't come for free,
so it's disabled by default.

greetings

-- 
Hi! I'm a .signature virus! Copy me into your ~/.signature, please!
--
Chaos, panic, and disorder - my work here is done.
