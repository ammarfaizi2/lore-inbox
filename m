Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267226AbUG1PXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267226AbUG1PXs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 11:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267230AbUG1PXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 11:23:48 -0400
Received: from jade.spiritone.com ([216.99.193.136]:42207 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S267226AbUG1PXk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 11:23:40 -0400
Date: Wed, 28 Jul 2004 08:23:29 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>, suparna@in.ibm.com
cc: Andrew Morton <akpm@osdl.org>, fastboot@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API
Message-ID: <120540000.1091028208@[10.10.2.4]>
In-Reply-To: <m1k6wo17za.fsf@ebiederm.dsl.xmission.com>
References: <16734.1090513167@ocs3.ocs.com.au><20040725235705.57b804cc.akpm@osdl.org><m1r7qw7v9e.fsf@ebiederm.dsl.xmission.com><20040728105455.GA11282@in.ibm.com> <m1k6wo17za.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Does anyone have a proof of concept implementation?  I have been able to find
>> 
>> Yes, Hari has a nice POC implementation - it might make sense for him to post
>> it rightaway for you to take a look. Basically, in addition to hmem (oldmem),
>> the upcoming kernel exports an ELF core view of the saved register and memory 
>> state of the previous kernel as /proc/vmcore.prev (remember your suggestion 
>> of using an ELF core file format for dump ?), so one can use cp or scp to 
>> save the core dump to disk. He has a quick demo, where he uses gdb (unmodified)
>> to open the dump and show a stack trace of the dumping cpu.
> 
> Yes I would like to look at that.  
> 
> I am tempted to suggest the data buffer with the registers and memory
> actually be in ELF format with virtual address representing where the
> data was in memory, and the physical addresses reporting where the
> data actually is in memory now.  Then we could just grab everything
> with /dev/mem..
> 
> But I don't know how much of pain this would be.

/dev/mem expects mem_map to be there, the size of which would easily
blow away the reserved section. /dev/oldmem (or whatever we call it)
is just a magic copy that does a kmap-like operation to get at pages
without a struct page.

M.

