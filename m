Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263484AbTCNU1k>; Fri, 14 Mar 2003 15:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263488AbTCNU1k>; Fri, 14 Mar 2003 15:27:40 -0500
Received: from zeke.inet.com ([199.171.211.198]:35216 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S263484AbTCNU1i>;
	Fri, 14 Mar 2003 15:27:38 -0500
Message-ID: <3E723DBF.6040304@inet.com>
Date: Fri, 14 Mar 2003 14:38:23 -0600
From: Eli Carter <eli.carter@inet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.64-mm6
References: <20030313032615.7ca491d6.akpm@digeo.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.64/2.5.64-mm6/
[snip]
> kgdb.patch

I'm interested in this patch in your tree.  (Just to warn you of my 
biases, I'm currently working with the XScale/ARM arch.)  I've noticed 
some things about it in an initial look, namely:

There appears to be some code duplication between hex() and stubhex() in 
arch/i386/kernel/gdbstub.c.

Also, the bulk of gdbstub.c appears to be generic code.  There are a 
number of functions that have x86 asm in them, but it looks to me on 
initial viewing, that most of the logic is applicable to other arches. 
Am I understanding that correctly?
Right now it looks like an arch would need to provide a way to:
- reboot the processor
- implement 'continue at address' and 'step one instruction from address'
- handle_exeption()
- printexception()
- correct_hw_break()
- regs_to_gdb_regs() and gdb_regs_to_regs()
     Hmm, there's probably some more to that part...
The above is just for the gdbstub.c.  I'm still reading the patch. :)

Would breaking the arch-independent parts out to linux/kernel/gdbstub.c 
be a reasonable change or is that a dumb question? ;)

Thanks,

Eli
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------

