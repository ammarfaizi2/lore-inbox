Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933479AbWKSWae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933479AbWKSWae (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 17:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933493AbWKSWae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 17:30:34 -0500
Received: from cantor2.suse.de ([195.135.220.15]:54985 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S933479AbWKSWad (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 17:30:33 -0500
Message-ID: <4560DB6B.9020601@suse.com>
Date: Sun, 19 Nov 2006 17:32:11 -0500
From: Jeff Mahoney <jeffm@suse.com>
Organization: SUSE Labs, Novell, Inc
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Andi Kleen <ak@suse.de>,
       lkml <linux-kernel@vger.kernel.org>, reiserfs-dev@namesys.com,
       sam@ravnborg.org
Subject: Re: reiserfs NET=n build error
References: <20061118202206.01bdc0e0.randy.dunlap@oracle.com> <200611190650.49282.ak@suse.de> <45608FC2.5040406@suse.com> <200611191959.55969.ak@suse.de> <4560AAC1.3000800@oracle.com> <20061119205711.GE3078@ftp.linux.org.uk>
In-Reply-To: <20061119205711.GE3078@ftp.linux.org.uk>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Al Viro wrote:
> On Sun, Nov 19, 2006 at 11:04:33AM -0800, Randy Dunlap wrote:
>> Andi Kleen wrote:
>>>>> I would copy a relatively simple C implementation, like 
>>>>> arch/h8300/lib/checksum.c
>>>> As long as the h8300 version has the same output as the x86 version.
>>> The trouble is that the different architecture have different output 
>>> for csum_partial. So you already got a bug when someone wants to move
>>> file systems.
>>>
>>> -Andi
>> That argues for having only one version of it (in a lib.; my preference)
>> -or- Every module having its own local copy/version of it.  :(
> 
> Wrong.  csum_partial() result is defined modulo 0xffff and it's basically
> "whatever's convenient as intermediate for this architecture".
> 
> reiserfs use of it is just plain broken.  net/* is fine, since all
> final uses are via csum_fold() or equivalents.
> 
> Note that reiserfs use is broken in another way: it takes fixed-endian value
> and feeds it to cpu_to_le32().  IOW, even if everything had literally the
> same csum_partial(), the value it shits on disk would be endian-dependent.

Oh great. Even better. :(

- -Jeff

- --
Jeff Mahoney
SUSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFYNtqLPWxlyuTD7IRAux8AKCbxW4zX5Q7y8LfPT0FY/W4A8v0PQCggV11
EbMvTGkAb5WXa0f7EgUz5Qk=
=Zm0q
-----END PGP SIGNATURE-----
