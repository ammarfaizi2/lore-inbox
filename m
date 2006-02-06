Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbWBFQu3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbWBFQu3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 11:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbWBFQu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 11:50:29 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:64839 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932217AbWBFQu2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 11:50:28 -0500
Message-ID: <43E77E9F.2060803@sw.ru>
Date: Mon, 06 Feb 2006 19:51:43 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Linus Torvalds <torvalds@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       frankeh@watson.ibm.com, clg@fr.ibm.com, greg@kroah.com,
       alan@lxorguk.ukuu.org.uk, serue@us.ibm.com, arjan@infradead.org,
       Rik van Riel <riel@redhat.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, devel@openvz.org,
       Pavel Emelianov <xemul@sw.ru>
Subject: Re: [RFC][PATCH 1/5] Virtualization/containers: startup
References: <43E38BD1.4070707@openvz.org>	 <Pine.LNX.4.64.0602030905380.4630@g5.osdl.org> <43E3915A.2080000@sw.ru>	 <Pine.LNX.4.64.0602030939250.4630@g5.osdl.org>	 <1138991641.6189.37.camel@localhost.localdomain>  <43E61448.7010704@sw.ru> <1139243734.6189.69.camel@localhost.localdomain>
In-Reply-To: <1139243734.6189.69.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> I worry that using something like "vps" obfuscates the real meaning a
> bit.  The reason that "owner_vps" doesn't sound weird is that people, by
> default, usually won't understand what a "vps" is.
container or context sounds the same :) it is impossible to feel this 
notion naturally without getting into details. IMHO.

> (if you like acronyms a lot, I'm sure I can find a job for you at IBM or
> in the US military :)
We can talk about it separetely :)))

>>Please, also note, in OpenVZ we have 2 pointers on task_struct:
>>One is owner of a task (owner_env), 2nd is a current context (exec_env). 
>>exec_env pointer is used to avoid adding of additional argument to all 
>>the functions where current context is required.
> 
> That makes sense.  However, are there many cases in the kernel where a
> task ends up doing something temporary like this:
> 
> 	tsk->exec_vnc = bar;
> 	do_something_here(task);
> 	tsk->exec_vnc = foo;
> 
> If that's the case very often, we probably want to change the APIs, just
> to make the common action explicit.  If it never happens, or is a
> rarity, I think it should be just fine.
It is quite rare. In IRQ, softIRQ, TCP/IP stack and some timers. Not much.

>>VPS ID is passed to/from user space APIs and when you have a cluster 
>>with different archs and VPSs it is better to have something in common 
>>for managing this.
> I guess it does keep you from running into issues with mixing 32 and
> 64-bit processes.  But, haven't we solved those problems already?  Is it
> just a pain?
VPSs can live in clusters. It is good to have one VPS ID space.

Kirill


