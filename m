Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262617AbVBCH2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262617AbVBCH2g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 02:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262596AbVBCH2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 02:28:36 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:45804 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S262994AbVBCH2G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 02:28:06 -0500
Date: Thu, 03 Feb 2005 16:28:10 +0900
From: Itsuro Oda <oda@valinux.co.jp>
To: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [Fastboot] [PATCH] Reserving backup region for kexec based crashdumps.
Cc: Koichi Suzuki <koichi@intellilink.co.jp>, Vivek Goyal <vgoyal@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, fastboot <fastboot@lists.osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Maneesh Soni <maneesh@in.ibm.com>,
       Hariprasad Nellitheertha <hari@in.ibm.com>,
       suparna bhattacharya <suparna@in.ibm.com>
In-Reply-To: <m1brb39e98.fsf@ebiederm.dsl.xmission.com>
References: <4200861B.7040807@intellilink.co.jp> <m1brb39e98.fsf@ebiederm.dsl.xmission.com>
Message-Id: <20050203154433.18E4.ODA@valinux.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.10.04 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 02 Feb 2005 08:24:03 -0700
ebiederm@xmission.com (Eric W. Biederman) wrote:
> 
> So the kernel+initrd that captures a crash dump will live and execute
> in a reserved area of memory.  It needs to know which memory regions
> are valid, and it needs to know small things like the final register
> state of each cpu. 

Exactly.

Please let me clarify what you are going to.
1) standard kernel: reserve a small contigous area for a dump kernel
   (this is not changed as the current code)
2) standard kernel: export the information of valid physical memory
   regions. (/proc/iomem or /proc/cpumem etc.)
3) kexec (system call?): store the information of valid physical memory
   regions as ELF program header to the reserved area (mentioned 1)).
4) standard kernel: when a panic occur, append (ex.) the register
   information as ELF note after the memory information (if necessary).
   and jump new kernel
5) dump kernel: export all valid physical memory (and saved register
   information) to the user. (as /dev/oldmem /proc/vmcore ?)

Is this correct ?  one question: how the dump kernel know the saved
area of ELF headers ?

one more question: I don't understand what the 640K backup area is. 
Please let me know why it is necessary.

Thanks.
-- 
Itsuro ODA <oda@valinux.co.jp>

