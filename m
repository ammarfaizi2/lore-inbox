Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751504AbWJEG1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbWJEG1p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 02:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbWJEG1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 02:27:45 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:62664 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751504AbWJEG1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 02:27:44 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: vgoyal@in.ibm.com
Cc: Andrew Morton <akpm@osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ak@suse.de,
       horms@verge.net.au, lace@jankratochvil.net, hpa@zytor.com,
       magnus.damm@gmail.com, lwang@redhat.com, dzickus@redhat.com,
       maneesh@in.ibm.com
Subject: Re: [PATCH 12/12] i386 boot: Add an ELF header to bzImage
References: <20061003170032.GA30036@in.ibm.com>
	<20061003172511.GL3164@in.ibm.com>
	<m11wpoeewn.fsf@ebiederm.dsl.xmission.com>
	<20061004170309.GE16218@in.ibm.com>
Date: Thu, 05 Oct 2006 00:25:58 -0600
In-Reply-To: <20061004170309.GE16218@in.ibm.com> (Vivek Goyal's message of
	"Wed, 4 Oct 2006 13:03:09 -0400")
Message-ID: <m14pujb7nt.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> writes:

Ok.  I just noticed another piece that we want to change for
greater compatibility.  We should make the virtual and the physical
addresses the same.  Then there is no danger of some loader getting
them mixed up.

I.e. Not:
  
> +.org 80
> +phdr:
> +	.int PT_LOAD					# p_type
> +	.int (SETUPSECTS+1)*512				# p_offset
> +	.int LOAD_PHYSICAL_ADDR + __PAGE_OFFSET		# p_vaddr
> +	.int LOAD_PHYSICAL_ADDR				# p_paddr
> +	.int SYSSIZE*16					# p_filesz
> +	.int 0						# p_memsz
> +	.int PF_R | PF_W | PF_X				# p_flags
> +	.int CONFIG_PHYSICAL_ALIGN			# p_align
> +e_phdr:
> +

but
> +.org 80
> +phdr:
> +	.int PT_LOAD					# p_type
> +	.int (SETUPSECTS+1)*512				# p_offset
> +	.int LOAD_PHYSICAL_ADDR				# p_vaddr
> +	.int LOAD_PHYSICAL_ADDR				# p_paddr
> +	.int SYSSIZE*16					# p_filesz
> +	.int 0						# p_memsz
> +	.int PF_R | PF_W | PF_X				# p_flags
> +	.int CONFIG_PHYSICAL_ALIGN			# p_align
> +e_phdr:
> +
>  start2:
>  	movw	%cs, %ax
>  	movw	%ax, %ds
> @@ -78,11 +128,11 @@ die:


Eric
