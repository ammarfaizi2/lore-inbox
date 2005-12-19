Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbVLSMkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbVLSMkG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 07:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbVLSMkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 07:40:06 -0500
Received: from nproxy.gmail.com ([64.233.182.193]:60913 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932431AbVLSMkE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 07:40:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=a6eV/h6Mc2VwTfMqpJYyzLq0F35IORLKzH46hZKa5ZCFr8v33nlhGawVs+QcRQ/pk/7Ra1/AJjHOuSBGRNtuOMZ5kmCTpoRzLRStHo26qb/Q6Lvrnw8Hu9wLLRqtqjCVKgBGGkuQh5lwbDMyrdHHAFWX0isp09JXbVkC8KIuZX0=
Message-ID: <58cb370e0512190440p3889a489sbc82f0c482fd9db9@mail.gmail.com>
Date: Mon, 19 Dec 2005 13:40:00 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Clemens Koller <clemens.koller@anagramm.de>
Subject: Re: IDE: PDC20275 turning on/off DMA dangerous?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43A2DE5F.7060108@anagramm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43A2DE5F.7060108@anagramm.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/05, Clemens Koller <clemens.koller@anagramm.de> wrote:
> Hello!

Hi,

> I am working on an embedded ppc (mpc8540) using a pretty common Promise IDE
> PCI controller w/ a PDC20275 on it (it's called Ultra TX2).
> I have an otherwise good Maxtor 6B120P0 (160GB) connected to it.
>
> But sometimes (expecially with more than zero disk-i/o-load), when I
> turn on DMA by
>
> $hdparm -X69 -d1 /dev/hda
> I get
>
> hda: task_out_intr: status=0x58 { DriveReady SeekComplete DataRequest }
> ide: failed opcode was: unknown
> hda: CHECK for good STATUS
>
> And when I turn off DMA with
> $hdparm -d0 /dev/hda
> I get sometimes a
>
> hda: DMA disabled
>
> which is fine but sometimes I also get:
>
> hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> ide: failed opcode was: unknown
> hda: drive not ready for command
> hda: CHECK for good STATUS
>
> which is not so nice.
> Can you tell me if this is dangerous?

Is there any particular reason why you are using hdparm with '-d' and '-X'?

Your IDE host driver (pdc202xx_new in this case) should configure
best xfer mode and enable DMA so you shouldn't need to use hdparm.

Given that IDE driver code for changing xfer mode and DMA setting
is racy and actually quite hard to fix, it will probably be removed in
the future (after auditing IDE host drivers).

BTW please use linux-ide@vger.kernel.org for IDE problems

Thanks,
Bartlomiej
