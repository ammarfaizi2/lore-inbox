Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262608AbVAKCPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262608AbVAKCPP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 21:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262659AbVAKCOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 21:14:35 -0500
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:5042 "EHLO
	brmea-mail-3.sun.com") by vger.kernel.org with ESMTP
	id S262648AbVAKCLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 21:11:24 -0500
Date: Mon, 10 Jan 2005 21:08:01 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [patch] Per-sb s_all_inodes list
In-reply-to: <20050111012311.GD2696@holomorphy.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>,
       viro@parcelfarce.linux.theplanet.co.uk
Message-id: <41E33501.1050506@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <41E2F15C.3010607@sun.com> <20050111012311.GD2696@holomorphy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

William Lee Irwin III wrote:
> On Mon, Jan 10, 2005 at 04:19:24PM -0500, Mike Waychison wrote:
> 
>>Releasing a super_block requires walking all inodes for the given
>>superblock and releasing them. Currently, inodes are found on one of
>>four lists:
> 
> [...]
> 
>>The second list, inode_unused can potentially be quite large.
>>Unfortunately, it cannot be made per-sb as it is the global LRU list
>>used for inode cache reduction under memory pressure.
>>When unmounting a single filesystem, profiling shows dramatic time spent
>>walking inode_unused.  This because very noticeble when one is
>>unmounting a decently sized tree of filesystems.
>>The proposed solution is to create a new list per-sb, that contains all
>>inodes allocated.  It is maintained under the inode_lock for the sake of
>>simplicity, but this may prove unneccesary, and may be better done with
>>another global or per-sb lock.
> 
> 
> I thought this was a good idea a number of months ago myself when I saw
> a patch for 2.4.x implementing this from Kirill Korotaev, so I ported
> that code to 2.6.x and it got merged in -mm then. That patch was merged
> into Linus' bk shortly after 2.6.10. Could you check Linus' bk to see
> if what made it there resolves the issue as well as your own?
> 

Excellent.  I eyeballed the patch on bkbits.net and it does exactly what
I posted.

Thanks,

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB4zUBdQs4kOxk3/MRAhaKAJwJDvFtnb57DkMpWuEB1C8ePZItFwCfSLrm
IKROVg53ElpF8V8PQRRB7vQ=
=AjvL
-----END PGP SIGNATURE-----
