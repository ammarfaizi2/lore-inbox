Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbTDHQ03 (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 12:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbTDHQ03 (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 12:26:29 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:27548 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261321AbTDHQ02 (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 12:26:28 -0400
Message-ID: <3E92FAE6.8000300@nortelnetworks.com>
Date: Tue, 08 Apr 2003 12:37:58 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: msync() more expensive than fsync()?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have some code that runs on a ramdisk-based filesystem.  Through a special 
device it mmaps a section of memory that is persistant over reboots, to be used 
for logging.  In order to guarantee that the logs were flushed to the memory 
area, I  assume that I need to use some kind of sync operation.  This is where 
things get a bit odd.

I did some testing with relatively small messages, 50 bytes or so, with results 
as follows:


Without any explicit flushing it takes 8 usec to log a message.

If I msync() only the pages that were touched in writing (usually 3 pages) it 
takes 39 usecs to log a message.

If I fsync() the entire file (200KB) it takes 12 usec to log a message.

Why the additional cost for msync()?  I would have thought it would be faster 
since it is explicitely for mmapped memory areas.  As a side note, the 
difference is even more extreme if a file is used on a disk-backed filesystem.

The kernel was 2.4.18.

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

