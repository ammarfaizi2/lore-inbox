Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265978AbUBJQur (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 11:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266002AbUBJQur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 11:50:47 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:24033 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S265978AbUBJQtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 11:49:20 -0500
Message-ID: <40290B8C.5000208@nortelnetworks.com>
Date: Tue, 10 Feb 2004 11:49:16 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: question on pivot_root and kernel threads
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've got an embedded system that we're trying to move from 2.4.18 to 
2.4.22 (which involves a userspace upgrade as well).  It netboots with 
an initrd, and then at startup converts it to a tmpfs, unmounts the 
original ramdisk, and frees the memory.

With 2.4.22 suddenly it started complaining about being unable to 
unmount the original ramdisk.  After some digging, it seems that the 
kernel threads (keventd, ksoftirqd_CPU0, kswapd, bdflush, kupdated, and 
mtdblockd) are starting up with stdin/stdout/stderr set to /dev/console 
in the original ramdisk.  When I do the pivot_root so that the original 
ramdisk is mounted at "/mnt", I end up with a bunch of references to 
"/mnt/dev/console", and I can't unmount "/mnt" since the refcount is 
nonzero.

At a guess, its related to this thread:

http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&selm=hpYn.1fz.21%40gated-at.bofh.it

Did this ever get resolved properly?


Thanks,

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
