Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285392AbRLGDSO>; Thu, 6 Dec 2001 22:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285391AbRLGDSE>; Thu, 6 Dec 2001 22:18:04 -0500
Received: from holomorphy.com ([216.36.33.161]:45187 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S285389AbRLGDRv>;
	Thu, 6 Dec 2001 22:17:51 -0500
Date: Thu, 6 Dec 2001 19:17:34 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: vma->vm_end > 0x60000000
Message-ID: <20011206191734.B818@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>
In-Reply-To: <Pine.LNX.4.10.10010311645420.400-100000@cassiopeia.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.LNX.4.10.10010311645420.400-100000@cassiopeia.home>; from geert@linux-m68k.org on Tue, Oct 31, 2000 at 04:48:11PM +0100
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2000 at 04:48:11PM +0100, Geert Uytterhoeven wrote:
> In fs/proc/array.c:proc_pid_statm() there is this test block:
> 
>     if (vma->vm_flags & VM_EXECUTABLE)
> 	    trs += pages;   /* text */
>     else if (vma->vm_flags & VM_GROWSDOWN)
> 	    drs += pages;   /* stack */
>     else if (vma->vm_end > 0x60000000)
> 	    lrs += pages;   /* library */
>     else
> 	    drs += pages;
> 
> Is there any special reason for the hardcoded constant `0x60000000'?
> In the Linux/m68k tree, we use TASK_UNMAPPED_BASE instead. But I don't know
> why.

I think this is an old x86 load address for an ELF interpreter. Would
you be happy with ELF_ET_DYN_BASE? I made a fairly small patch that
deals with that.


Cheers,
Bill
