Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbVIOKE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbVIOKE3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 06:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932441AbVIOKE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 06:04:28 -0400
Received: from laf31-5-82-235-130-100.fbx.proxad.net ([82.235.130.100]:30202
	"EHLO lexbox.fr") by vger.kernel.org with ESMTP id S932434AbVIOKE2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 06:04:28 -0400
Subject: RE: Corrupted file on a copy
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Date: Thu, 15 Sep 2005 12:01:50 +0200
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Message-ID: <17AB476A04B7C842887E0EB1F268111E026FA1@xpserver.intra.lexbox.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Corrupted file on a copy
thread-index: AcW5Ob/Ex6T+dbCAQNuBsgivuB/7TQADY0QwACRdHMA=
From: "David Sanchez" <david.sanchez@lexbox.fr>
To: "Roger Heflin" <rheflin@atipa.com>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My investigation leads me to suspect the read operation.
I divide the CPU frequency by two and the problem no more occurred!

I carry on my investigation...

Thanks,


David SANCHEZ
LexBox :: The Digital Evidence 
3, avenue Didier Daurat
31400 TOULOUSE / FRANCE
david.sanchez@lexbox.fr
Tel :  +33 (0)5 62 47 15 81
Fax : +33 (0)5 62 47 15 84

-----Message d'origine-----
De : linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org] De la part de Roger Heflin
Envoyé : mercredi 14 septembre 2005 18:46
À : David Sanchez
Cc : linux-kernel@vger.kernel.org
Objet : RE: Corrupted file on a copy

 

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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/





