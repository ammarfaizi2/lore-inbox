Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316822AbSEaU6J>; Fri, 31 May 2002 16:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316831AbSEaU6J>; Fri, 31 May 2002 16:58:09 -0400
Received: from web13806.mail.yahoo.com ([216.136.175.16]:34057 "HELO
	web13806.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S316822AbSEaU6I>; Fri, 31 May 2002 16:58:08 -0400
Message-ID: <20020531205808.60383.qmail@web13806.mail.yahoo.com>
Date: Fri, 31 May 2002 13:58:08 -0700 (PDT)
From: William Chow <lilbilchow@yahoo.com>
Subject: Re: is pci_alloc_consistent() really consistent on a pentium?
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020530.133555.51807197.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks much for the response.

Can you point me at any sources/references that can
enlighten me on how this works? I did find some
additional information in the IA32 s/w dev guide
(particularly, vol 3-10.3.2) which reiterated your
response, but it seemed to give short shrift to the
mechanism behind it (it suggested that the magic was
in the snooping by the memory controller and cpu).

--- "David S. Miller" <davem@redhat.com> wrote:
>    From: William Chow <lilbilchow@yahoo.com>
>    Date: Thu, 30 May 2002 13:44:06 -0700 (PDT)
> 
>    If IA32 builds use the i386 version of
>    pci_alloc_consistent(), how is the memory
> provided by
>    this function really write-thru (on a pentium)
> since
>    it appears to only set up the default mapping
>    (PCD/PWT==0)? In contrast, pgprot_noncached() and
>    pci_mmap_page_range() explicitly set these bits
> on a
>    pentium (i.e. when boot_cpu_data.x86 > 3). Or am
> I
>    missing something?
> 
> pci_mmap_page_range maps I/O memory, like frame
> buffers and
> device registers.
> 
> pci_alloc_consistent promises only that CPU writes
> will be coherent
> with PCI device DMA activity.  For Pentium this
> holds true with all
> normal ram, because once the cpu does the store
> coherent transactions
> on the system bus (from, for example, the PCI
> device) will take a hit
> on the L2 cache line of the cpu and thus the cpu
> will provide the most
> up to date copy of the data.


__________________________________________________
Do You Yahoo!?
Yahoo! - Official partner of 2002 FIFA World Cup
http://fifaworldcup.yahoo.com
