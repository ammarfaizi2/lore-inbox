Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263625AbTKLQGV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 11:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263661AbTKLQGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 11:06:20 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:51966 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S263625AbTKLQGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 11:06:18 -0500
Message-ID: <3FB25A76.1020701@nortelnetworks.com>
Date: Wed, 12 Nov 2003 11:06:14 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: proper way to use memory barriers in userspace?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've got a number of processes on an SMP box that communicate via shared 
memory.  I want to avoid locking, so I am considering using flags and 
memory barriers.

However, I've run into a snag--the barriers are buried within __KERNEL 
ifdefs.  Is the proper way to handle this just to copy/paste into userspace?

Also, I wanted to double-check that my barrier usage was correct.  The 
data consists of a flag indicating whether a scan was done, and the 
results of the scan.  The main  may check the flag at any time, so I 
want to make sure that there is no way that it can see the flag as set 
but have inconsistant data in the results field.  My plan was to do the 
following:


main process:
clear flag
mb
kick other process
wait (may be kicked by others here too)
for all other processes:
	if flag set
		check data


other process:
wait to be kicked
do scan
update results
wmb
set flag
mb
kick main


Is this the proper way to do it?

Thanks,

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

