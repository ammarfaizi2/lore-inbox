Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264033AbTJ1QXy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 11:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264032AbTJ1QXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 11:23:54 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:6137 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S264031AbTJ1QXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 11:23:52 -0500
Message-ID: <3F9E97FB.5090603@nortelnetworks.com>
Date: Tue, 28 Oct 2003 11:23:23 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: root@chaos.analogic.com
Cc: Helge Hafting <helgehaf@aitel.hist.no>, Amir Hermelin <amir@montilio.com>,
       linux-kernel@vger.kernel.org
Subject: Re: how do file-mapped (mmapped) pages become dirty?
References: <006901c39d50$0b1313d0$2501a8c0@CARTMAN> <3F9E84A5.2060500@aitel.hist.no> <3F9E8AB3.4070305@nortelnetworks.com> <Pine.LNX.4.53.0310281042530.21561@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> On Tue, 28 Oct 2003, Chris Friesen wrote:

>>Note however that you need an msync() -- fsync() and fdatasync() do not
>>catch changes to mmapped pages.

> Sure they do. fsync() will sync the whole file, regardless of
> whether or not it's been mapped. msync()  allows you to sync
> only a  specific portion and control how that portion is
> handled with some flags.

According to Rik van Riel and HPA, fsync() does not check page tables 
for dirty bits.  This is confirmed by my testing, in which msync() takes 
significantly longer than fsync() for the same file (in a ramdisk). 
msync() on the 3 pages dirtied took 39 usec, while fsync() on the whole 
200KB file took 12 usec.

Also, some googling leads to to believe that if the file is mmapped and 
you close() it, it won't get synced.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

