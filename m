Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261801AbVAYEQC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbVAYEQC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 23:16:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbVAYEQC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 23:16:02 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:23758 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261801AbVAYEPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 23:15:49 -0500
Message-ID: <41F5C7FB.2020403@comcast.net>
Date: Mon, 24 Jan 2005 23:15:55 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: undefined references
References: <41F58D25.1000203@comcast.net> <200501250204.j0P24mFE014360@turing-police.cc.vt.edu>
In-Reply-To: <200501250204.j0P24mFE014360@turing-police.cc.vt.edu>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Valdis.Kletnieks@vt.edu wrote:
> On Mon, 24 Jan 2005 19:04:53 EST, John Richard Moser said:
> 
> 
>>fs/built-in.o(.text+0xe413): In function `link_path_walk':
>>: undefined reference to `gr_inode_follow_link'
>>fs/built-in.o(.text+0xe933): In function `link_path_walk':
>>: undefined reference to `gr_inode_follow_link'
>>fs/built-in.o(.text+0x10c28): In function `sys_link':
>>: undefined reference to `gr_inode_hardlink'
>>fs/built-in.o(.text+0x10c52): In function `sys_link':
>>: undefined reference to `gr_inode_handle_create'
>>make: *** [.tmp_vmlinux1] Error 1
>>
>>What would cause this kind of error?
> 
> 
> link_path_walk() still has a reference to gr_inode_follow_link (the code
> you probably want to move to an LSM exit), and sys_ling() still calls
> gr_inode_hardlink() and gr_inode_handle_create() - but the actual functions
> you're calling either don't exist anymore, or they didn't get compiled and linked
> in.  If those functions are supposed to exist, you need to get them into a .o.
> If those are (as I suspect) becoming LSM exit hooks, then you need to clean up
> the direct calls in link_path_walk() and sys_link().

I figured it out.

I had in the makefile

subdir-$(CONFIG_GRSECURITY) += grsecurity/

I had to use obj- instead.


This is just an academic thing-- I'm rewriting GrSecurity's invasive
code as a bunch of hooks, collapsing what I can down, and making a
stackable (easy) security framework from scratch (what the hell am I
doing?).  I'm not modifying LSM, though I did rip off the
security_initcall things (did I just create a new .text section in
vmlinuz?  o.o).

Thanks for your comments though.  I'll look to them if I have trouble in
the future.
- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB9cf7hDd4aOud5P8RAtfbAJ9eaHGZpl2DXoqSJBlPVgBnnI7ivACfdw3H
xQuH4N3DOwWgBtkKQWpDOhA=
=U7C8
-----END PGP SIGNATURE-----
