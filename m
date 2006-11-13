Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933061AbWKMVR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933061AbWKMVR1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 16:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933060AbWKMVR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 16:17:27 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:62436 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S933061AbWKMVR0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 16:17:26 -0500
Date: Mon, 13 Nov 2006 16:16:36 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, hpa@zytor.com, magnus.damm@gmail.com, lwang@redhat.com,
       dzickus@redhat.com
Subject: Re: [RFC] [PATCH 2/16] x86_64: Assembly safe page.h and pgtable.h
Message-ID: <20061113211636.GC13832@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061113162135.GA17429@in.ibm.com> <20061113162827.GC17429@in.ibm.com> <200611131817.01066.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611131817.01066.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2006 at 06:17:00PM +0100, Andi Kleen wrote:
> On Monday 13 November 2006 17:28, Vivek Goyal wrote:
> > 
> > This patch makes pgtable.h and page.h safe to include
> > in assembly files like head.S.  Allowing us to use
> > symbolic constants instead of hard coded numbers when
> > refering to the page tables.
> 
> Hmm, I think the ULs are probably not needed anyways. What
> happens when you just drop them even for C? You shouldn't get any 
> new warnings i hope.
>

I think we need these UL suffixes. Otherwise in some cases overflow
can take place and compiler emits warning.

For ex. in following definition I got rid of UL.

#define PGDIR_SIZE      (1 << PGDIR_SHIFT) 

Here constant defaulted to intger and PGDIR_SHIFT is 39. Hence compiler
emits following warning wherever PGDIR_SIZE is used.

arch/x86_64/kernel/machine_kexec.c: In function init_level3_page:
arch/x86_64/kernel/machine_kexec.c:47: warning: left shift count >=
width of type
arch/x86_64/kernel/machine_kexec.c: In function init_level4_page:
arch/x86_64/kernel/machine_kexec.c:80: warning: left shift count >=
width of type
arch/x86_64/kernel/machine_kexec.c:96: warning: left shift count >=
width of type
arch/x86_64/kernel/machine_kexec.c:101: warning: left shift count >=
width of type

Thanks
Vivek
