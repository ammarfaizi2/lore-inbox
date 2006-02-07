Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750943AbWBGQp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbWBGQp6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 11:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbWBGQp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 11:45:58 -0500
Received: from thsmsgxrt12p.thalesgroup.com ([192.54.144.135]:17370 "EHLO
	thsmsgxrt12p.thalesgroup.com") by vger.kernel.org with ESMTP
	id S1750943AbWBGQp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 11:45:57 -0500
Message-ID: <43E8CEC3.2080502@fr.thalesgroup.com>
Date: Tue, 07 Feb 2006 17:45:55 +0100
From: "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>
Reply-To: pierre-olivier.gaillard@fr.thalesgroup.com
Organization: Thales Air Defence
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.3) Gecko/20040924
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Antonio Vargas <windenntw@gmail.com>
Cc: Helge Hafting <helge.hafting@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: Can on-demand loading of user-space executables be disabled ?
References: <43DDE697.5000007@fr.thalesgroup.com>	 <43DF2332.3070705@aitel.hist.no> <69304d110601310228k2e92fd05qbb25949b0d6e9196@mail.gmail.com>
In-Reply-To: <69304d110601310228k2e92fd05qbb25949b0d6e9196@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you everybody. Somebody gave me another solution that applies when you can 
recompile the executable and are willing to change the source code : call 
mlockall to lock the process' memory space in memory.

It might be useful to quote the man page :
        mlockall disables paging for all pages mapped into the address space of
        the calling process. This includes the pages  of  the  code,  data  and
        stack  segment,  as  well  as shared libraries, user space kernel data,
        shared memory and memory mapped files. All mapped pages are  guaranteed
        to  be  resident  in RAM when the mlockall system call returns success-
        fully and they are guaranteed to  stay  in  RAM  until  the  pages  are
        unlocked again by munlock or munlockall or until the process terminates
        or starts another program with exec.  Child processes  do  not  inherit
        page locks across a fork.

As you see, calling mlockall forces all the executable code to be loaded into 
RAM and stay there. This also protects the program from getting swapped out. And 
you can keep your swap for the other programs.

   thanks again,

    P.O. Gaillard

