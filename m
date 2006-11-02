Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751326AbWKBKog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbWKBKog (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 05:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752114AbWKBKog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 05:44:36 -0500
Received: from mx1.redhat.com ([66.187.233.31]:26518 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751326AbWKBKof (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 05:44:35 -0500
Date: Thu, 2 Nov 2006 05:43:05 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Magnus Damm <magnus@valinux.co.jp>
Cc: linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@in.ibm.com>,
       Andi Kleen <ak@muc.de>, magnus.damm@gmail.com, fastboot@lists.osdl.org,
       Horms <horms@verge.net.au>, Dave Anderson <anderson@redhat.com>,
       ebiederm@xmission.com
Subject: Re: [PATCH 01/02] Elf: Always define elf_addr_t in linux/elf.h
Message-ID: <20061102104305.GD24872@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20061102101942.452.73192.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061102101942.452.73192.sendpatchset@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2006 at 07:19:42PM +0900, Magnus Damm wrote:
> --- 0001/include/linux/elf.h
> +++ work/include/linux/elf.h	2006-11-02 15:44:10.000000000 +0900
> @@ -352,12 +352,16 @@ typedef struct elf64_note {
>    Elf64_Word n_type;	/* Content type */
>  } Elf64_Nhdr;
>  
> +typedef Elf64_Off elf64_addr;
> +typedef Elf32_Off elf32_addr;
> +

What are these typedefs useful for?  Isn't it better just to
use Elf32_Addr and Elf64_Addr in the #defines below?

>  #if ELF_CLASS == ELFCLASS32
>  
>  extern Elf32_Dyn _DYNAMIC [];
>  #define elfhdr		elf32_hdr
>  #define elf_phdr	elf32_phdr
>  #define elf_note	elf32_note
> +#define elf_addr_t	elf32_addr
>  
>  #else
>  
> @@ -365,6 +369,7 @@ extern Elf64_Dyn _DYNAMIC [];
>  #define elfhdr		elf64_hdr
>  #define elf_phdr	elf64_phdr
>  #define elf_note	elf64_note
> +#define elf_addr_t	elf64_addr
>  
>  #endif

	Jakub
