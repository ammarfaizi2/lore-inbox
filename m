Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262817AbTKIVaY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 16:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262819AbTKIVaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 16:30:24 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:7629 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262817AbTKIVaT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 16:30:19 -0500
Message-ID: <3FAEB1DC.7040608@watson.ibm.com>
Date: Sun, 09 Nov 2003 16:30:04 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5b) Gecko/20030829 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       ckrm-tech@lists.sourceforge.net
Subject: Re: [PATCH] cfq + io priorities
References: <20031108124758.GQ14728@suse.de>
In-Reply-To: <20031108124758.GQ14728@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Jens Axboe wrote:

>I've implemented IO nice levels in the CFQ io scheduler. 
>
Thanks for putting this in ! It'll be very useful to have some control 
over I/O priorities.


>It works as
>follows.
>
>A process has an assigned io nice level, anywhere from 0 to 20. Both of
>these end values are "special" - 0 means the process is only allowed to
>do io if the disk is idle, and 20 means the process io is considered
>realtime. Realtime IO always gets first access to the disk. 
>

>Values from 1 to 19 assign 5-95% of disk bandwidth to that process. Any io class is
>allowed to use all of disk bandwidth in absence of higher priority io.
>  
>
Currently, cfq is doing bandwidth allocation in terms of  number of 
requests, not bytes. Hence priority inversion can happen if lower 
priority levels submit larger requests on an average. Any plans to take 
request sizes into consideration  in future ? 

Of course, request sizes alone don't determine actual disk bandwidth 
consumed  since their seek position also matters.

>About the patch: stuff like this really needs some resource management
>abstraction like CKRM. Right now we just look at the tgid of the
>process. 
>
Now thats music to our ears :-)  Though you've complicated matters by 
calling the priority level a "class" ! Please consider renaming
class  to something else  (say priolevel ).

Thanks for separating the hashvalue as a macro. It should make it even 
easier to convert cfq to use a  CKRM I/O classes ' priority
rather than the submitting task's ioprio value.

-- Shailabh

