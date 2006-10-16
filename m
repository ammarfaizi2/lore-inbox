Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422873AbWJPTjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422873AbWJPTjq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 15:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422874AbWJPTjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 15:39:46 -0400
Received: from smtpout.mac.com ([17.250.248.177]:15587 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1422873AbWJPTjp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 15:39:45 -0400
In-Reply-To: <op.thi3x1mvnwjy9v@titan>
References: <op.thi3x1mvnwjy9v@titan>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B72905BB-6E8D-47FD-9A20-269B27136DB2@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: copy_from_user / copy_to_user with no swap space
Date: Mon, 16 Oct 2006 15:39:16 -0400
To: mfbaustx <mfbaustx@gmail.com>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 16, 2006, at 15:19:03, mfbaustx wrote:
> So you're absolutely obligated to DO the copy at the time the  
> kernel is executing on behalf of that process.  Once your process/ 
> thread is context swapped, you've lost the [correct] information on  
> the address mapping.

Yes, this is correct.

> So, IF you MUST copy_from/to_user when in the context of the  
> process, AND IF you have no virtual memory/swapping, THEN must it  
> not be true that you can ALWAYS dereferences your user space pointers?

I'm not sure I entirely understand what you're asking here; perhaps  
you could rephrase or explain what you're trying to do?  From what I  
can pick up from your description; you may be missing that program  
text pages and memory-mapped files may be "swapped-out" even  
*without* a swap device.  As an example, when I first start /bin/bash  
(ignoring readahead for the moment), very little of the binary and  
shared libraries are actually in memory (the rest is left on disk).   
When I use data or call a function that hasn't been loaded from disk  
yet, a major fault occurs, the kernel loads data from the bash  
executable file or a shared library, and then maps it into the  
process address space.

Cheers,
Kyle Moffett

