Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261362AbSJ1Qqj>; Mon, 28 Oct 2002 11:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261365AbSJ1Qqi>; Mon, 28 Oct 2002 11:46:38 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3602 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261362AbSJ1Qqi>;
	Mon, 28 Oct 2002 11:46:38 -0500
Date: Mon, 28 Oct 2002 16:52:57 +0000
From: Matthew Wilcox <willy@debian.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matthew Wilcox <willy@debian.org>, "David S. Miller" <davem@redhat.com>,
       rmk@arm.linux.org.uk, hugh@veritas.com, akpm@zip.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] shmem missing cache flush
Message-ID: <20021028165257.Q27461@parcelfarce.linux.theplanet.co.uk>
References: <1035216742.27318.189.camel@irongate.swansea.linux.org.uk> <20021028.061059.38206858.davem@redhat.com> <20021028143226.N27461@parcelfarce.linux.theplanet.co.uk> <20021028.062608.78045801.davem@redhat.com> <20021028163649.P27461@parcelfarce.linux.theplanet.co.uk> <1035824897.1945.29.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1035824897.1945.29.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Mon, Oct 28, 2002 at 05:08:17PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2002 at 05:08:17PM +0000, Alan Cox wrote:
> Suppose those addresses are already in the userspace icache from a
> different exec ?

Documentation/cachetlb.txt:

  void flush_icache_range(unsigned long start, unsigned long end)
        When the kernel stores into addresses that it will execute
        out of (eg when loading modules), this function is called.

        If the icache does not snoop stores then this routine will need
        to flush it.

  void flush_icache_user_range(struct vm_area_struct *vma,
                        struct page *page, unsigned long addr, int len)
        This is called when the kernel stores into addresses that are
        part of the address space of a user process (which may be some
        other process than the current process).  The addr argument
        gives the virtual address in that process's address space,
        page is the page which is being modified, and len indicates
        how many bytes have been modified.  The modified region must
        not cross a page boundary.  Currently this is only called from
        kernel/ptrace.c.

so either they're using the wrong function or these calls aren't needed
for some other reason (eg, the update_mmu_cache() thing davem suggested
earlier).

-- 
Revolutions do not require corporate support.
