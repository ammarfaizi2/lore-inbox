Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286529AbRL0Thl>; Thu, 27 Dec 2001 14:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286528AbRL0Thc>; Thu, 27 Dec 2001 14:37:32 -0500
Received: from h55p103-3.delphi.afb.lu.se ([130.235.187.176]:5284 "EHLO gin")
	by vger.kernel.org with ESMTP id <S286530AbRL0ThQ>;
	Thu, 27 Dec 2001 14:37:16 -0500
Date: Thu, 27 Dec 2001 20:37:11 +0100
To: Andrew Morton <akpm@zip.com.au>
Cc: andersg@0x63.nu, linux-kernel@vger.kernel.org, lvm-devel@sistina.com
Subject: Re: lvm in 2.5.1
Message-ID: <20011227193711.GB20501@h55p111.delphi.afb.lu.se>
In-Reply-To: <20011227084304.GA26255@h55p111.delphi.afb.lu.se> <3C2AEADB.24BEFE94@zip.com.au> <20011227122520.GA2194@h55p111.delphi.afb.lu.se> <3C2B75B3.4DEF90D3@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C2B75B3.4DEF90D3@zip.com.au>
User-Agent: Mutt/1.3.24i
From: andersg@0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2001 at 11:25:39AM -0800, Andrew Morton wrote:
> 0xc02546c7 <lvm_do_vg_create+3>:        sub    $0x1d4,%esp
> 
> So perhaps we have a compiler problem.  Which version of the
> compiler are you using?   Have you verified that sizeof(lv_t)
> is really around 420 bytes in your setup?

gcc version 2.95.4 20011223 (Debian prerelease)

i didn't check the exact amount. i dont know where the 420 bytes comes from?
but (as Mike Galbraith pointed out) a lv_t contains:

        sector_t blocks[LVM_MAX_SECTORS];
	
with:

#define LVM_MAX_ATOMIC_IO       512
#define LVM_MAX_SECTORS         (LVM_MAX_ATOMIC_IO * 2)

and 
typedef unsigned long sector_t;

unsigned long beeing 4bytes => the blocks-member of lv_t should then be 4096
by it self...

-- 

//anders/g

