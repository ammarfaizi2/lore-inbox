Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266650AbUJIJyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266650AbUJIJyg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 05:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266663AbUJIJyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 05:54:35 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:49348 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S266650AbUJIJyd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 05:54:33 -0400
Message-ID: <4167B557.8080202@free.fr>
Date: Sat, 09 Oct 2004 11:54:31 +0200
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, wli@holomorphy.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Inconsistancies in /proc (status vs statm) leading to wrong documentation
 (proc.txt)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm currently trying use mlockall for a soft RT application and was 
concerned by the memory usage of my (big) RT process. So I stated to 
look at /proc/<PID>/status and /proc/<PID>/statm and then to the 
documentation of statm (Documentation/filesystem/proc.txt) because 
unexplained values are rather useless.

The doc currently says :
-------------------------------------------------------------------------
  Field    Content
  size     total program size (pages)		(same as VmSize in status)
  resident size of memory portions (pages)	(same as VmRSS in status)
  shared   number of pages that are shared	(i.e. backed by a file)
  trs      number of pages that are 'code'	(not including libs; broken,
							includes data segment)
  lrs      number of pages of library		(always 0 on 2.6)
  drs      number of pages of data/stack		(including libs; broken,
							includes library text)
  dt       number of dirty pages			(always 0 on 2.6)
---------------------------------------------------------------------------

But when I did cat /proc/<pid>/status and /proc/<pid>/statm  the result 
where rather different (and not only due to size units). Looking at 
/usr/src/linux/fs/proc/task_mmu.c It is not surpising.

May I suggest :
	- To use consistent memory size units between status and statm,
	- To have VmSize and statm return the same global memory size,
	- To eventually display mm->reserved_vm in status and put a word about 
it in the doc,

Of course I can send a patch but I would rather let you decide the way 
you want to go...


Thanks,

-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette@free.fr



