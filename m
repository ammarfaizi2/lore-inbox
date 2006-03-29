Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964838AbWC1Xdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbWC1Xdy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 18:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbWC1Xdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 18:33:54 -0500
Received: from master.soleranetworks.com ([67.137.28.188]:49072 "EHLO
	master.soleranetworks.com") by vger.kernel.org with ESMTP
	id S964838AbWC1Xdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 18:33:53 -0500
Message-ID: <4429D3E4.3060305@wolfmountaingroup.com>
Date: Tue, 28 Mar 2006 17:25:08 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: "Jeff V. Merkey" <jmerkey@soleranetworks.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: e2label suggestions
References: <4429AF42.1090101@soleranetworks.com> <20060328232927.GB32385@thunk.org>
In-Reply-To: <20060328232927.GB32385@thunk.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:

>On Tue, Mar 28, 2006 at 02:48:50PM -0700, Jeff V. Merkey wrote:
>  
>
>>e2label takes as parms:
>>
>>e2label <device name> <mount point>
>>    
>>
>
>Actually, it's label name, not "mount point".  Some
>people/distributions will use a label name of "/" for the root
>filesystem, but that is purely a convention.
>
>  
>
>>What's useless about this is the association of device name and file 
>>system label which is completely broken on SATA systems which do dynamic
>>assignment.  e2label was a great idea, but did not go far enough to 
>>abstract. 
>>    
>>
>
>It's not an association of device name and file system label.  It is
>an assignment of a filesystme label to a *filesystem*.  The label is
>actually stored in the ext3's superblock.
>
>  
>
>>The Initial mount sequence using:
>>
>>root=LABEL=/
>>
>>should be modified to ignore the device assignment and dunamically scan 
>>the drives for the root drive for initial bootup and DETECT
>>the device assignment rather then reverting to fixed device 
>>assignments.  As implemented it's pretty useless and is simply an aliasing
>>mechanism rather than solving the problem of the system being truly 
>>dynamic. 
>>    
>>
>
>You can do this, and on some distributions it does work that way; the
>initial root device is actually an initrd, and the initrd will search
>the drivers looking for the root drive.  The blkid library, or the
>blkid program, can be used provide that functionality (indeed the
>mount program, when passed the argument "LABEL=/" can be compiled to
>use the blkid library to do this searching).
>
>So it does (or at least can) work this way already, but it's all
>userspace stuff which is currently distro-specific.  Which brings up
>the question why you posted this on LKML....
>
>						- Ted
>  
>
Ted,

Thanks for clarifying. It does NOT work this way today, and the 
detection of and translation of
LABEL=/ is passed in the kernel, so its a kernel issue. e2label also 
originated here, and yes I know about where
its stored. I will modify the kernels we use to translate this into a 
dynamic device handle. What
the rest of the world does is its problem. I was making a suggestion. 
See subject = "suggestions".

Thanks for responding. This has been helpful.

Jeff

>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

