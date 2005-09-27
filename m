Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbVI0OEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbVI0OEW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 10:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbVI0OEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 10:04:22 -0400
Received: from nproxy.gmail.com ([64.233.182.201]:40325 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750826AbVI0OEV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 10:04:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sZct2Wgv6HpfwWMJDQjEQkDHWxfL5KdAIrpYaLZ4HWh0DBqbrBN3eV+8ybD+jNMXsCL0ki1IuGR6zDQQ8dVpSeS8abarOyRtJG/8Pq3iYSIXszp2Y3lC/GNgLEH7uY7aH5KOKB0WQUNdgytXw38TWhBq/Z9lvT8cfMKeBhEpWmM=
Message-ID: <58cb370e0509270704191629fb@mail.gmail.com>
Date: Tue, 27 Sep 2005 16:04:20 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Adeshara Tushar <adesharatushar@yahoo.com>
Subject: Re: usage count in device driver and concurrency
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050830142214.72958.qmail@web51802.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050830142214.72958.qmail@web51802.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/05, Adeshara Tushar <adesharatushar@yahoo.com> wrote:
> Hi,
> I am wondering how to handle device usage count in
> open and release call of device driver if hardware
> need to be initialized on first open and shutdown on
> last close. I have seen som code like
>
> int open()
> {
>         /*some code*/
>         device->usage++;
>         if(device->usage==1)
>                 init_hardware();
>         /*rest of code*/
> }
> void release ()
> {
>         /*some code*/
>         if(device->usage==1)
>                 shutdown_hardware();
>         device->usage--;
>         /*rest of code*/
> }
>
>
>
> However, it seems to me that this code can make
> problem.
> If device->usage=0, and two process A,B execute line
>         device->usage++;
> concurretly, device->usage will become 2 when they
> come to next line. This will result in hardware being
> used without initialization. Same things can happen in
> release call also, which will result in no shutdown of
> hardware.
>                I have seen this type of code in
>         /linux-2.6.8/drivers/ide/ide-disk.c and
>         /linux-2.6.8/drivers/ide/ide-floppy.c
>
>     Please let me know if its bug or not before I
> start working on patches.

Not a bug: ->open() and ->release() for block devices
are never called concurrently (because of bdev->bd_sem).

Bartlomiej
