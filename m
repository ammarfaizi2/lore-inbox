Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262738AbTKYPXS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 10:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262740AbTKYPXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 10:23:18 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:26840 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S262738AbTKYPXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 10:23:14 -0500
Message-ID: <3FC373DE.9090507@softhome.net>
Date: Tue, 25 Nov 2003 16:23:10 +0100
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: arjanv@redhat.com
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.2/2.4/2.6 VMs: do malloc() ever return NULL?
References: <VLAm.2g1.9@gated-at.bofh.it> <VM3n.3jY.9@gated-at.bofh.it>
In-Reply-To: <VM3n.3jY.9@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> 
> that is due to the overcommit policy that your admin has set. 
> You can set it to disabled and then malloc will return NULL in userspace
> 

    Target (patched by mvista) system works as expected in case of 
memory being touch.
    But in case of "for(;;) malloc(N)" it still gets 1.8GB memory 
allocated. (this is ppc32 - looks like 2/2 memory split) So it doesn't 
look like working at all. So basicly pool allocation used in carrier 
grade systems goes south: even with overcommit_memory=-1 && malloc()!=0 
you can not be sure that memory is really allocated. Not good.

    Vanilla 2.4.22 (this is x86) (with HZ=1024, if it does matter).

    after '# echo -1 >/proc/sys/vm/overcommit_memory'
    1. test app with memory touch still gets killed by oom_killer. (so 
no malloc() == NULL)
    2. test app w/o memory touch still can happily allocate 2.8GB of 
memory (x86 - looks like 3/1 memory split) and only then gets NULL 
pointer - oom_killer is silent.

    But thanks for pointers in any way...

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--                                                           _ _ _
  Because the kernel depends on it existing. "init"          |_|*|_|
  literally _is_ special from a kernel standpoint,           |_|_|*|
  because its' the "reaper of zombies" (and, may I add,      |*|*|*|
  that would be a great name for a rock band).
                                 -- Linus Torvalds

