Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261687AbVFPPVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbVFPPVb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 11:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbVFPPVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 11:21:31 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:18979 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S261685AbVFPPVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 11:21:22 -0400
Message-ID: <42B198E7.80100@suse.com>
Date: Thu, 16 Jun 2005 11:21:11 -0400
From: Jeff Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Chinner <dgc@sgi.com>
Cc: Hans Reiser <reiser@namesys.com>, fs <fs@ercist.iscas.ac.cn>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
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
       linux-xfs@oss.sgi.com,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: [RFD] FS behavior (I/O failure) in kernel summit
References: <1118692436.2512.157.camel@CoolQ> <42ADC99D.5000801@namesys.com> <42ADFFD5.1090905@suse.com> <42AE1EE4.5090508@namesys.com> <42B067B6.9030009@suse.com> <20050616121822.E125706@melbourne.sgi.com>
In-Reply-To: <20050616121822.E125706@melbourne.sgi.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dave Chinner wrote:
>>Well it seems to me that all the XFS code does is check to see if the FS
>>is in a shutdown state really early in the call path.
> 
> FYI, the up front checks in XFS are simply to stop new I/O from starting
> if we're already in the shutdown state.
> 
> However, there's more than that in XFS - there's checks all through
> it's I/O paths so that I/Os and transactions in flight at (or
> started after) the time of the shutdown can be aborted before doing
> further damage to a potentially corrupted filesystem. This part
> cannot be done generically as it is intimately tied to the
> filesystem.
> 
> It is also worth noting that XFS won't shutdown a filesystem on just
> any I/O error. Shutdowns due to I/O errors only occur when the
> failure has the potential to leave the filesystem in an inconsistent
> state.  Hence any given operation can return different errors
> depending on where the I/O error occurred in XFS and what effect
> that I/O error has on the consistency of the filesystem.....

Sorry, I should have clarified. I was only refering to the handling of
operations that aren't already in flight.

Currently, ReiserFS (and ext3) will set the filesystem read-only on
error, which ends up returning -EROFS in situations where that error
code is correct, but not entirely appropriate.

- -Jeff

- --
Jeff Mahoney
SuSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCsZjnLPWxlyuTD7IRAuk5AKCplbYsl3YFml9/M1GRtuvBz21jvwCgoWKn
Mpl0khchSkQ1RwI/mkZ8buY=
=DxvJ
-----END PGP SIGNATURE-----
