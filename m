Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933142AbWKSUKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933142AbWKSUKs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 15:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933139AbWKSUKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 15:10:48 -0500
Received: from mx1.suse.de ([195.135.220.2]:37012 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S933142AbWKSUKr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 15:10:47 -0500
Message-ID: <4560BAAF.2030202@suse.com>
Date: Sun, 19 Nov 2006 15:12:31 -0500
From: Jeff Mahoney <jeffm@suse.com>
Organization: SUSE Labs, Novell, Inc
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: Randy Dunlap <randy.dunlap@oracle.com>,
       lkml <linux-kernel@vger.kernel.org>, reiserfs-dev@namesys.com,
       sam@ravnborg.org, Al Viro <viro@ftp.linux.org.uk>
Subject: Re: reiserfs NET=n build error
References: <20061118202206.01bdc0e0.randy.dunlap@oracle.com> <200611190650.49282.ak@suse.de> <45608FC2.5040406@suse.com> <200611191959.55969.ak@suse.de>
In-Reply-To: <200611191959.55969.ak@suse.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andi Kleen wrote:
>>> I would copy a relatively simple C implementation, like arch/h8300/lib/checksum.c
>> As long as the h8300 version has the same output as the x86 version.
> 
> The trouble is that the different architecture have different output 
> for csum_partial. So you already got a bug when someone wants to move
> file systems.

Yeah, Al Viro noticed that about reiserfs earlier this month. The
problem is that there's really no good fix for it. I was under the
impression that csum_partial would be arch-independent and was in asm/
for performance reasons. The comment in asm-x86_64 indicates that's not
the case, but the comment in asm-i386 still doesn't. I developed the
code on i386. Moving forward we can define an arch-independent hash
function for that and accept the old arch-dependent checksums, but
there's still the issue of old kernels not understanding it on any arch.
Kind of a nice shot to the foot considering the work I put into making
reiserfs endian safe in the 2.4 days.

I'm hoping there's a better solution to be found than creating a
checksum verifier that checks all known versions. :(


- -Jeff

- --
Jeff Mahoney
SUSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFYLqvLPWxlyuTD7IRAj7RAKCkOHL9EgTrmHSo97xzG5tBxWgzCACgiBcW
uzd/oSwXDHECHPEcIL58xoo=
=udEd
-----END PGP SIGNATURE-----
