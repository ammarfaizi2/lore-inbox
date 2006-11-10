Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946696AbWKJOuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946696AbWKJOuX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 09:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946697AbWKJOuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 09:50:22 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:61824 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1946696AbWKJOuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 09:50:20 -0500
Date: Fri, 10 Nov 2006 09:49:22 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Magnus Damm <magnus.damm@gmail.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Magnus Damm <magnus@valinux.co.jp>, linux-kernel@vger.kernel.org,
       Vivek Goyal <vgoyal@in.ibm.com>, Andi Kleen <ak@muc.de>,
       fastboot@lists.osdl.org, Horms <horms@verge.net.au>,
       Dave Anderson <anderson@redhat.com>
Subject: Re: [PATCH 02/02] Elf: Align elf notes properly
Message-ID: <20061110144922.GA8155@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061102101942.452.73192.sendpatchset@localhost> <20061102101949.452.23441.sendpatchset@localhost> <m1psbwzpmx.fsf@ebiederm.dsl.xmission.com> <aec7e5c30611091952j6cd7988akc1671d269925bba9@mail.gmail.com> <m1irhnnb09.fsf@ebiederm.dsl.xmission.com> <aec7e5c30611092253q6bd15701x1f5da122de5c7075@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aec7e5c30611092253q6bd15701x1f5da122de5c7075@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2006 at 03:53:57PM +0900, Magnus Damm wrote:
[..]
> >Sure.
> >
> >To verify your claim that 8 byte alignment is correct I checked the
> >core dump code in fs/binfmt_elf.c in the linux kernel.  That always
> >uses 4 byte alignment.  Therefore it appears clear that only doing
> >4 byte alignment is not a local misreading of the spec, and is used in
> >other implementations.  If you can find an implementation that uses
> >8 byte alignment I am willing to consider it.
> 
> Yes, fs/binfmt_elf.c is one of the files that my patch modifies. There
> are several elf note implementations in the kernel, all seem to use
> 4-byte aligment.
> 
> Implementations that use 8-byte alignment:
> 
> binutils-2.16.1/bfd/elf.c: elf_core_write_note() is using
> log_file_align which is set to 3 on some 64-bit platforms.  8-byte
> alignment in some cases.
> 
> binutils-2.16.1/binutils/readelf.c: process_corefile_note_segment() is
> always using 4-byte alignment though.
> 
> >The current situation is that the linux kernel generated application
> >core dumps use 4 byte alignment so I expect that is what existing
> >applications such as gdb expect.
> 
> Most applications probably expect 4-byte aligned data. OTOH, I just
> came across HP's ELF-64 Object File Format document. It says that
> 8-byte alignment should be used:
> 
> http://devresource.hp.com/drc/STK/docs/refs/elf-64-hp.pdf
> 
> So now we have two documents that say 8-byte alignment should be used.
> 
> >Therefore we use 4 byte alignment unless it can be shown that the
> >linux core dumps are a fluke and should be fixed.
> 
> Ok. Vivek, Dave, anyone? Comments?
> 

IMHO, I think we should go by the specs (8byte boundary alignment on 64bit
platforms) until and unless it can be proven that specs are wrong. This
probably will mean that we will break things for sometime (until and unless
it is fixed in tool chain and probably will also break the capability to use
an older kernel for capturing dump). But that's unavoidable if we want to be
compliant to specs.

Thanks
Vivek
