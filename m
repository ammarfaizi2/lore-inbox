Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263930AbTHBNKa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 09:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263952AbTHBNKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 09:10:30 -0400
Received: from smtp-out6.blueyonder.co.uk ([195.188.213.9]:23337 "EHLO
	smtp-out6.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S263930AbTHBNK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 09:10:27 -0400
Message-ID: <3F2BB840.9060205@cn.stir.ac.uk>
Date: Sat, 02 Aug 2003 14:10:24 +0100
From: Bernd Porr <Bernd.Porr@cn.stir.ac.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: linux-kernel@vger.kernel.org, comedi@comedi.org
Subject: Re: compiling external kernel modules (comedi.org)
References: <3F2B0E06.9000907@cn.stir.ac.uk> <20030802070422.GA2404@mars.ravnborg.org> <3F2BA623.6030906@cn.stir.ac.uk> <20030802120756.GA964@mars.ravnborg.org>
In-Reply-To: <20030802120756.GA964@mars.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Aug 2003 13:10:25.0867 (UTC) FILETIME=[702D01B0:01C358F7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam,

how can I include the "legal way" includes for comedi? Just now comedi 
has set up a "linux/include" path in its directory but I think this not 
the elegant way and it also dosn't work right now.

snoopy:/home/bp1/c/usb/2.6/comedi/comedi# make -C 
/usr/src/linux-2.6.0-test2 SUBDIRS=$PWD V=1 modules
make: Entering directory `/usr/src/linux-2.6.0-test2'
make -f scripts/Makefile.build obj=scripts
make -f scripts/Makefile.build obj=arch/i386/kernel 
arch/i386/kernel/asm-offsets.s
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
*** Warning: Overriding SUBDIRS on the command line can cause
***          inconsistencies
mkdir -p .tmp_versions
make -f scripts/Makefile.build obj=/home/bp1/c/usb/2.6/comedi/comedi
  gcc -Wp,-MD,/home/bp1/c/usb/2.6/comedi/comedi/.comedi_fops.o.d 
-D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=athlon -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix 
include -DMODULE   -DKBUILD_BASENAME=comedi_fops 
-DKBUILD_MODNAME=comedi_fops -c -o 
/home/bp1/c/usb/2.6/comedi/comedi/comedi_fops.o 
/home/bp1/c/usb/2.6/comedi/comedi/comedi_fops.c
/home/bp1/c/usb/2.6/comedi/comedi/comedi_fops.c:42:29: 
linux/comedidev.h: No such file or directory

/Bernd
P.S.: I'm subscribed...

Sam Ravnborg wrote:

>On Sat, Aug 02, 2003 at 12:53:07PM +0100, Bernd Porr wrote:
>  
>
>>Ok. Thanks. Now the bug is that comedi cannot find the file "Rules.make" 
>>which is apparently no longer there in 2.6. Is it right that the rules 
>>are now integrated in the corresponding makefiles?
>>    
>>
>
>The way to find the Makefiles changed during the 2.5 development
>cycle. Now the kbuild Makefile (the one for comedi for example) are
>included from scripts/Makfile.build hereby obsoleting Rules.make.
>
>You will NOT succeed creating a single simple makefile supporting both
>2.4 and 2.6. On the other hand the Makefile are so trivial that creating
>two distinct version should be acceptable?
>
>  
>
>>Can you recommend me a Makefile which I can take as a template? Comedi 
>>uses some sort of autoconfig and I have to append then the "rules" to 
>>the automatically generated makefile.
>>    
>>
>
>The most simple Makefile looks like this:
>
>obj-m := comedi.o
>
>No more is actually needed.
>You should get rid of export-objs as well - they are also obsoleted
>in 2.5/2.6.
>
>
>  
>
>>Another thing: can a prevent the kernel of generating the "Stage 2"? It 
>>would be nice if the kernel doen't need to write to it's own directories 
>>if it compiles external modules.
>>    
>>
>
>The right fix is to allow you to build a kernel in a directory
>separate from the kernel src. This is WIP - hopefully included in 
>mainline within a few weeks.
>
>PS. Please do not cc: subscription only mailing lists.
>
>	Sam
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>

-- 
http://www.cn.stir.ac.uk/~bp1/
mailto:bp1@cn.stir.ac.uk



