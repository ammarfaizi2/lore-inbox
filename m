Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262482AbRENUNM>; Mon, 14 May 2001 16:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262470AbRENUNC>; Mon, 14 May 2001 16:13:02 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:30218 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S262465AbRENUM5>;
	Mon, 14 May 2001 16:12:57 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200105142012.f4EKCeK44513@saturn.cs.uml.edu>
Subject: Re: How VFS interacts with a file driver
To: phillips@bonn-fries.net (Daniel Phillips)
Date: Mon, 14 May 2001 16:12:40 -0400 (EDT)
Cc: blessonpaul@usa.net (Blesson Paul), linux-kernel@vger.kernel.org
In-Reply-To: <01051415551805.02742@starship> from "Daniel Phillips" at May 14, 2001 03:55:18 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips writes:
> On Monday 14 May 2001 07:29, Blesson Paul wrote:

>>                I am trying to implement a distributed file system.

Me too!  :-)

>> For that I write a file driver. I want to know the following things
>>
>> 1 . If I am writing a new file system, is it necessary to modify the
>> existing structs including inode struct.

Nope. There is a generic pointer you can use. You just need to
figure out when to free it, assuming you don't want to leak
lots of memory. Student projects can leak -- lucky you!

>> 2 . If it is not needed, will a simple registration of the file
>> system is needed to mount the file system
>>                 More over I am new to this area. I am doing as my
>> graduate project. I need someones help to crack the working of VFS
>> Thanks in advance
>
> 1. In .config, change CONFIG_EXT2_FS to 'm'
> 2. change "ext2" to "newfs" at DECLARE_FSTYPE_DEV in super.c
> 3. make modules SUBDIRS=fs/ext2
> 4. insmod fs/ext2/ext2.o
> 
> Poof!  New filesystem.  (cat /proc/filesystems) Don't forget to change 
> ext2 in .config back to "y" before you build your next kernel.  You'll 
> need to study the kernel *hard* before you can expect to have half a 
> chance of having your filesystem work properly.

Gotta love d_delete the function and d_delete the function pointer
in a struct. Discovery was cause for inventing new curses.

Along the way I stumble accross a "retval" that is only set once
and a "if(de &&" of "if(!de ||" (I forget) that is redundant.
Maybe in the proc or tmpfs code, just in case someone cares enough.
