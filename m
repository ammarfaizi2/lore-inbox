Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265654AbTF2Ngo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 09:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265658AbTF2Ngo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 09:36:44 -0400
Received: from oak.sktc.net ([64.71.97.14]:63405 "EHLO oak.sktc.net")
	by vger.kernel.org with ESMTP id S265654AbTF2Ngn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 09:36:43 -0400
Message-ID: <3EFEEEC3.30505@sktc.net>
Date: Sun, 29 Jun 2003 08:50:59 -0500
From: "David D. Hagood" <wowbagger@sktc.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: File System conversion -- ideas
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk> <20030629132807.GA25170@mail.jlokier.co.uk>
In-Reply-To: <20030629132807.GA25170@mail.jlokier.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a place where logical volume management can help.

For example, suppose you have a 60G disk, 55G of data, in ext2, and you 
wish to convert to ReiserFS.

Step 1: Shrink the volume to 55G. This requires a "shrink disk" utility 
for the source file system (which exists for the major file systems in 
use today).
Step 2: Create an LVM block in the remaining 5G.
Step 3: Create a ReiserFS in the LVM block.
Step 4: Move 5G of data from the ext2 system to the ReiserFS block.
Step 5: Shrink the ext2 volume by another 5G
Step 6: Convert that 5G into an LVM block
Step 7: Add that block to the ReiserFS volume group.
Step 8: Grow the ReiserFS.
Step 9: Repeat 4-8 as needed.


This is why I'd really love to see LVM|EVM become standard, not just in 
the kernel but in the distributions - if every distro by default made 
all Linux volumes in LVM, then migrating data to bigger drives/adding 
more space/converting file systems would be so much easier.

