Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261726AbVBCXT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbVBCXT2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 18:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbVBCXT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 18:19:27 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:24467 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S261726AbVBCXSy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 18:18:54 -0500
Date: Fri, 04 Feb 2005 08:18:56 +0900
From: Itsuro Oda <oda@valinux.co.jp>
To: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [Fastboot] [PATCH] Reserving backup region for kexec based crashdumps.
Cc: Koichi Suzuki <koichi@intellilink.co.jp>, Vivek Goyal <vgoyal@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, fastboot <fastboot@lists.osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Maneesh Soni <maneesh@in.ibm.com>,
       Hariprasad Nellitheertha <hari@in.ibm.com>,
       suparna bhattacharya <suparna@in.ibm.com>
In-Reply-To: <m14qgu81bw.fsf@ebiederm.dsl.xmission.com>
References: <20050203154433.18E4.ODA@valinux.co.jp> <m14qgu81bw.fsf@ebiederm.dsl.xmission.com>
Message-Id: <20050204074755.18EA.ODA@valinux.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.10.04 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03 Feb 2005 02:00:51 -0700
ebiederm@xmission.com (Eric W. Biederman) wrote:

> A better description is probably make a list of memory regions
> using an ELF header data structure in user space.  
> Use sys_kexec_load to put that list the dump kernel and a little
> big of glue code in the reserved area.  The glue code includes
> a hash of all of everything so it can all be validated before
> use.

I see. The data structure is put on a part of loading kernel's data. 

> Record the register information as ELF notes in a per cpu data
> area.  The per cpu data areas are known and enumerated in
> the list of memory regions.  The kernel knows nothing about
> the ELF header etc.
> 

I see.

> > 5) dump kernel: export all valid physical memory (and saved register
> >    information) to the user. (as /dev/oldmem /proc/vmcore ?)
> 
> Or in user space, by just mmaping /dev/mem. That is part of the
> current conversation.   The only real point for putting that code in
> the kernel (besides momentum) is it is a cheap way to get the exact
> data structures of the kernel you are using.  But since:
> (a) it does not look like any primary kernel data structures need to
>     be examined.
> (b) even simple compile options like SMP/NOSMP are enough to change
>     the layout of the data structures.
> I think there is a pretty good case for moving all of the work to
> user space.  But you still need a kernel that loads and
> runs in the reserved area.
> 
I don't make sense. what do you mean ?

What we want to do when the system is crashed is storing the whole
physical memory (and saved register information for x86 arch) to
some place (ex. a disk partition) for later analysis. 
So the basic requirments to the dump kernel is that:
 * supply a method to access whole (valid) physical memory.
 * supply a method to access the saved register information.

Does the kdump meet this requirment ? 

(I am not interesting to /proc/vmcore. Constructing the vmcore
 image is area of analysis tools. not kernel's task.)

Thanks.
-- 
Itsuro ODA <oda@valinux.co.jp>

