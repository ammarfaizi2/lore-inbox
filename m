Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261377AbULET7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbULET7w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 14:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261370AbULET7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 14:59:52 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:24511 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261377AbULET7k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 14:59:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=DnwM5J2parK7Jjhi7t34/sL9VDRT3GyGyPQHfJYlWX6Nit9R71q8eI7zdpqrBT8uNXQT/2ITB/CZyPnMGXSXAnrYBoeptAL2+9+zJKI9muoJ3VAg6cRMAlgviKnaQ0KVvivH9BiOEYbsYIcjMbxLHyX8XGmp+/bpt59EeV5bTvw=
Message-ID: <8e93903b041205115957fc@mail.gmail.com>
Date: Sun, 5 Dec 2004 19:59:29 +0000
From: Alan Pope <alan.pope@gmail.com>
Reply-To: Alan Pope <alan.pope@gmail.com>
To: lkml@think-future.de, Linux Kernel-Liste <linux-kernel@vger.kernel.org>
Subject: Re: Promise module (old) broken
In-Reply-To: <20041205195358.DC2B5440E2@service.i-think-future.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041205195358.DC2B5440E2@service.i-think-future.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Dec 2004 18:54:00 +0100, lkml@think-future.de
<lkml@think-future.de> wrote:
>   Hi,
> 
>   up to the actual kernel rc 2.6.10rc3 has broken pdc 20265 support. As
> some kernel releases ago, one had to specify i/o ports on kernel
> cmdline. 2.4.28 kernel works w/o cmdline parameter.
> 
> Is this behaviour intended? Will it be fixed in 2.6.10 release?
> 
> W/o parameter kernel (2.6) does not recognise the pdc ide controller
> drives.
> dmesg output states: "ideX: Wait for ready failed before probe !"
> 
> As of kernel rc 2.6.10rc1 the kernel even reported ide drive short
> read and seek errors on drives even not connected to the pdc
> controller but connected to the onboard controller (->/dev/hda1). In
> fact /dev/hda1 has no errors (so far).
> 
> Any comments?
> 

It's more broken than that here. I get the following errors in 2.6.8
through 2.6.9-ac9 & 2.6.10-rc2 with the old (PDC202XX_OLD) promise
driver, when placing the disk/controller under any load (in fact just
doing hdparm -t -T /dev/hde).

I get..

hde: dma_intr: status=0xff { Busy }

ide: failed opcode was: unknown
hde: DMA disabled
PDC202XX: Primary channel reset.
PDC202XX: Secondary channel reset.

(a number of times)

ide2: reset timed-out, status=0xff
end_request: I/O error, dev hde, sector 11776
Buffer I/O error on device hde, logical block 1472

(many times)

Cheers,
Al.
