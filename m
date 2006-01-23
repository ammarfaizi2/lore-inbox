Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932456AbWAWQs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbWAWQs0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 11:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbWAWQsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 11:48:25 -0500
Received: from smtpout.mac.com ([17.250.248.85]:47095 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932456AbWAWQsZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 11:48:25 -0500
In-Reply-To: <69304d110601230552n4c7656cal9c6901e180e82504@mail.gmail.com>
References: <43D3295E.8040702@comcast.net> <20060122093144.GA7127@thunk.org> <43D3D4DF.2000503@comcast.net> <20060122210238.GA28980@thunk.org> <4D75B95E-2595-4B60-91B3-28AD469C3D39@mac.com> <20060123072447.GA8785@thunk.org> <536E71BF-44FF-430C-8C19-F06526F0C78D@mac.com> <69304d110601230552n4c7656cal9c6901e180e82504@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CEED5F58-EF3D-44D9-9C54-FE1720640E11@mac.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>,
       John Richard Moser <nigelenki@comcast.net>,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Linux VFS architecture questions
Date: Mon, 23 Jan 2006 11:48:21 -0500
To: Antonio Vargas <windenntw@gmail.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 23, 2006, at 08:52:51, Antonio Vargas wrote:
> On 1/23/06, Kyle Moffett <mrmacman_g4@mac.com> wrote:
>> The way that I'm considering implementing this is by intentionally  
>> fragmenting the allocation bitmap, catalog file, etc, such that  
>> each 1/8 or so of the disk contains its own allocation bitmap  
>> describing its contents, its own set of files or directories,  
>> etc.  The allocator would largely try to keep individual btree  
>> fragments cohesive, such that one of the 1/8th divisions of the  
>> disk would only have pertinent data for itself.  The idea would be  
>> that when trying to look up an allocation block, in the common  
>> case you need only parse a much smaller subsection of the disk  
>> structures.
>
> this sounds exactly the same as ext2/ext3 allocation groups :)

Great!  I'm trying to learn about filesystem design and  
implementation, which is why I started writing my own hfsplus  
filesystem (otherwise I would have just used the in-kernel one).  Do  
you have any recommended reading (either online or otherwise) for  
someone trying to understand the kernel's VFS and blockdev  
interfaces?  I _think_ I understand the basics of buffer_head,  
super_block, and have some idea of how to use aops, but it's tough  
going trying to find out what functions to call to manage cached disk  
blocks, or under what conditions the various VFS functions are  
called.  I'm trying to write up a "Linux Disk-Based Filesystem  
Developers Guide" based on what I learn, but it's remarkably sparse  
so far.

One big question I have:  HFS/HFS+ have an "extents overflow" btree  
that contains extents beyond the first 3 (for HFS) or 8 (for HFS+).   
I would like to speculatively cache parts of that btree when the  
files are accessed, but not if memory is short, and I would like to  
allow the filesystem to free up parts of the btree under the same  
circumstances.  I have a preliminary understanding of how to trigger  
the filesystem to read various blocks of metadata (using  
buffer_heads) or file data for programs (by returning a block number  
from the appropriate aops function), but how do I allocate data  
structures as "easily reclaimable" and indicate to the kernel that it  
can ask me to reclaim that memory?

Thanks for the help!

Cheers,
Kyle Moffett
