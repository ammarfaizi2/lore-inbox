Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265482AbUFIBkg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265482AbUFIBkg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 21:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265497AbUFIBkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 21:40:36 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:49383 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S265482AbUFIBkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 21:40:25 -0400
Message-ID: <40C66A7D.6080402@BitWagon.com>
Date: Tue, 08 Jun 2004 18:40:13 -0700
From: John Reiser <jreiser@BitWagon.com>
Organization: -
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Mike McCormack <mike@codeweavers.com>, Jakub Jelinek <jakub@redhat.com>,
       Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: WINE + NX (No eXecute) support for x86, 2.6.7-rc2-bk2
References: <40C2B51C.9030203@codeweavers.com> <20040606052615.GA14988@elte.hu> <40C2D5F4.4020803@codeweavers.com> <1086507140.2810.0.camel@laptop.fenrus.com> <20040608092055.GX4736@devserv.devel.redhat.com> <40C59FE9.1010700@codeweavers.com> <20040608103221.GA7632@elte.hu>
In-Reply-To: <20040608103221.GA7632@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Mike McCormack <mike@codeweavers.com> wrote:
> 
> 
>>I did not investigate this, but others who did think that it is not
>>possible to create a segment that is reserve only so that does not
>>unnecessarily consume virtual memory. Apparently ELF allows it, but
>>Linux doesn't.
> 
> 
> what do you mean by "Linux doesn't"?

Current fs/binfmt_elf.c creates at most one ".bss" area, regardless of
how many PT_LOAD have .p_filesz < .p_memsz.  The .bss area always
has PROT_WRITE|PROT_READ page protection, regardless of .p_flags.
Thus "Linux doesn't" do as faithful a job as it could with ELF.

I submitted "elfdiet" and "bssprot" patches a couple months ago
to address these issues.  The bssprot patch appeared briefly in -mm
for 2.6.[56], but was dropped because of ARCH pain, particularly
with the sn2 variant of ia64.  The hardware is scarce, and the topic
was not sufficiently interesting for those with access to such a box.

-- 

