Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319395AbSILBKS>; Wed, 11 Sep 2002 21:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319396AbSILBKS>; Wed, 11 Sep 2002 21:10:18 -0400
Received: from quechua.inka.de ([212.227.14.2]:16480 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S319395AbSILBKS>;
	Wed, 11 Sep 2002 21:10:18 -0400
From: Bernd Eckenfels <ecki-news2002-09@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Multi-path IO in 2.5/2.6 ?
In-Reply-To: <20020911195232.GH1212@marowsky-bree.de>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E17pIZX-0001HF-00@sites.inka.de>
Date: Thu, 12 Sep 2002 03:15:07 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020911195232.GH1212@marowsky-bree.de> you wrote:
>> I've been think about this separately.  FC in particular needs some type of
>> event notification API (something like "I've just seen this disk" or "my
>> loop just went down").  I'd like to leverage a mid-layer api into hot plug
>> for some of this, but I don't have the details worked out.

> This isn't just FC, but also dasd on S/390. Potentially also network block
> devices, which can notice a link down.

It is true for every device. Starting from a IDE Disk which can fail to a
SCSI DEvice, to a network link, even hot Plug-PCI Cards and CPUs, RAM
Modules and so on can use this API.

Recovering from an ahardware failure is a major weakness of non-host
operating systems. Linux Filesystems used to panic much too often. It is
getting better, but it is still a long way to allow multipath IO, especially
in environemnts where it is more complicated than a faild FC loop. For
example 2 FC adapters on 2 different PCI bus should be able to deactivate
themself if IO with the adapter locks.

> I vote for exposing the path via driverfs (which, I think, is already
> concensus so the multipath group, topology etc can be used) and allowing
> user-space to reenable them after doing whatever probing deemed necessary.

There are situations where a path is reenabled by the kernel, for example
network interfaces. But it makes sence in a HA environemnt to move this to a
user mode daemon, simply because the additional stability is worth the extra
daemon. On the other hand, kernel might need to detect congestion/jam
anyway, especially if load balancing is used.

Personally I like the simple md approach for IO Multipath, as long as not
the whole kernel is able to operate sanely with changing hardware topology.

This is especially less intrusiver to all the drivers out there. And allows
funny combinations like SAN with NAS Backups.

Greetings
Bernd
