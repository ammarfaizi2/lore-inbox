Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267353AbTBXS04>; Mon, 24 Feb 2003 13:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267481AbTBXSVv>; Mon, 24 Feb 2003 13:21:51 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:21963 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S267353AbTBXSMQ>;
	Mon, 24 Feb 2003 13:12:16 -0500
Message-ID: <3E5A6298.3030601@colorfullife.com>
Date: Mon, 24 Feb 2003 19:21:12 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Jacobowitz <dan@debian.org>
CC: fcorneli@elis.rug.ac.be, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ptrace PTRACE_READDATA/WRITEDATA, kernel 2.5.62
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2003 at 03:05:14PM +0100, fcorneli@elis.rug.ac.be wrote:

>+		ret = 0;
>+		res = ptrace_readdata(child, addr, (void *)addr2, data);
>+		if (res == data)
>+			break;
>  
>
You mention sparc - have you tested if that works on sparc?
ptrace_readdata assumes that addr2 is a pointer to kernel space, not 
user space. It works by chance on i386, but that's not acceptable for 
merging.
You must double buffer, check mem_read in fs/proc/base.c

Daniel wrote:

>Thirdly, I was going to do this, but I ended up making GDB use pread64
>on /dev/mem instead.  It works with no kernel modifications, and is
>just as fast.
>  
>
I assume you mean /proc/<pid>/mem. Performance is identical, same 
implementation.

--
    Manfred

