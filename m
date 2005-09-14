Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030262AbVINQhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030262AbVINQhU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 12:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030263AbVINQhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 12:37:20 -0400
Received: from EXCHG2003.microtech-ks.com ([65.16.27.37]:23891 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S1030262AbVINQhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 12:37:19 -0400
From: "Roger Heflin" <rheflin@atipa.com>
To: "'David Sanchez'" <david.sanchez@lexbox.fr>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Corrupted file on a copy
Date: Wed, 14 Sep 2005 11:41:50 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcW5Ob/Ex6T+dbCAQNuBsgivuB/7TQADY0Qw
In-Reply-To: <Pine.LNX.4.61.0509141033580.17510@chaos.analogic.com>
Message-ID: <EXCHG2003Rf3sllNY3000000791@EXCHG2003.microtech-ks.com>
X-OriginalArrivalTime: 14 Sep 2005 16:33:41.0428 (UTC) FILETIME=[11066F40:01C5B94A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
> linux-os (Dick Johnson)
> Sent: Wednesday, September 14, 2005 9:37 AM
> To: David Sanchez
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Corrupted file on a copy
> 
> 
> On Wed, 14 Sep 2005, David Sanchez wrote:
> 
> > Hi,
> >
> > I'm using the linux kernel 2.6.10 and busybox 1.0 on a AMD 
> AU1550 board.
> >
> > When I copy a big file (around 300M) within an ext2 
> filesystem (even 
> > on
> > ext3 filesystem) then the output file is sometime 
> "corrupted" (I mean 
> > that the source and the destination files are different and thus 
> > generate a different SHA1).
> > Does somebody have a same behaviour?
> >
> > Thanks,
> > David
> >
> 
> Use `cmp` to compare the two files. You could have discovered 
> a bug in your checksum utility, you need to isolate it to the 
> file-system. FYI, I have never seen a copy of a file, 
> including the image of an entire DVD (saved to clone 
> another), that was not properly identical.
> 

I have seen 2 similar issues.   Both where bad hardware of completely
different configurations (nothing at all in common, and completely
different machines).

Both would corrupt data on a read (we never found a corrupted
write).   One had a MTBF of 3 GB, and the other about 5GB, and if
you say made 200 50mb files (or however many you need to bust your
disk cache) , and do a checksum on all of them, the
checksum will be wrong on 1 or 2 of them each pass, and each pass
different files will be wrong (once you get all of the original
ones right on disk).  

Both were fixed by replacing the proper piece of hardware by a replacement
card, or by slowing down the pci bus one step to something that did not get
corruption.   In the second case both the card and the motherboard 
were rated for the speed that was getting corruption, and this problem
was duplicated with 2 different mb's of the same kind and 3 different 
pci cards, 1 of them being a completely different companies PCI card that
also
did not like the motherboard, but locked up linux rather than corrupted
data.

                           Roger

