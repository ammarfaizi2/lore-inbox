Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315779AbSHIU7L>; Fri, 9 Aug 2002 16:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315925AbSHIU7L>; Fri, 9 Aug 2002 16:59:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11785 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315779AbSHIU7K>;
	Fri, 9 Aug 2002 16:59:10 -0400
Message-ID: <3D542D75.7FEA9DDF@zip.com.au>
Date: Fri, 09 Aug 2002 14:00:37 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Badari Pulavarty <pbadari@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at /usr/src/linux-2.5.30/include/linux/dcache.h:261!
References: <200208091732.g79HW4q02868@eng2.beaverton.ibm.com> <3D542C06.50008@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> 
> Badari Pulavarty wrote:
> > Code;  c0160d0f <d_unhash+f/70>   <=====
> >    0:   0f 0b                     ud2a      <=====
> > Code;  c0160d11 <d_unhash+11/70>
> >    2:   05 01 00 db 2a            add    $0x2adb0001,%eax
> > Code;  c0160d16 <d_unhash+16/70>
> >    7:   c0                        (bad)
> 
> Doesn't that (bad) instruction look suspicious?  Martin was seeing
> strange oopses on Hummer (16-way NUMA-Q) compiling with egcs 2.91
> because it was generating bad instructions.  It may be another
> problem, but that c0 jumped out at me.  The two instructions after it
> look bretty bogus too.

We're encoding the file-and-line information in the program text
immediately after the undefined opcode, so you'll always see junk
in there.  Sorry.

It would be much more useful if the oops code were to dump the
text preceding the exception EIP rather than after it, actually.
I think Keith said that ksymoops supports that.
