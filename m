Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932443AbVLNNCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbVLNNCy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 08:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbVLNNCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 08:02:54 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:8651 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932443AbVLNNCx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 08:02:53 -0500
Message-ID: <43A017EF.2000507@us.ibm.com>
Date: Wed, 14 Dec 2005 08:02:39 -0500
From: JANAK DESAI <janak@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: viro@ftp.linux.org.uk, chrisw@osdl.org, dwmw2@infradead.org,
       jamie@shareable.org, serue@us.ibm.com, mingo@elte.hu,
       linuxram@us.ibm.com, jmorris@namei.org, sds@tycho.nsa.gov,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 0/9] unshare system call : updated patch series
References: <1134513864.11972.156.camel@hobbs.atlanta.ibm.com> <20051213161931.66978418.akpm@osdl.org>
In-Reply-To: <20051213161931.66978418.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>JANAK DESAI <janak@us.ibm.com> wrote:
>  
>
>>The following patches represent the updated version of the proposed
>>new system call unshare. Patches that registered system call for
>>different architectures were not updated but are being resent in
>>the series along with the updated patches.
>>
>>Changes since the first submission of this patch series on 12/12/05:
>>	- Patches 1, 6, 7, 8, and 9 are updated to incorporate
>>	  feedback from Al Viro. Changes are described in the change
>>	  log for each of the patches (12/13/05)
>>
>>unshare allows a process to disassociate part of the process context (vm
>>namespace, files and fs) that was being shared with a parent.  Unshare 
>>is needed to implement polyinstantiated directories (such as per-user 
>>and/or per-security context /tmp directory) using the kernel's per-process
>>namespace mechanism. For a more detailed description of the justification
>>and approach, please refer to lkml threads from 8/8/05, 10/13/05 & 12/08/05.
>>                                                                                
>>Unshare system call, along with shared tree patches, have been in use
>>in our department for over month and half. We have been using them to
>>maintain per-user and per-context /tmp directory. The latest port to
>>2.6.15-rc5-mm2 has been tested on a uni-processor i386 machine.
>>    
>>
>
>I wouldn't view this as an adequate changelog for a new feature, really. 
>Please prepare a new one which describes what the feature does, how it does
>it and, especially, why we would want to add it to the kernel.
>
>It adds 1.6k to my allnoconfig image which I guess can be lived with, but
>we need a *good* understanding of what we're getting for that cost, and
>apart from sending the reader onto an ill-defied lkml fishing expedition,
>you haven't provided that.
>
>Another downside which we need to weigh when evaluating this contribution
>is the security risk.  You've added code which very, very few people will
>use in real-life.  If it has holes or races they just won't be found by our
>normal testing processes.  Chances are the first time we'll hear about them
>is when some smarty has gone explicitly looking for exploits.
>
>Please demonstrate how each unsharing (fs, ns, sig, mm, fd) is correctly
>locked and refcounted against concurrent users.  I've only checked mm
>against access_process_vm() and it looks OK.
>
>Thanks.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>
Thanks. Yes, I should have done a better job of describing this new 
feature. I remember
finding description of shared trees very useful and meant to emulate it 
for unshare, but
got caught up in code fixes and didn't update the documentation. I will 
do so soon and
send it out so you have a more coherent information from which to make a 
decision.

-Janak
