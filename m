Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293314AbSDEP6e>; Fri, 5 Apr 2002 10:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313034AbSDEP6Y>; Fri, 5 Apr 2002 10:58:24 -0500
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:51139 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S293314AbSDEP6R>;
	Fri, 5 Apr 2002 10:58:17 -0500
Message-ID: <3CADC998.9060501@acm.org>
Date: Fri, 05 Apr 2002 09:58:16 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: How to open files a process has mmapped
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to solve a problem where a customer needs to be able to open 
a file a process has mmap-ed.  The trouble is that the file might be 
deleted (this is actually likely in this scenario) so I can't just open 
the file listed in /proc/<pid>/maps.

I have looked some at this, and I haven't come up with a good solution 
for this.  I have come up with the following solutions:

Open /proc/<pid>/mem and get the memory directly.  This has two problems:

    * You have to ptrace() the process to do this.  Actually, that seems
      a little silly.  Why do you have to ptrace() the process to do this?
    * The whole file might not be mapped, thus the section of the file
      that is interesting might not be in memory.

Another solution I thought of was to provide a /proc/<pid>/mapped_files 
directory that works like the /proc/<pid>/fd directory.  Unfortunately, 
it looks very difficult to implement this because of the need to provide 
consistent inodes.  For fds, you have an easy way to generate inodes 
with the fd number.  For mmap-ed memory, you don't have a relatively 
small number to do this with.

The last solution I could think of was to provide a way to open a file 
with using the major/minor/inode (since these are listed for the mapped 
files in the /proc/<pid>/maps file).  This is kind of ugly, but it's 
probably the best one I've thought of.

Any more ideas?  Maybe there's an easy way to do this that I haven't found.

-Corey

