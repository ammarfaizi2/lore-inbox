Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWJPOLO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWJPOLO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 10:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbWJPOLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 10:11:14 -0400
Received: from dhost002-49.dex002.intermedia.net ([64.78.21.145]:35899 "EHLO
	dhost002-49.dex002.intermedia.net") by vger.kernel.org with ESMTP
	id S1750703AbWJPOLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 10:11:13 -0400
Message-ID: <453392CD.1050504@qlusters.com>
Date: Mon, 16 Oct 2006 16:10:21 +0200
From: Constantine Gavrilov <constg@qlusters.com>
Reply-To: Constantine Gavrilov <constg@qlusters.com>
Organization: Qlusters
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.7.13) Gecko/20060501 Fedora/1.7.13-1.1.fc5
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Would SSI clustering extensions be of interest to kernelcommunity?
References: <45337FE3.8020201@qlusters.com> <1161006841.24237.33.camel@localhost.localdomain>
In-Reply-To: <1161006841.24237.33.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Oct 2006 14:11:11.0851 (UTC) FILETIME=[EF1343B0:01C6F12C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>Ar Llu, 2006-10-16 am 14:49 +0200, ysgrifennodd Constantine Gavrilov:
>  
>
>>2) Are kernel maintainers interested in clustering extensions to Linux 
>>kernel? Do they see any value in them? (Our code does not require kernel 
>>changes, but we are willing to submit it for inclusion if there is 
>>interest.)
>>    
>>
>
>If they are doing SSI well and do not need core kernel changes then yes
>they sound very interesting to me. Historically the big concern has
>always been that things like this muck up the kernel core which affects
>the other 99.99999% of users who don't want SSI clustering.
>
>Alan
>
>
>  
>

SSI intrudes kernel in two places: a) IO system calls, b ) page fault  
code for shared memory pages.

a) IO system calls are "packed" and forwarded to the "home" node, where 
original syscall code is executed.
b) A hook is inserted into page fault code that brings shared memory 
pages from other nodes when necessary.

Apart from these two hooks, SSI code is a "standalone" kernel API add-on 
("add", not "change").

Currently, we can do both "intrusions" from the kernel module. I assume 
that if we submit code, you will require a kernel patch that explicitly 
calls our hooks.

Also, continuous SSI in-kernel support may require SSI changes in the 
following cases: a) new fields in task struct that reflect process state 
(may affect task migration), b) changes in the page fault mechanism (may 
effect SSI shared memory code that brings and invalidates pages), c) 
addition of new system calls (may require implementation of  SSI 
suspport for them).

-- 
----------------------------------------
Constantine Gavrilov
Kernel Developer
Qlusters Software Ltd
1 Azrieli Center, Tel-Aviv
Phone: +972-3-6081977
Fax:   +972-3-6081841
----------------------------------------

