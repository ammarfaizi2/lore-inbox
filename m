Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291871AbSBARWF>; Fri, 1 Feb 2002 12:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291870AbSBARVz>; Fri, 1 Feb 2002 12:21:55 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:14512 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S291868AbSBARVn>;
	Fri, 1 Feb 2002 12:21:43 -0500
Message-ID: <3C5ACE88.1050002@us.ibm.com>
Date: Fri, 01 Feb 2002 09:21:12 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020126
X-Accept-Language: en-us
MIME-Version: 1.0
To: Christoph Hellwig <hch@caldera.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] kthread abstraction
In-Reply-To: <20020201163818.A32551@caldera.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I notice that the BKL is held for a short time, while daemonizing:
+ 
lock_kernel();
+ 
daemonize();
+ 
reparent_to_init();
+ 
strcpy(current->comm, kth->name);
+ 
unlock_kernel();

Have you noticed that a lot of kernel daemons hold the BKL whenever 
they're active?  Things like nfsd are always holding the BKL, only 
releasing it on schedule(), and exit.  Is there any compelling reason to 
hold the BKL during times other than during the daemonize() process?

-- 
Dave Hansen
haveblue@us.ibm.com

