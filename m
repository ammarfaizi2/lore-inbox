Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161841AbWI2RST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161841AbWI2RST (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 13:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161831AbWI2RST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 13:18:19 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:58840 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161841AbWI2RSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 13:18:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer;
        b=qhA0NjXt0iOcGoNncQ2ffsgSzsX0W5sxwMgpX2H3SKcLVZf9TrYjs9jsgZKp3AUEGB/A+NcpNhes/MK8mjsBtwgLqMVFoEWoefrRmYtevhUGmSWyJDWB/Oh7KQtR+Nj3rp2Eygca6rx53HOM9h1Zg49kSGQgdqe4KlDq0g0JtQA=
In-Reply-To: <Pine.LNX.4.61.0609291905550.27518@yvahk01.tjqt.qr>
References: <0635847A-C149-412C-92B1-A974230381F8@dts.local> <F2F2C98F-6AFB-4E19-BEE9-D32652E2F478@atheme.org> <EE7C757E-E2CE-4617-A1D4-3B8F5E3E8240@gmail.com> <Pine.LNX.4.61.0609291905550.27518@yvahk01.tjqt.qr>
Mime-Version: 1.0 (Apple Message framework v749)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CF74CE5D-42A1-4FF9-8C9B-682C5D6DEAE1@gmail.com>
Cc: linux-kernel@vger.kernel.org, William Pitcock <nenolod@atheme.org>
Content-Transfer-Encoding: 7bit
From: girish <girishvg@gmail.com>
Subject: Re: [PATCH] include children count, in Threads: field present in /proc/<pid>/status (take-1)
Date: Sat, 30 Sep 2006 02:18:12 +0900
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
X-Mailer: Apple Mail (2.749)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sep 30, 2006, at 2:06 AM, Jan Engelhardt wrote:

>>>>
>>>> -	buffer += sprintf(buffer, "Threads:\t%d\n", num_threads);
>>>> +	buffer += sprintf(buffer, "Threads:\t%d\n", num_threads +
>>>> num_children);
>>>
>>> Personally, I'd prefer the children count to be separate,  
>>> something like:
>>>
>>> buffer += sprintf(buffer, "Threads:\t%d (%d children, %d total)",
>>> num_threads, num_children, num_threads + num_children);
>>>
>>> That would be rather nice, indeed.
>
> And I would suggest three separate lines to keep it parseable!
>
>
> Jan Engelhardt
> -- 

How about this?

         buffer += sprintf(buffer, "Threads:\t%d", num_threads);
         if (num_children)
                 buffer += sprintf(buffer, " Children: %d Total: %d",  
num_children, num_threads + num_children);
         buffer += sprintf(buffer, "\n");

