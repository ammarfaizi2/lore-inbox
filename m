Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277092AbRJKX6I>; Thu, 11 Oct 2001 19:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277093AbRJKX6C>; Thu, 11 Oct 2001 19:58:02 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:3247 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S277092AbRJKX5u>; Thu, 11 Oct 2001 19:57:50 -0400
Date: Thu, 11 Oct 2001 16:57:34 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Export objs from an external Makefile?
Message-ID: <20011011165734.C21564@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20011011093532.K12016@cpe-24-221-152-185.az.sprintbbd.net> <32224.1002843725@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32224.1002843725@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2001 at 09:42:05AM +1000, Keith Owens wrote:
> On Thu, 11 Oct 2001 09:35:32 -0700, 
> Tom Rini <trini@kernel.crashing.org> wrote:
> >Hey all.  How do you do the 'export-objs' bits in a kernel module that's
> >outside of the kernel?  Thanks..
> 
> Compile with -DMODULE -DEXPORT_SYMTAB.  If the kernel has modversions,
> add -DMODVERSIONS -include $(HPATH)/linux/modversions.h.  The safest
> way is to compile a module in the kernel that exports the objects then
> copy the command, substituting the file names.

I think I managed to get things right.  I added -DEXPORT_SYMTAB to the
default flags and added:
CFLAGS_EXTRA	+= $(shell if [ -f $(KERNEL_HEADERS)/linux/modversions.h ]; \
			then echo -include \
			$(KERNEL_HEADERS)/linux/modversions.h; fi)
 
Thanks!

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
