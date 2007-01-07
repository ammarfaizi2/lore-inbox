Return-Path: <linux-kernel-owner+w=401wt.eu-S932446AbXAGJHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbXAGJHn (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 04:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbXAGJHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 04:07:43 -0500
Received: from web55614.mail.re4.yahoo.com ([206.190.58.238]:45690 "HELO
	web55614.mail.re4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932446AbXAGJHm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 04:07:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=a3/XIIlTHGaxIeOMbGpULn+s80Zb5TOXFbZXRc2iLN6qqu0CvdRegNTRWKP2Z1aeomLHxrnNTzjPDMeSw6EJEfw/E+Nba6MaLLHEq6FZCwJkTCdSbnlUzwS06+I8e+0SzswZRMThmO2uaevteueluP0CPVO3FJ5JYrBgwoIWQZY=;
X-YMail-OSG: OcCXcHwVM1kgpEwq9ByGGFeM6TMiVsapsexBsm6S5QGvqe6exScY6m8Nrp8AzcTNSZC7FdAqJ7wrbKk33GPMpKPGuQBNBVxma4LcANk9A3tuiLC50FY_j9TuYKz82xgWBrxkgUQOKKRFucYqDE1Frz.I
Date: Sun, 7 Jan 2007 01:07:41 -0800 (PST)
From: Amit Choudhary <amit2030@yahoo.com>
Subject: Re: [DISCUSS] Making system calls more portable.
To: Rene Herman <rene.herman@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <45A0AE5C.6010801@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <647618.57006.qm@web55614.mail.re4.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Rene Herman <rene.herman@gmail.com> wrote:
>
>If we're limited to Linux kernels, this seems to not be the case. Great care is taken in keeping
>this userspace ABI stable -- new system calls are given new numbers. Old system calls may
>disappear (after a long grace period) but even then I don't believe the number is ever recycled.
>
> If your discussion is not limited to Linux kernels, then sure, but being 
> portable at that (sub-libc) level is asking too much.
> 

I will come to the main issue later but I just wanted to point out that we maintain information at
two separate places - mapping between the name and the number in user space and kernel space.
Shouldn't this duplication be removed.

Now, let's say a vendor has linux_kernel_version_1 that has 300 system calls. The vendor needs to
give some extra functionality to its customers and the way chosen is to implement new system call.
 The new system call number is 301. The customer gets this custom kernel and uses number 301.
Next, he downloads another kernel (newer linux kernel version) on his system that has already
implemented the system call numbered 301. The customer now runs his program. Even if he compiles
it again he has the old header files, so that does not make a difference.

Now his program uses number 301 that refers to some other system call and so, we can see system
crash, or some very wrong behaviour. Making system calls more portable will ensure that atleast
the program gets an indication that something is wrong (error returned from the kernel that this
system call name is not matched). Or, if the vendor is actually successful in pushing its system
call to the mainline kernel, no one needs to worry about it. Everything will run happily.

However, people may say that, implementing custom system calls is not advocated by linux. And I
think it is not advocated precisely because of this reason that they are not portable.

Regards,
Amit



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
