Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314838AbSECRLG>; Fri, 3 May 2002 13:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314841AbSECRLF>; Fri, 3 May 2002 13:11:05 -0400
Received: from holomorphy.com ([66.224.33.161]:28892 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S314838AbSECRLE>;
	Fri, 3 May 2002 13:11:04 -0400
Date: Fri, 3 May 2002 10:09:29 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Leandro Tavares Carneiro <leandro@ep.petrobras.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: High Memory Address Space
Message-ID: <20020503170929.GS32767@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	Leandro Tavares Carneiro <leandro@ep.petrobras.com.br>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1020437001.2951.45.camel@linux60> <Pine.LNX.3.95.1020503123034.1208A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2002 at 12:46:12PM -0400, Richard B. Johnson wrote:
> Unix/Linux on 32-bit machines use 32-bit address space. All addresses
> are virtual so some of the pages can come from anywhere, including
> so-called "high memory". The memory managment makes these pages
> appear contiguous to each task (and to the kernel itself). One of
> the Unix characteristics is that the kernel address space is
> shared with each of the process address space. This means that the
> actual process address-space does not start at 0 and extend to
> 0xffffffff. Instead it starts at an address that leaves room for
> the kernel. This split can, in principle, be changed. However
> it will result in only a few more megabytes of user address space
> and might interfere with the memory mapping of runtime libraries
> which, last time I checked, presume certain starting addresses:

Well, since the kernel is using up a whole 1GB for itself, from a
naive point of view, it might seem a target for reclamation.

On Fri, May 03, 2002 at 12:46:12PM -0400, Richard B. Johnson wrote:
> Script started on Fri May  3 12:39:03 2002
> # cat >xxx.c
> main() { return 0; }
> # gcc -c -o xxx.o xxx.c
> # ld -o xxx xxx.o
> ld: warning: cannot find entry symbol _start; defaulting to 08048074
> # exit
> exit
> Script done on Fri May  3 12:39:45 2002
> You can see that the assumed starting address is 08048074.

This is default linker script (SVR4 ABI) stuff, the portion of the process
address space reserved for the kernel extends from 3GB to 4GB in Linux.
It's fully well possible to link and run executables so that they are
loaded at the first page above the zero page, though little does it.


Cheers,
Bill
