Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbULHV2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbULHV2I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 16:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbULHV14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 16:27:56 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:47409 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261364AbULHV1m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 16:27:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=q6Amg4wGpPn0WSRoIaR7rLSxYZTdpRY8n3XNaE4WYZY0iXMXdb0tOd7y9B3pDJUfRLTjxow5oq0pe6Y7b5wJJ6mmtGUvZVsJaRevuNYveVlASE7PCTPyj3/eO9FaIanBG4Dee0bO7Yo7Oo7duiKjO166B7PLfhCFJRZKbFci3O4=
Message-ID: <8e93903b041208132573a3c118@mail.gmail.com>
Date: Wed, 8 Dec 2004 21:25:56 +0000
From: Alan Pope <alan.pope@gmail.com>
Reply-To: Alan Pope <alan.pope@gmail.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: PDC202XX_OLD broken
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andre Hedrick <andre@linux-ide.org>
In-Reply-To: <58cb370e041207125864b97eea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <8e93903b041206140529a8baa9@mail.gmail.com>
	 <1102425655.17950.21.camel@localhost.localdomain>
	 <58cb370e041207125864b97eea@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Dec 2004 21:58:52 +0100, Bartlomiej Zolnierkiewicz
<bzolnier@gmail.com> wrote:
> You are using 40c cable instead of 80c one.
> Thus transfer rate is limited to UDMA33.
> 

No, I'm using an 80c cable. I have even gone out and bought a new 80c
one just to make sure the cable isn't broken. I have also got two
identical disks, and experience exactly the same problem on both.

I booted with "ide2=dma" because it was booting with the disk in pio mode.

> Moreover pdc202xx_old has a bug in cable detection code.
> pdc202xx_old_cable_detect() always returns '0' (which means
> 80c cable) due to a sloppy coding - result of CIS & mask is
> truncated to 8 bits although CIS holds cable info in bits 10-11.
> 
> Does this fix work for you?
> 

Not tried it, but it wouldn't help me would it? I *do* have an 80c
cable, and the disk does show up in dmesg as a UDMA100 disk..

This is what happens when I thrash it, note my /home/alan is on
another non-UDMA100 disk on a separate controller.

# time cp -Rvp /home/alan/* temp

ide: failed opcode was: unknown
hde: DMA disabled
PDC202XX: Primary channel reset.
PDC202XX: Secondary channel reset.

(then lots of these)
 
end_request: I/O error, dev hde, sector 145225487
end_request: I/O error, dev hde, sector 145225495
end_request: I/O error, dev hde, sector 145225503
end_request: I/O error, dev hde, sector 145225511
end_request: I/O error, dev hde, sector 145225519
end_request: I/O error, dev hde, sector 145225527
end_request: I/O error, dev hde, sector 145225535

EXT3-fs error (device hde1) in ext3_prepare_write: IO failure
EXT3-fs error (device hde1) in start_transaction: Journal has aborted

printk: 2018 messages suppressed.
Buffer I/O error on device hde1, logical block 5
lost page write due to I/O error on hde1
end_request: I/O error, dev hde, sector 183


Any ideas?
Cheers,
Al.
