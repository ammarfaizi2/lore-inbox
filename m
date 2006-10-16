Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422767AbWJPTTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422767AbWJPTTQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 15:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422851AbWJPTTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 15:19:16 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:40586 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1422850AbWJPTTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 15:19:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:subject:from:content-type:mime-version:content-transfer-encoding:message-id:user-agent;
        b=cQh8Meefg9b+IeO2IruvdOLH0FNsYlNXGdCCA8lkEak4PyZD2pC1wyHE6CRimpr1V9RuXt7baJqkwDDs6LUpPMSKlu3tUr9DCfGyB/VfAvWiEl0cDhZ4e71h2t45rQOtvU6E6XDmgxtUDANxgXx6v7Y8bocy0XPvebhcJRbxZgs=
Date: Mon, 16 Oct 2006 14:19:03 -0500
To: linux-kernel@vger.kernel.org
Subject: copy_from_user / copy_to_user with no swap space
From: mfbaustx <mfbaustx@gmail.com>
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-ID: <op.thi3x1mvnwjy9v@titan>
User-Agent: Opera Mail/9.01 (Win32)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been trying to find or derive a definitive answer to this question  
for a while now but can't quite get over the hump.

I understand when/why copy_<to|from>_user (and siblings) are required  
(address validation, guaranteeing a process is paged in, etc...).  The  
question is: if you have no swap space (or virtual memory or whatever),  
can there ever be a case in which any valid pointer to a buffer in  
user-space would be incorrect as a result of another process's PTE being  
present?  Put another way: can a process be partially paged?

My reasoning (which I obviously have no confidence else I wouldn't be  
asking this question) is as follows:

All processes share the same logical address space starting at 0 and  
(usually) ending at 3GB, right?  Text sections start low and build up,  
stacks start high and grow down.  Somewhere in there you get your heap and  
shared memory regions.  Since noting about a logical address can identify  
a specific process, then copy_to/from_user can do nothing to guaruntee  
that the CORRECT process is paged in.  True?  So you're absolutely  
obligated to DO the copy at the time the kernel is executing on behalf of  
that process.  Once your process/thread is context swapped, you've lost  
the [correct] information on the address mapping.

So, IF you MUST copy_from/to_user when in the context of the process, AND  
IF you have no virtual memory/swapping, THEN must it not be true that you  
can ALWAYS dereferences your user space pointers?


TIA!


