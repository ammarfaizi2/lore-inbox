Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265841AbTGOJDK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 05:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265911AbTGOJDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 05:03:10 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:33085 "EHLO
	corp.tivoli.com") by vger.kernel.org with ESMTP id S265841AbTGOJDC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 05:03:02 -0400
Message-ID: <3F13C6BA.80102@tiscalinet.it>
Date: Tue, 15 Jul 2003 11:17:46 +0200
From: Koala GNU <koala.gnu@tiscalinet.it>
Reply-To: koala.gnu@tiscalinet.it
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20021120 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Riley Williams <Riley@Williams.Name>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux boot code
References: <BKEGKPICNAKILKJKMHCACEAKEOAA.Riley@Williams.Name>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Riley,

thanks for your reply.

I noticed the native boot code for floppy is not supported any more. In 
fact in the current code display a message and reboot the machine after 
the press of a key.

But I am interested on how the old native boot code worked.

Do you know if there is a particular reason why the boot sector is moved 
to 0x9000:0 (excuse me if I repeat the question, but I need help on this)?

I hope someone else can point me a site where is reported the format of 
the floppy parameter table at address 0x0:0x78.

Thanks in advance and excuse me for this other post.

Riley Williams wrote:

>Hi.
>
> > I am looking at the boot code in bootsect.S and I have some doubt.
> > I tried to search the answers to my questions on
> > marc.theaimsgroup.com and on Google but I haven't found them.
>
>I know nothing about the former site, so can't comment thereon.
>
> > Probably these are newbie question but I'll appreciate if someone
> > of you help me.
>
>I'll do what I can.
>
> > 1) In the bootsect code the first thing that is done is to copy
> >    the boot sector to 0x90000 and move the program count to
> >    0x9000, go. Why it is necessary move the code there? Is it not
> >    possible continue the process from 0x7C00?
>
>Following moving the boot code there, the next step is to load the
>kernel image, either from 0x10000 (64k) or from 1M upwards, this
>being dependent on various factors. However, the boot sector holds
>several flags whose values are important AFTER the kernel image has
>been loaded, so is moved out the way first.
>
> > 2) Another step is to move the parameters table from 0x78:0 to
> >    0x9000:0x4000-12. What are the info contained in this table?
> >    Can you send me a link to a site that specify these info?
> >    Without these info I am not able to understand these three
> >    line of code
> >
> >        movb    $36, 0x4(%di)           # patch sector count
> >        movw    %di, %fs:(%bx)
> >        movw    %es, %fs:2(%bx)
>
>That area of memory contains parameters configured by the BIOS of
>the machine in question. I would suspect it's the parameters for
>the floppy drives, and the code that follows is presumably that
>used to determine how many sectors per track the floppy in /dev/fd0
>actually has.
>
> > Thanks in advance for your help
>
>No problem.
>
>Best wishes from Riley.
>---
> * Nothing as pretty as a smile, nothing as ugly as a frown.
>
>---
>Outgoing mail is certified Virus Free.
>Checked by AVG anti-virus system (http://www.grisoft.com).
>Version: 6.0.500 / Virus Database: 298 - Release Date: 10-Jul-2003
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>


