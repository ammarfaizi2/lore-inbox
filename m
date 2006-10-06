Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbWJFTLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbWJFTLl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 15:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbWJFTLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 15:11:41 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:44991 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932315AbWJFTLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 15:11:39 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: vgoyal@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ak@suse.de,
       horms@verge.net.au, lace@jankratochvil.net, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com, maneesh@in.ibm.com
Subject: Re: [PATCH 12/12] i386 boot: Add an ELF header to bzImage
References: <20061003170032.GA30036@in.ibm.com>
	<20061003172511.GL3164@in.ibm.com>
	<20061003201340.afa7bfce.akpm@osdl.org>
	<m1vemzbe4c.fsf@ebiederm.dsl.xmission.com>
	<20061004214403.e7d9f23b.akpm@osdl.org>
	<m1ejtnb893.fsf@ebiederm.dsl.xmission.com>
	<20061004233137.97451b73.akpm@osdl.org>
	<m14pui4w7t.fsf@ebiederm.dsl.xmission.com>
	<20061005235909.75178c09.akpm@osdl.org>
	<m1bqop38nw.fsf@ebiederm.dsl.xmission.com>
	<20061006183846.GF19756@in.ibm.com> <4526A66B.4030805@zytor.com>
Date: Fri, 06 Oct 2006 13:09:34 -0600
In-Reply-To: <4526A66B.4030805@zytor.com> (H. Peter Anvin's message of "Fri,
	06 Oct 2006 11:54:35 -0700")
Message-ID: <m1ac49z2fl.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Vivek Goyal wrote:
>>>
>> Hi Eric,
>> I have added cld in the regenerated patch below.
>
> No, the cld needs to be earlier.  It turns out this isn't the first use of
> string instructions.

Can we rely on the int calls not setting df?  Otherwise we need to clear
df at each use as we do with all of the later uses.

> I think I am going to add DF=0 as a documented entry condition; it definitely
> seems all current Linux kernels require it.
>
>> Also one more minor nit. stosb relies on being %es set properly. By the
>> time control reaches loader_ok, i could not find %es being set explicitly
>> hence I am assuming we are relying on bootloader to set it up for us. Maybe we
>> can be little more paranoid and setup the %es before stosb. I
>> have done this change too in the attached patch. Pleaese have a look.
>> I know little about assembly code.
>
> %es being set is part of the requirements list, although it *would* be better to
> not rely on any segment registers being set at all (only rely on %cs.)

Agreed.

Eric

