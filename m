Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286581AbRL0Tt4>; Thu, 27 Dec 2001 14:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286574AbRL0Tsk>; Thu, 27 Dec 2001 14:48:40 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:55308 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S286553AbRL0Trr>; Thu, 27 Dec 2001 14:47:47 -0500
Message-ID: <3C2B7A3E.E5C05404@zip.com.au>
Date: Thu, 27 Dec 2001 11:45:02 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: andersg@0x63.nu
CC: linux-kernel@vger.kernel.org, lvm-devel@sistina.com
Subject: Re: lvm in 2.5.1
In-Reply-To: <20011227084304.GA26255@h55p111.delphi.afb.lu.se> <3C2AEADB.24BEFE94@zip.com.au> <20011227122520.GA2194@h55p111.delphi.afb.lu.se> <3C2B75B3.4DEF90D3@zip.com.au>,
		<3C2B75B3.4DEF90D3@zip.com.au> <20011227193711.GB20501@h55p111.delphi.afb.lu.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

andersg@0x63.nu wrote:
> 
> On Thu, Dec 27, 2001 at 11:25:39AM -0800, Andrew Morton wrote:
> > 0xc02546c7 <lvm_do_vg_create+3>:        sub    $0x1d4,%esp
> >
> > So perhaps we have a compiler problem.  Which version of the
> > compiler are you using?   Have you verified that sizeof(lv_t)
> > is really around 420 bytes in your setup?
> 
> gcc version 2.95.4 20011223 (Debian prerelease)
> 
> i didn't check the exact amount. i dont know where the 420 bytes comes from?
> but (as Mike Galbraith pointed out) a lv_t contains:
> 
>         sector_t blocks[LVM_MAX_SECTORS];
> 
> with:
> 
> #define LVM_MAX_ATOMIC_IO       512
> #define LVM_MAX_SECTORS         (LVM_MAX_ATOMIC_IO * 2)
> 
> and
> typedef unsigned long sector_t;
> 
> unsigned long beeing 4bytes => the blocks-member of lv_t should then be 4096
> by it self...

Ah.  Right you are.  I was looking at the 2.4.17 source.  That array
was added in 2.5.x.

So 2.4.x is OK.

Thanks ;)

-
