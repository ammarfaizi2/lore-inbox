Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267212AbUG1POZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267212AbUG1POZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 11:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267214AbUG1POY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 11:14:24 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:18359 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S267212AbUG1PNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 11:13:12 -0400
To: suparna@in.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, fastboot@osdl.org,
       linux-kernel@vger.kernel.org, "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API
References: <16734.1090513167@ocs3.ocs.com.au>
	<20040725235705.57b804cc.akpm@osdl.org>
	<m1r7qw7v9e.fsf@ebiederm.dsl.xmission.com>
	<20040728105455.GA11282@in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 28 Jul 2004 09:12:25 -0600
In-Reply-To: <20040728105455.GA11282@in.ibm.com>
Message-ID: <m1k6wo17za.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya <suparna@in.ibm.com> writes:

> This differs a little from your earlier suggestion of requiring
> a kernel to run from a non-default address. Martin suggested simply
> reserving about 16MB of area in advance, so that just before kexecing
> the new kernel with mem=16M, we save the first 16MB away into the
> reserved space. /dev/hmem (oldmem ?) is a view into the old kernel's
> memory, as opposed to /dev/mem.

Ok, That is fairly simple, and can be implemented easily, so it is
a good place to start.

A buffer to save old kernel state is needed.  At the very least
we need to save the old register state, copying over several megabytes
of data won't hurt the picture.

It has a little more exposure to on-going DMA transfers than running
from a reserved area of memory, as some of that memory may have been
setup as DMA buffers by the dying kernel. 

If it turns out that on-going DMA is a problem I see that as something
we can fix later on.


> > Does anyone have a proof of concept implementation?  I have been able to find
> 
> Yes, Hari has a nice POC implementation - it might make sense for him to post
> it rightaway for you to take a look. Basically, in addition to hmem (oldmem),
> the upcoming kernel exports an ELF core view of the saved register and memory 
> state of the previous kernel as /proc/vmcore.prev (remember your suggestion 
> of using an ELF core file format for dump ?), so one can use cp or scp to 
> save the core dump to disk. He has a quick demo, where he uses gdb (unmodified)
> to open the dump and show a stack trace of the dumping cpu.

Yes I would like to look at that.  

I am tempted to suggest the data buffer with the registers and memory
actually be in ELF format with virtual address representing where the
data was in memory, and the physical addresses reporting where the
data actually is in memory now.  Then we could just grab everything
with /dev/mem..

But I don't know how much of pain this would be.

Eric
