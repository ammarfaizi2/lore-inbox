Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbUKEWI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbUKEWI6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 17:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbUKEWI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 17:08:58 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:8714 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S261222AbUKEWIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 17:08:51 -0500
X-BrightmailFiltered: true
Message-Id: <200411052208.ATT88180@mira-sjc5-e.cisco.com>
Reply-To: <hzhong@cisco.com>
From: "Hua Zhong" <hzhong@cisco.com>
To: "'Grzegorz Kulewski'" <kangur@polcom.net>,
       "'Linus Torvalds'" <torvalds@osdl.org>
Cc: "'Chris Wedgwood'" <cw@f00f.org>, "'Andries Brouwer'" <aebr@win.tue.nl>,
       "'Adam Heath'" <doogie@debian.org>,
       "'Christoph Hellwig'" <hch@infradead.org>,
       "'Timothy Miller'" <miller@techsource.com>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: support of older compilers
Date: Fri, 5 Nov 2004 14:08:45 -0800
Organization: Cisco Systems
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <Pine.LNX.4.60.0411052242090.3255@alpha.polcom.net>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4939.300
Thread-Index: AcTDgx7pY6B1GLCKRkamDZmNLdwzygAAJuZA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At least in 2.4.17 I couldn't loopback mount an (ext2) image from tmpfs and
had to use ramfs. Has this been fixed?

> > The kernel does do more these days than it did in '95. But 
> 6 times more? I
> > dunno..
> 
> Can't we remove ramfs for a good start? Everyone should use 
> tmpfs instead 
> and some stupid distributions (I will not tell their names) 
> try to mount 
> ramfs on /dev (udev) and that leads to very stupid panic if you will 
> write for example:
> 
> dd if=/dev/evms/sda5 of=/dev/sda17 bs=1024
> 
> instead of "of=/dev/evms/sda17".
> 
> Explanation (if anybody needs one):
> Kernel can't create more partition devices than 15 for SCSI 
> and SATA disks 
> because of lack of minor numbers. So I am using evms to create these 
> devices. So I should use /dev/evms/sda* for these partitions. 
> And if I 
> will not remember to do so then I will get oom panic very 
> shortly because 
> ramfs is not limited (in contrary to tmpfs).
> 
> And this kind of stupid mistake can happen. It happened to me 
> 3 times in a 
> row before I started to debug what is wrong with this kernel.
> 
> [BTW. Does somebody know how to tell the kernel that I do not want 
> /dev/sda[0-9]* files (but I do want /dev/hda files) created 
> == I do not 
> want kernel partition driver to touch this particular device?]
> 
> And using ramfs for anything else can easily lead to similar 
> problems. So 
> I think we do not need ramfs. Am I wrong? [I understand that 
> removing it 
> will not remove much code.]
> 
> 
> Thanks,
> 
> Grzegorz Kulewski
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

