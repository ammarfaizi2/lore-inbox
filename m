Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262252AbTFJDEo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 23:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262263AbTFJDEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 23:04:44 -0400
Received: from www.13thfloor.at ([212.16.59.250]:41892 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S262252AbTFJDEm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 23:04:42 -0400
Date: Tue, 10 Jun 2003 05:18:26 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: linux-kernel@vger.kernel.org
Subject: Virtual Contexts for Tasks (2.4.2x)
Message-ID: <20030610031826.GA2044@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I thought it would be interesting to abstract
the current task concept, by adding an additional
layer (in lack of imagination) called 'virtual'
between the physical machine and the actual tasks.
(think like N times /sbin/init on one machine ...)

Although this idea is not new at all, the current
implementations lack some (read several) features
and a lot of simplicity.

I made a 'proof of concept' implementation for the 
2.4.20/21-rc7 kernel, to have something to talk 
about, which does the following:

 - new struct_virtual introduced
 - initial struct_virtual (default at boot time)
 - init_task, child_reaper, nr_threads, nr_running,
   max_threads, last_pid, and total_forks are
   moved to the struct_virtual
 - extended scheduler to honor virtuals
 - related extern declarations removed
 - related macros adjusted accordingly
 
 - new syscall to create a virtual
 - new syscall to migrate a task to some virtual
 - firts virtual task (init) becomes child_reaper
 - automatic disposal of virtual if virtual
   init task dies/is killed (after waiting
   for children)

I guess the implementation is suboptimal, but I
needed something to verify the concept, so
please comment!

patches and example tool can be found at   
  http://www.13thfloor.at/VServer/Virtual/
  
best,
Herbert
  
PS: the virt-tool tries to implement the pivot_root
    method suggested by Linus (instead of chroot)
    but it failed to unmount the old hierarchy ...
    (guess because of open file descriptors)

