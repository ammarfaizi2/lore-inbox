Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266314AbSKOOhu>; Fri, 15 Nov 2002 09:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266318AbSKOOhu>; Fri, 15 Nov 2002 09:37:50 -0500
Received: from almesberger.net ([63.105.73.239]:8974 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S266314AbSKOOht>; Fri, 15 Nov 2002 09:37:49 -0500
Date: Fri, 15 Nov 2002 11:37:07 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andy Pfiffer <andyp@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <Martin.Bligh@provisioning.fibertel.com.ar>
Subject: Re: Kexec for v2.5.47-bk2
Message-ID: <20021115113707.A3749@almesberger.net>
References: <Pine.LNX.4.44.0211091901240.2336-100000@home.transmeta.com> <m1vg349dn5.fsf@frodo.biederman.org> <1037055149.13304.47.camel@andyp> <m1isz39rrw.fsf@frodo.biederman.org> <1037148514.13280.97.camel@andyp> <m1adkda9dm.fsf_-_@frodo.biederman.org> <20021115145454.B2503@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021115145454.B2503@in.ibm.com>; from suparna@in.ibm.com on Fri, Nov 15, 2002 at 02:54:54PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya wrote:
> What would be best way to pass a parameter or address from the
> current kernel to kernel being booted (e.g log buffer address
> or crash dump buffer etc) ?

At the moment, perhaps the initrd mechanism might be a useful
interface for this. You'd just leave some space either at the
beginning or at the end of the real initrd (if there's one),
and put your data there.

Afterwards, you can extract it either from the kernel, or even
from user space through /dev/initrd (with "noinitrd")

Advantages:
 - fairly non-intrusive
 - (almost ?) all platforms support this way of handling "some
   object in memory"
 - easy to play with from user space

Drawbacks:
 - needs synchronization with existing uses of initrd
 - a bit hackish

I'd expect that there will be eventually a number of things that
get passed from old to new kernels (e.g. crash data, device scan
results, etc.), so it may be useful to delay designing a "clean"
interface (for this, I expect some TLV structure in the initrd
area would make most sense) until more of those things have
shown up.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
