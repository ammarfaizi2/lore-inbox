Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265931AbUHANNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265931AbUHANNq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 09:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265932AbUHANNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 09:13:45 -0400
Received: from chaos.analogic.com ([204.178.40.224]:58757 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265931AbUHANNn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 09:13:43 -0400
Date: Sun, 1 Aug 2004 09:10:23 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Thomas S. Iversen" <zensonic@zensonic.dk>
cc: linux-kernel@vger.kernel.org
Subject: Re: How to do IO across hardsector boundries
In-Reply-To: <410C37B7.3010504@zensonic.dk>
Message-ID: <Pine.LNX.4.53.0408010903020.16215@chaos>
References: <410C37B7.3010504@zensonic.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Aug 2004, Thomas S. Iversen wrote:

> Hi There
>
> As part of an assignment I am trying to port a piece of software from
> FreeBSD to linux. Essentially this software (crypto) makes a virtual
> blockdevice with "virtual" sectors on top. Under FreeBSD these virtual
> sectors are just read/written using a simple command:
>
> buf=g_read(dev, offset, len)
> error=g_write(dev,offset,buf,len)
>
> In linux however I have only seen the BIO layer which operates on IO on
> hardsector boundaries.
>
> So my question really is, how do I go about updating for instance the
> 512 bytes located for at byte 64 to 64+511 on the actual media without
> getting in trouble regarding the data from offset 0-63 and 64+512->1023?
>
> Regards Thomas

There are no hard-sector boundaries in Linux. The geometry of a drive
is really ignored. It's just used to determine the size of a disk
partition, etc. The stated Heads/cylinders/sectors is a throw-back
to the old int 0x13, DOS days where stuff had to fit into registers
for access.

If your driver expects to write physical sectors, it's broken.
Even physical sectors (on the media) don't really exist anymore.
They are now "logical" sectors and they are never really accessed
as a single unit (except in floppies). They are "extracted" from a
sector-buffer that could contain nearly a whole track.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


