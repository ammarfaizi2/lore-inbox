Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268565AbUH3RLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268565AbUH3RLT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 13:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268577AbUH3RLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 13:11:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14258 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268565AbUH3RKn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 13:10:43 -0400
Message-ID: <41335F8B.3000207@redhat.com>
Date: Mon, 30 Aug 2004 13:10:35 -0400
From: Neil Horman <nhorman@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0; hi, Mom) Gecko/20020604 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Marc_Str=E4mke?= <marcstraemke.work@gmx.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problem accessing Sandisk CompactFlash Cards (Connected to the
   IDE bus)
References: <cgs2c1$ccg$1@sea.gmane.org> <4131DC5D.8060408@redhat.com> <cgsuq2$7cb$1@sea.gmane.org> <41326FE1.2050508@redhat.com> <20040830010712.GC12313@logos.cnet> <cguj7n$gur$1@sea.gmane.org> <41333879.2040902@redhat.com> <cgvi5l$t0d$1@sea.gmane.org>
In-Reply-To: <cgvi5l$t0d$1@sea.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Strämke wrote:
<snip>
> One thing i did notice when tracing these functions, is that the new 
> card returns 0x44a in drive->id->config, while the old one returns 
> 0x848a, according to the manual from 
> SanDisk(http://www.sandisk.com/pdf/industrial/ProdManualIndustrialGradeATAv2.6.pdf) 
> Should only be returned in memory mapped(cardbus/pc-card) mode, and not 
> in True IDE mode, which the card is appearently running, otherwise the 
> bios couldnt not boot from it, nor would the electrical interface be 
> compatible (if i get the manual right). That is imo why hdparm -I doesnt 
> detect the card as beein removable and Compactflash too, i looked as the 
> sourcode of hdparm, and it seems to read the ATA configuration registers 
> trough a proc file, and interpret it directly (without intervention of 
> the kernel).
> So the data the does return indeed marks it as an ATA harddisk, and not 
> as a compactflash card, the real question then is why doesnt it work as 
> a harddisk, which according to the specifications it should? Iam not 
> really experienced in the ide stuff, so iam not sure what the 
> CompactFlash detection in linux changes in behaviour.
> I can get the kernel to report it as a "CFA DISK Drive" in dmesg by 
> forcing the flags i mentioned before, but the error is exactly the same.
> 
Sorry, I've been mixed up here.  I've been focused on the removable flag 
aspect of this problem.  To level set here:

1) older SanDisk cards are detected as CFA devices and are working, but 
not bootable.

2) newer SanDisk cards are detected as ATA disks, and are bootable as 
such, but do not seem to be operating correctly (the aforementioned ide 
errors).


Is this correct?

The first question to answer is, which mode do you want to operate in? 
(I assume True IDE is what you're after, but just to be sure). 
According to the Manual you provided the link to, CFA cards select which 
mode the operate in (CFA or ATA) from poweron based on a sampling of pin 
0x0E. on the physical interface (from section 3.7 on page 43).   So it 
seems you have two supposedly identical pieces of hardware that are 
configuring themselves from poweron in opposing ways based on the 
electrical characteristics of the same bus pin.  If this is correct, 
then I would be forced to conclude:

a) the state of that bus pin is fluctuating.
b) the CompactFlash cards that you have treat that pin differently

Either way, it seems that you have two cards which should be, but are 
not getting detected/configured in the same way.  That would somewhat 
suggest to me electrical issues on your bus, which may account for the 
ide errors you are seeing.

Neil
> Thx for your help,
> Marc
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
/***************************************************
  *Neil Horman
  *Software Engineer
  *Red Hat, Inc.
  *nhorman@redhat.com
  *gpg keyid: 1024D / 0x92A74FA1
  *http://pgp.mit.edu
  ***************************************************/
