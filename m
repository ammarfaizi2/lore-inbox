Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261502AbREQTCT>; Thu, 17 May 2001 15:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261493AbREQTCJ>; Thu, 17 May 2001 15:02:09 -0400
Received: from oss.sgi.com ([216.32.174.190]:62220 "EHLO oss.sgi.com")
	by vger.kernel.org with ESMTP id <S261498AbREQTB5>;
	Thu, 17 May 2001 15:01:57 -0400
Date: Wed, 16 May 2001 01:33:55 -0300
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: "Khachaturov, Vassilii" <Vassilii.Khachaturov@comverse.com>,
        linux-kernel@vger.kernel.org
Subject: Re: uid_t and gid_t vs.  __kernel_uid_t and __kernel_gid_t
Message-ID: <20010516013355.A1299@bacchus.dhis.org>
In-Reply-To: <2E927786773@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <2E927786773@vcnet.vc.cvut.cz>; from VANDROVE@vc.cvut.cz on Mon, May 14, 2001 at 09:14:26PM +0000
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2001 at 09:14:26PM +0000, Petr Vandrovec wrote:

> > I had to communicate uid/gid from an application down 
> > to a driver, and discovered that uid and gid in user
> > space are different from those in kernel space.
> 
> ncpfs uses 'unsigned long' in its ncp_mount_data_v4, as MIPS uses
> 'long' type for uid/gid. Unfortunately it still needs conversions
> on some archs, so maybe using u_int64_t is just best solution
> (AFAIK as MIPS unsigned long is 64bit, you have to use u_int64_t
> if you want same type accross architectures).

Only for the 64 bit ABI and kernel on MIPS have a long data type of 64 bits.
General rule for Linux sizeof(pointer) = sizeof(long).

> Kernel part then just checks wheter uid == (__kernel_uid_t)uid and 
> gives up if they differ.

Otherwise funny ones line (u16) 65536 == 0 -> root access could happen ...

  Ralf
