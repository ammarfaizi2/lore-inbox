Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263173AbUCMTgm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 14:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263174AbUCMTgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 14:36:42 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:15075 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S263173AbUCMTgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 14:36:38 -0500
Message-ID: <4053624D.6080806@BitWagon.com>
Date: Sat, 13 Mar 2004 11:34:37 -0800
From: John Reiser <jreiser@BitWagon.com>
Organization: -
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: arjanv@redhat.com
CC: Micha Feigin <michf@post.tau.ac.il>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: finding out the value of HZ from userspace
References: <20040311141703.GE3053@luna.mooo.com> <1079198671.4446.3.camel@laptop.fenrus.com>
In-Reply-To: <1079198671.4446.3.camel@laptop.fenrus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Thu, 2004-03-11 at 15:17, Micha Feigin wrote:
> 
>>Is it possible to find out what the kernel's notion of HZ is from user
>>space?
>>It seem to change from system to system and between 2.4 (100 on i386)
>>to 2.6 (1000 on i386).
> 
> 
> if you can see 1000 from userspace that is a bad kernel bug; can you say
> where you find something in units of 1000 ?

create_elf_tables() in fs/binfmt_elf.c tells every ELF execve():
         NEW_AUX_ENT(AT_CLKTCK, CLOCKS_PER_SEC);
which can be found by crawling through the stack above the pointer
to the last environment variable.

-- 

