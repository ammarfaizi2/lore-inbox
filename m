Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261508AbSIXBCy>; Mon, 23 Sep 2002 21:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261512AbSIXBCy>; Mon, 23 Sep 2002 21:02:54 -0400
Received: from packet.digeo.com ([12.110.80.53]:14486 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261508AbSIXBCx>;
	Mon, 23 Sep 2002 21:02:53 -0400
Message-ID: <3D8FBAEF.3D8BDF6F@digeo.com>
Date: Mon, 23 Sep 2002 18:07:59 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Bjoern A. Zeeb" <bzeeb-lists@lists.zabbadoz.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5-bk oops in vsnprintf/scsi_mod
References: <Pine.BSF.4.44.0209240140020.13460-100000@e0-0.zab2.int.zabbadoz.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Sep 2002 01:08:00.0150 (UTC) FILETIME=[D33B7B60:01C26366]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Bjoern A. Zeeb" wrote:
> 
> Hi,
> 
> got this one :(
> 
> bk pull from linux-20020923-211332 UTC
> 
> Linux megablast 2.5.38 #52 SMP Mon Sep 23 21:52:55 UTC 2002 i686 unknown
> gcc version 3.2
> binutils-2.13.90.0.4
> 
> could be related to sym53c416 module re-loading (after cli() removal; see
> diff I posted some minutes ago). Seems the driver needs more cleanup ...
> 

Well that driver seems to do a request_irq() with no corresponding
free_irq().  If that's the case (ie: if the free_irq isn't performed
in some driver support code) then yup, it will cause an oops in
show_interrupts() after module unload.
