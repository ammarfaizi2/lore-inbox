Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264915AbUGMMYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264915AbUGMMYT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 08:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264917AbUGMMYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 08:24:19 -0400
Received: from smtp2.wanadoo.fr ([193.252.22.29]:6937 "EHLO
	mwinf0201.wanadoo.fr") by vger.kernel.org with ESMTP
	id S264915AbUGMMYR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 08:24:17 -0400
From: Waldo Bastian <bastian@kde.org>
To: kde-core-devel@kde.org
Subject: Re: kconfig's file handling (was: XFS: how to NOT null files on fsck?)
Date: Tue, 13 Jul 2004 14:31:43 +0200
User-Agent: KMail/1.6.52
Cc: Tim Connors <tconnors@astro.swin.edu.au>, linux-kernel@vger.kernel.org
References: <20040713110520.GB8930@ugly.local>
In-Reply-To: <20040713110520.GB8930@ugly.local>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200407131431.43478.bastian@kde.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tue July 13 2004 13:05, Oswald Buddenhagen wrote:
> heya,
>
> read the attachement first (put on your asbestos underwear first ;).
> not exactly news to me, but somehow i never got to fixing it ...

There is nothing to fix, we already use a tempfile + rename, it's in KSaveFile 
since 1999. Or just look with strace if you don't believe me. This Tim 
Connors guy shouldn't talk about things he obviously knows nothing about.

As far as I can see the problem is that the filesystem writes out the meta 
data before the actual file data hits the disk which creates a period of time 
in which the on-disk state of the filesystem contains trashed files. I 
believe ReiserFS actually has an option to do things in a sane order so that 
it doesn't trash recently used files on an unclean shutdown.

The sentiment among filesystem developers seem to be that they don't care if 
they trash files as long as the filesystem itself remains in a consistent 
state. This kind of dataloss is the result of that attitude, either go 
complain with them if it bothers you, or use a filesystem that does it right.

Cheers,
Waldo
- -- 
bastian@kde.org  |   KDE Community World Summit 2004  |  bastian@suse.com
bastian@kde.org  | 21-29 August, Ludwigsburg, Germany |  bastian@suse.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFA89YvN4pvrENfboIRAptaAJ9YBv63UUL7Elcl3QsjYJPbGche7wCdEzKr
Y+I4Kyi+p+r/gPixNdXQphE=
=c3HD
-----END PGP SIGNATURE-----
