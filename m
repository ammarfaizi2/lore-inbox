Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbUD3BU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbUD3BU6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 21:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264991AbUD3BU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 21:20:58 -0400
Received: from rootsrv.net ([217.160.131.12]:5248 "HELO rootsrv.net")
	by vger.kernel.org with SMTP id S261706AbUD3BU5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 21:20:57 -0400
Message-ID: <4091AA0F.8050700@pop2wap.net>
Date: Fri, 30 Apr 2004 03:21:19 +0200
From: Christof <mail@pop2wap.net>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: some ext2-understanding problems (page cache etc.)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm not a kernel guru, but my task is to extract some ext2-code from the 
kernel into user space for a scientific project/experiment. I've 
"ported" a lot of code by now but now I am stuck.
I wanted to bypass the page cache and disk buffer and have all writes 
and reads directly in memory. I don't want to get into details, but 
imagine I have an image of an ext2-filesystem in memory and want to 
access it in user space but with the same interface as it would be in 
the kernel.

My problem at the moment is the function ext2_make_empty.
It is called in ext2_mkdir after an inode has been created.
It looks like the ext2_make_empty creates the basic dir entries like "." 
and ".." but I cannot find the block number where this information is 
written on disk. There seems to be a function get_block but i'm not sure 
what it exactly does. Could you help me to understand how and when 
block-numbers are set?

I see 2 possibilities:
  1. The block numbers are set at the moment files/dirs are created,
     changed etc.
  2. First, pages are requested. When they need to be written, a block
     number is obtained (if needed).

Is any of these ideas true?
Once again: I need to replace all writes and reads to and from pages and 
buffers by writes and reads to block numbers on the given device.

Thanks in advance!

-- 
Q: What's little, yellow and very very dangerous?
A: A canary with the super-user password.

