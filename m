Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264066AbTFHXve (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 19:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264080AbTFHXve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 19:51:34 -0400
Received: from codepoet.org ([166.70.99.138]:32726 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S264066AbTFHXvd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 19:51:33 -0400
Date: Sun, 8 Jun 2003 18:05:13 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Peter Westwood <peter.westwood@talk21.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linksys WRT54G and the GPL
Message-ID: <20030609000513.GA11177@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Peter Westwood <peter.westwood@talk21.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, Jun 08 2003, 15:57:04 EST, Peter Westwood wrote:
> 
> Hi All,
> 
> In a similar vein to the Linksys router.  I have a Buffalo (Melco) WBR-G54.
> 
> Looking through the latest firmware update available :
> http://www.buffalo-technology.com/support/firmware.htm
> 
> It does appear to be similar to the Linksys firmware and contain linux and
> possibly busybox
> 
> No mention here or anywhere on there site of the GPL or the source code to
> what they are distributing!

Wow, thanks for the pointer!  I just visited the Buffalo site 
    http://www.buffalo-technology.com/
and I could not find any source code.  And not only are they
distributing the linux kernel and BusyBox, their rom is
_remarkably_ similar to the Linksys one in many respects.
Perhaps they share an upstream vendor that did not make them
aware of their responsibilities?

Here is a script I just whipped up to open up their firmware...

    #!/bin/sh

    wget http://www.buffalo-technology.com/download/firmware/wbr-113b.exe

    # Next I used wine (20030408) to extract the content
    wine wbr-113b.exe

    # Move into the directory into which the firmware was extracted
    cd Wbr_1.13b

    # I noticed a GZIP signature for a file named "piggy" at offset
    # 62 bytes from the start, suggesting we have a compressed Linux
    # kernel
    dd if=wbrbg-113b bs=62 skip=1 | zcat > kernel

    # Noticed there was a cramfs magic signature at offset 786466
    dd if=wbrbg-113b of=cramfs.image bs=786466 skip=1
    file cramfs.image

    sudo mount -o loop,ro -t cramfs ./cramfs.image /mnt 
    ls -la /mnt/bin
    file /mnt/bin/busybox
    strings /mnt/bin/busybox | grep BusyBox
    /usr/i386-linux-uclibc/bin/i386-uclibc-ldd /mnt/bin/busybox

It seems my Dad will have another letter to mail out in the
morning!

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
