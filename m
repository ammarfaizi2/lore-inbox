Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129047AbQKOBZZ>; Tue, 14 Nov 2000 20:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129230AbQKOBZQ>; Tue, 14 Nov 2000 20:25:16 -0500
Received: from stm.lbl.gov ([131.243.16.51]:25099 "EHLO stm.lbl.gov")
	by vger.kernel.org with ESMTP id <S129047AbQKOBZJ>;
	Tue, 14 Nov 2000 20:25:09 -0500
Date: Tue, 14 Nov 2000 16:41:48 -0800
To: Timur Tabi <ttabi@interactivesi.com>
Cc: Keith Owens <kaos@ocs.com.au>,
        Linux Kernel Mailing list <linux-kernel@vger.kernel.org>
Subject: Re: "couldn't find the kernel version the module was compiled for" - help!
Message-ID: <20001114164148.A13061@stm.lbl.gov>
Reply-To: David Schleef <ds@schleef.org>
In-Reply-To: <12388.974245302@ocs3.ocs-net> <20001115001445Z129170-521+233@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001115001445Z129170-521+233@vger.kernel.org>; from ttabi@interactivesi.com on Tue, Nov 14, 2000 at 05:44:42PM -0600
From: David Schleef <ds@stm.lbl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2000 at 05:44:42PM -0600, Timur Tabi wrote:
> ** Reply to message from Keith Owens <kaos@ocs.com.au> on Wed, 15 Nov 2000
> 10:41:42 +1100
> 
> 
> > __NO_VERSION__ must be defined before #include <module.h>.  
> 
> It is:
> 
> #ifdef LINUX
> #ifndef __ENTRY_C__
> #define __NO_VERSION__
> #endif
> #include <linux/version.h>
> #include <linux/module.h>
> #include <linux/kernel.h>
> #include <linux/types.h>
> 
> >Do it by hand.
> 
> I don't know what you mean by that.
> 


Module source should look like this:

  single .c -> single .o

    #include <linux/kernel.h>
    #include <linux/module.h>

  multiple .c -> single .o, main .c file (contains init_module(), etc.)

    #include <linux/kernel.h>
    #include <linux/module.h>

  multiple .c -> single .o, secondary .c file

    #include <linux/kernel.h>

  multiple .c -> single .o, secondary .c file that requires module.h
  for a particular purpose, such as EXPORT_SYMBOL()

    #define __NO_VERSION__
    #include <linux/kernel.h>
    #include <linux/module.h>

Note that in most cases, you _don't_ need to include module.h.

Your Makefile should call gcc with '-D__KERNEL__ -DMODULE', as well
as other approprate flags.




dave...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
