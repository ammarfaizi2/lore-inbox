Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263714AbUECOLi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263714AbUECOLi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 10:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263718AbUECOLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 10:11:37 -0400
Received: from citrine.spiritone.com ([216.99.193.133]:62120 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S263712AbUECOLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 10:11:31 -0400
Message-ID: <4096526C.4060503@BitWagon.com>
Date: Mon, 03 May 2004 07:08:44 -0700
From: John Reiser <jreiser@BitWagon.com>
Organization: -
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: akpm@osdl.org, mike@navi.cx, pageexec@freemail.hu,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: arch/ia64/ia32/binfmt_elf32.c: elf32_map() broken ia64 build
 _and_ boot
References: <20040426185633.7969ca0d.pj@sgi.com> <20040501013304.32a750d3.pj@sgi.com>
In-Reply-To: <20040501013304.32a750d3.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Not only don't the bssprot patches in Andrew's 2.6.6-rc2-mm2 not build,
> they don't boot on SGI's SN2 ia64 with sn2_defconfig.  If I remove these
> 4 bssprot patches, then 2.6.6-rc2-mm2 builds (with the easy build fixes
> already understood earlier this week) and boots on SN2 ia64 with
> sn2_defconfig.
[snip]
> But trying to boot the resulting kernel on an SGI SN2 system fails.  The
> boot successfully prints out:
> 
>   Freeing unused kernel memory: 336kB freed
> 
> but freezes prior to displaying the next line expected:
> 
>   INIT: version 2.85 booting
> 
> I have to reset instead at this point.
> 
> On this system the program /sbin/init is the following type:
> 
>   /sbin/init: ELF 64-bit LSB executable, IA-64, version 1 (SYSV),
>   for GNU/Linux 2.4.0, dynamically linked (uses shared libs), stripped

This indicates a problem with the very first execve() and/or its shared
libraries.  It is likely that printk() of the arguments and results
to elf_map() and load_elf_interp(), both in fs/binfmt_elf.c,
will aid in finding the problem.  This I would do, if I had hardware.

Are there any reports, either success or failure, for any other 64-bit
architecture?

-- 

