Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316178AbSEKAWz>; Fri, 10 May 2002 20:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316179AbSEKAWy>; Fri, 10 May 2002 20:22:54 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:34820 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S316178AbSEKAWy>;
	Fri, 10 May 2002 20:22:54 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iget-locked [2/6] 
In-Reply-To: Your message of "Fri, 10 May 2002 15:57:03 -0400."
             <Pine.GSO.4.21.0205101554540.19226-100000@weyl.math.psu.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 11 May 2002 10:22:39 +1000
Message-ID: <2149.1021076559@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 May 2002 15:57:03 -0400 (EDT), 
Alexander Viro <viro@math.psu.edu> wrote:
>On Fri, 10 May 2002, Jan Harkes wrote:
>> Now we introduce iget_locked and iget5_locked. These are similar to
>> iget, but return a locked inode and read_inode has not been called. So
>> the FS has to call read_inode to initialize the inode and then unlock
>> it with unlock_new_inode().
>
>No problems, except for putting exports in inode.c.  ISTR Linus saying that
>additional files with exports seriously increase the build time...  Linus?

Build time is the least of your worries here.  All objects that export
symbols must have unique basenames, all the modversion crud goes in
include/linux/modules under the object's basename.  This is the main
reason that many subsystems have a subsystem_ksyms.c file, to get a
unique base name.

There are 34 files called inode in 2.4.18.  None currently export
symbols so adding EXPORT_SYMBOL to fs/inode.c is safe, until somebody
else decides they want their inode.c to export symbols.  You will not
notice until you build both systems with MODVERSIONS=y.

