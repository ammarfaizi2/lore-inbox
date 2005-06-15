Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbVFORji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVFORji (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 13:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVFORji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 13:39:38 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:7700 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S261236AbVFORjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 13:39:15 -0400
Message-ID: <42B067B6.9030009@suse.com>
Date: Wed, 15 Jun 2005 13:39:02 -0400
From: Jeff Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
Cc: fs <fs@ercist.iscas.ac.cn>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       viro VFS <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, zhiming@admin.iscas.ac.cn,
       qufuping@ercist.iscas.ac.cn, madsys@ercist.iscas.ac.cn,
       xuh@nttdata.com.cn, koichi@intellilink.co.jp,
       kuroiwaj@intellilink.co.jp, okuyama@intellilink.co.jp,
       matsui_v@valinux.co.jp, kikuchi_v@valinux.co.jp,
       fernando@intellilink.co.jp, kskmori@intellilink.co.jp,
       takenakak@intellilink.co.jp, yamaguchi@intellilink.co.jp,
       ext2-devel@lists.sourceforge.net, sct@redhat.com, shaggy@austin.ibm.com,
       xfs-masters@oss.sgi.com,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: [RFD] FS behavior (I/O failure) in kernel summit
References: <1118692436.2512.157.camel@CoolQ> <42ADC99D.5000801@namesys.com> <42ADFFD5.1090905@suse.com> <42AE1EE4.5090508@namesys.com>
In-Reply-To: <42AE1EE4.5090508@namesys.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hans Reiser wrote:
> Jeff, would you be willing to make a proposal for what should be done? 
> I would be interested in your suggestions.
> 
> Jeff Mahoney wrote:
> 
>>Hans -
>>
>>These tests must have been run on a kernel prior to 2.6.10-rc1. The I/O
>>error code exhibits behavior similar to ext3, so (1b). There are still
>>kinks to be worked out, but it's definitely not the "throw up our arms
>>and give up" that it used to be.
>>
>>Implementing behavior 1a for ext3 and reiserfs should be fairly trivial
>>- it just means that tests to check if the filesystem is in an aborted
>>state ("shutdown" in xfs terms) need to added to the call path in some
>>places, and be moved earlier in others.

Well it seems to me that all the XFS code does is check to see if the FS
is in a shutdown state really early in the call path. Adding a
super->s_errno or MS_ABORTED flag (i prefer the former, for flexibility)
to the VFS level to be checked before calling into the filesystem would
add the consistent behavior to all filesystems.

As far as the ReiserFS support goes, I was premature in stating that
ReiserFS supports behavior 1b. It does so in terms of journal errors,
but it does just warn and continue on other errors. I'm working on a
patch that introduces reiserfs_error() similar to ext3_error() that
replaces the warnings in many places. The behavior is configurable using
the mount options introduced with the i/o error patches.

- -Jeff

- --
Jeff Mahoney
SuSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCsGe2LPWxlyuTD7IRAhDjAJ0dSbQlWTrK4q91CDToT8TQjnyHggCfS+cm
WWwx8wdwGPvDdB54VE/9rgU=
=c2s6
-----END PGP SIGNATURE-----
