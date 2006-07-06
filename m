Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbWGFSnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWGFSnS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 14:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbWGFSnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 14:43:18 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:17635 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S1750731AbWGFSnR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 14:43:17 -0400
Message-ID: <44AD599D.70803@colorfullife.com>
Date: Thu, 06 Jul 2006 20:42:37 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.13) Gecko/20060501 Fedora/1.7.13-1.1.fc5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Kerrisk <mtk-manpages@gmx.net>
CC: mtk-lkml@gmx.net, rlove@rlove.org, roland@redhat.com, eggert@cs.ucla.edu,
       paire@ri.silicomp.fr, drepper@redhat.com, torvalds@osdl.org,
       tytso@mit.edu, linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net
Subject: Re: Strange Linux behaviour with blocking syscalls and stop signals+SIGCONT
References: <44A92DC8.9000401@gmx.net> <44AABB31.8060605@colorfullife.com> <20060706092328.320300@gmx.net>
In-Reply-To: <20060706092328.320300@gmx.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Kerrisk wrote:

>  
>
>>Michael: Could you replace the EINTR in inotify.c with ERESTARTNOHAND? 
>>That should prevent the kernel from showing the signal to user space.
>>I'd guess that most instances of EINTR are wrong, except in device 
>>drivers: It means we return from the syscall, even if the signal handler 
>>wants to restart the system call.
>>    
>>
>
>I'll try patching a kernel to s/EINTR/ERESTARTNOHAND/ in relevant
>places, and see how that goes.  If it goes well, I'll submit a 
>patch.
>
>  
>
1) I would go further and try ERESTARTSYS: ERESTARTSYS means that the 
kernel signal handler honors SA_RESTART
2) At least for the futex functions, it won't be as easy as replacing 
EINTR wiht ERESTARTSYS: the futex functions receive a timeout a the 
parameter, with the duration of the wait call as a parameter. You must 
use ERESTART_RESTARTBLOCK.

--
    Manfred
