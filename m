Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264444AbUHWOKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264444AbUHWOKR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 10:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264479AbUHWOKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 10:10:17 -0400
Received: from mailer.nec-labs.com ([138.15.108.3]:868 "EHLO
	mailer.nec-labs.com") by vger.kernel.org with ESMTP id S264444AbUHWOKI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 10:10:08 -0400
Message-ID: <4129FAC8.3040502@nec-labs.com>
Date: Mon, 23 Aug 2004 10:10:16 -0400
From: Lei Yang <leiyang@nec-labs.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Sam Ravnborg <sam@ravnborg.org>,
       Kernel Newbies Mailing List <kernelnewbies@nl.linux.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problems compiling kernel modules
References: <4127A15C.1010905@nec-labs.com>	 <20040821214402.GA7266@mars.ravnborg.org> <4127A662.2090708@nec-labs.com>	 <20040821215055.GB7266@mars.ravnborg.org>  <4127B49A.6080305@nec-labs.com> <1093121824.854.167.camel@krustophenia.net>
In-Reply-To: <1093121824.854.167.camel@krustophenia.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Aug 2004 14:10:08.0297 (UTC) FILETIME=[E555B190:01C4891A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi friends,

I've askeed questions about errors compiling kernel modules caused by 
including <stdio.h> and got some very helpful info here.

I changed those I/O stream and file operation in the code and get the 
module compiled, however, there would be warnings like

In file included from /home/lei/modules/test.c:49:
/home/lei/modules/Kcomp.h:21: warning: function declaration isn't a 
prototype
/home/lei/modules/Kcomp.h:27: warning: function declaration isn't a 
prototype
/home/lei/modules/Kcomp.h:69: warning: function declaration isn't a 
prototype

And the no prototype fuction looks like

int preset() // with no arguments
{
	p = &nodes[0][0];
	return 0;
}


So when I tried to install the module with insmod ./test.ko ,
there would be an error,

insmod: error inserting './test.ko': -1 Unknown symbol in module

Could anyone tell me what is wrong here? Is that because of the no 
prototype function declaration?

TIA
Lei

Lee Revell wrote:
> On Sat, 2004-08-21 at 16:46, Lei Yang wrote:
> 
>>What about multi-file module?
>>
>>Say test.c doesn't include stdio.h, while there is some other .c file 
>>which is to be compiled and linked into test.ko, include stdio?
>>
>>Would that work?
>>
> 
> 
> Are you just trying to print from a kernel module?  Use printk.
> 
> The kernel does not really have its own standard input and standard
> output - the kernel manages those things for processes.
> 
> Lee
> 
