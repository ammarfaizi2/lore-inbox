Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266724AbUFYUs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266724AbUFYUs2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 16:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266695AbUFYUs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 16:48:28 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:6665 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S266743AbUFYUrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 16:47:12 -0400
Date: Fri, 25 Jun 2004 22:47:02 +0200
To: Arjan van de Ven <arjanv@redhat.com>, EdHamrick@aol.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.7-mm2, mmaps rework, buggy apps, setarch
Message-ID: <20040625204702.GA22859@gamma.logic.tuwien.ac.at>
References: <20040625103326.GA21814@gamma.logic.tuwien.ac.at> <20040625105312.GD20954@devserv.devel.redhat.com> <20040625082243.GA11515@gamma.logic.tuwien.ac.at> <20040625013508.70e6d689.akpm@osdl.org> <20040625103326.GA21814@gamma.logic.tuwien.ac.at> <20040625104449.GC20954@devserv.devel.redhat.com> <20040625082243.GA11515@gamma.logic.tuwien.ac.at> <20040625013508.70e6d689.akpm@osdl.org> <20040625103326.GA21814@gamma.logic.tuwien.ac.at> <20040625104317.GB20954@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f.3ff82aed.2e0d624a@aol.com> <20040625105312.GD20954@devserv.devel.redhat.com> <20040625104449.GC20954@devserv.devel.redhat.com> <20040625104317.GB20954@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arjan!

On Fre, 25 Jun 2004, Arjan van de Ven wrote:
> > open("/media4/scan/cam-2002.03/001-100/raw/scan0100.tif", O_RDONLY) = 6
> > lseek(6, 0, SEEK_END)                   = 43426634
> > lseek(6, 0, SEEK_CUR)                   = 43426634
> > lseek(6, 0, SEEK_SET)                   = 0
> > mmap2(NULL, 43426634, PROT_READ|PROT_WRITE, MAP_PRIVATE, 6, 0) = -1 ENOMEM (Cann
> > ot allocate memory)
> 
> interesting.
> 
> Could you start the binary in gdb, and then when the segfault happens, take
> a snapshot of /proc/<pid>/maps of this binary ?

Attached is gdb.maps and vuescan.maps, the former is the
/proc/<pid>/maps for the gdb process, the later for the vuescan which
has been started from within gdb.

> can you also mail me the output of ulimit -a ?

core file size        (blocks, -c) unlimited
data seg size         (kbytes, -d) unlimited
file size             (blocks, -f) unlimited
max locked memory     (kbytes, -l) unlimited
max memory size       (kbytes, -m) unlimited
open files                    (-n) 1024
pipe size          (512 bytes, -p) 8
stack size            (kbytes, -s) 8192
cpu time             (seconds, -t) unlimited
max user processes            (-u) 6143
virtual memory        (kbytes, -v) unlimited



On Fre, 25 Jun 2004, Arjan van de Ven wrote:
> if you remove the following 3 lines from mm/mmap.c
> +	/* make sure it can fit in the remaining address space */
> +	if (mm->free_area_cache < len)
> +		return -ENOMEM;
> does it work ?
> (those lines do an optimisation that I suspect is backfiring here...)

No.


I included Ed in the Cc: to keep him uptodate:

On Fre, 25 Jun 2004, EdHamrick@aol.com wrote:
> >  int ptr;
> >  ptr = malloc(some_size); 
> >  if (ptr <= 0)
> >      handle_no_memory();
> 
> No, I never do this.  I only check for NULL or non-NULL, which is correct.

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
SKELLOW (adj.)
Descriptive of the satisfaction experienced when looking at a really
good dry-stone wall.
			--- Douglas Adams, The Meaning of Liff
