Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751691AbWIMIMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbWIMIMu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 04:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751695AbWIMIMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 04:12:50 -0400
Received: from smtpout.mac.com ([17.250.248.176]:62957 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751691AbWIMIMt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 04:12:49 -0400
In-Reply-To: <ee8a8j$gf7$1@taverner.cs.berkeley.edu>
References: <20060907182304.GA10686@danisch.de> <1BB4231A-7D69-4A77-A050-1C633BDFA545@mac.com> <ee88af$fgo$1@taverner.cs.berkeley.edu> <B7C6636B-03E9-4D4C-AC0E-2898181F419B@mac.com> <ee8a8j$gf7$1@taverner.cs.berkeley.edu>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <45F1F6C1-FB19-4E6D-BEFE-B8C541D7A2F3@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: R: Linux kernel source archive vulnerable
Date: Wed, 13 Sep 2006 04:12:44 -0400
To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAQAAA+k=
X-Language-Identified: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 13, 2006, at 02:59:31, David Wagner wrote:
> Kyle Moffett  wrote:
>> No, git-tar-tree is storing the desired permissions (0666 and  
>> 0777)   in the tar archive.  This is not a bug, those are actually  
>> the permissions we want in the tar archive.
>
> Those may be the permissions *you* want, but they're not the  
> permissions I suspect many users would prefer.

How do you decide what users would prefer?  I seem to recall the UNIX  
way to do that is umask which works perfectly with tar as a normal  
user and kernel tarballs.  I fail to see how you get world-writable  
files from a kernel tree unless your umask is 0000 or you're using  
tar in backup-mode; which is senseless on a tar file not built to  
restore as a backup.  For that matter, how do you determine which  
user it should extract as?  UID 0?  Linus' UID?  My UID?  What  
happens when I extract files on my SELinux system under the sysadm  
role as UID 500?  Should they get UID 0 because I have chown  
permissions and the author of the tar archive was tarring as root?

Relying on GNU tar and/or the permissions embedded in a tar file you  
downloaded from the internet to enforce your security policy is going  
to lead to a world of pain.

Besides, even Linus said:
> I would suggest that people who compile new kernels should:
> [...]
> - compile the kernel in their own home directory, as their very own  
> selves.  No need to be root to compile the kernel.  You need to be  
> root to _install_ the kernel, but that's different.


> Take a look at any open-source project that ships tar archives of  
> their source code.  Do they ship tarballs of their source code  
> where all the files have 0666 permissions?

Actually, if you start browsing random software tarballs you'll find  
that 1 in 5 or so has world-write permissions on at _minimum_ the  
root directory, more often the whole source tree.

I ran:

> for i in *.tar.gz; do tar -tvzf $i | head -n 1; done | less

on my directory of source tarballs and just going alphabetically down  
the list here's a list I found with drwxrwxrwx for the root directory  
of the archive:

OpenSP-1.5.1.tar.gz
bison-2.1.tar.gz
cyrus-sasl-2.1.21.tar.gz
findutils-4.2.20.tar.gz
gawk-3.1.4.tar.gz
gd-2.0.33.tar.gz
glib-1.2.10.tar.gz
gmp-4.2.1.tar.gz
guile-1.4.tar.gz
gzip-1.2.4a.tar.gz
libtool-1.5.22.tar.gz
links-0.99.tar.gz
mpfr-2.2.0.tar.gz
openMotif-2.2.3.tar.gz

If this is really a "security issue" as you claim and not an admin- 
caused PEBKAC problem then a lot more software than the kernel is at  
risk.  At least with the kernel we can expect people to have some  
idea what they're doing, with some of the software above there are  
README files that say "BEGINNER TUTORIAL" and go over the basics of  
configure scripts.

So is this really about security or about _you_ being too lazy to  
pass the appropriate option to tar when unpacking a software tarball  
as root?

Cheers,
Kyle Moffett
