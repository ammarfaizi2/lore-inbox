Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277119AbRJLAOi>; Thu, 11 Oct 2001 20:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277129AbRJLAO2>; Thu, 11 Oct 2001 20:14:28 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:38667 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S277119AbRJLAOR>;
	Thu, 11 Oct 2001 20:14:17 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Tom Rini <trini@kernel.crashing.org>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Export objs from an external Makefile? 
In-Reply-To: Your message of "Thu, 11 Oct 2001 16:57:34 MST."
             <20011011165734.C21564@cpe-24-221-152-185.az.sprintbbd.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 12 Oct 2001 10:14:38 +1000
Message-ID: <32699.1002845678@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Oct 2001 16:57:34 -0700, 
Tom Rini <trini@kernel.crashing.org> wrote:
>On Fri, Oct 12, 2001 at 09:42:05AM +1000, Keith Owens wrote:
>> On Thu, 11 Oct 2001 09:35:32 -0700, 
>> Tom Rini <trini@kernel.crashing.org> wrote:
>> >Hey all.  How do you do the 'export-objs' bits in a kernel module that's
>> >outside of the kernel?  Thanks..
>> 
>> Compile with -DMODULE -DEXPORT_SYMTAB.  If the kernel has modversions,
>> add -DMODVERSIONS -include $(HPATH)/linux/modversions.h.  The safest
>> way is to compile a module in the kernel that exports the objects then
>> copy the command, substituting the file names.
>
>I think I managed to get things right.  I added -DEXPORT_SYMTAB to the
>default flags and added:
>CFLAGS_EXTRA	+= $(shell if [ -f $(KERNEL_HEADERS)/linux/modversions.h ]; \
>			then echo -include \
>			$(KERNEL_HEADERS)/linux/modversions.h; fi)

You need -DMODVERSIONS as well.

Testing for the presence of modversions.h will not work in kbuild 2.5,
that file is always created with error messages to catch people who
include it "by hand".  OTOH, kbuild 2.5 has support for compiling
outside the standard kernel tree so who cares :)?

