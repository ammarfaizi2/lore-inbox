Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbVBGTxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbVBGTxA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 14:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbVBGTwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 14:52:04 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:58271 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261293AbVBGTnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 14:43:08 -0500
Message-ID: <4207C4C7.8080704@comcast.net>
Date: Mon, 07 Feb 2005 14:43:03 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050111)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: =?ISO-8859-1?Q?Lorenzo_Hern=E1ndez_Garc=EDa-Hierro?= 
	<lorenzo@gnu.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Filesystem linking protections
References: <1107802626.3754.224.camel@localhost.localdomain> <20050207111235.Y24171@build.pdx.osdl.net>
In-Reply-To: <20050207111235.Y24171@build.pdx.osdl.net>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Chris Wright wrote:
> * Lorenzo Hernández García-Hierro (lorenzo@gnu.org) wrote:
> 
>>This patch adds two checks to do_follow_link() and sys_link(), for
>>prevent users to follow (untrusted) symlinks owned by other users in
>>world-writable +t directories (i.e. /tmp), unless the owner of the
>>symlink is the owner of the directory, users will also not be able to
>>hardlink to files they do not own.
>>
>>The direct advantage of this pretty simple patch is that /tmp races will
>>be prevented.
> 
> 
> The disadvantage is that it can break things and places policy in the
> kernel.
> 

It can break things, yes.  For example, programs which have and use two
separate FS UIDs at the same time, or which attempt to make hardlinks to
files they don't own without CAP_FOWNER or root (should this just be
CAP_FOWNER?  Is root now irrelavent?).

Hang on, when do any programs have 2 FS UIDs at the same time. . . .

I've yet to see this break anything on Ubuntu or Gentoo; Brad Spengler
claims this breaks nothing on Debian.  On the other hand, this could
potentially squash the second most prevalent security bug.

> thanks,
> -chris

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCB8S0hDd4aOud5P8RAvYSAJ9zcGArfbC6i5uM1JW4ZHdELriUzACeOH/q
5ndpSdjporfnFAMK1OrMASE=
=XjWB
-----END PGP SIGNATURE-----
