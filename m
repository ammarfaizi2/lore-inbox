Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286478AbSABBEa>; Tue, 1 Jan 2002 20:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286488AbSABBEV>; Tue, 1 Jan 2002 20:04:21 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15878 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286468AbSABBEJ>; Tue, 1 Jan 2002 20:04:09 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: lilo, initrd and RAM > 1GB
Date: 1 Jan 2002 17:03:43 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a0tm9f$e8p$1@cesium.transmeta.com>
In-Reply-To: <3C2F66FF.13BD2A19@xss.co.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3C2F66FF.13BD2A19@xss.co.at>
By author:    Andreas Haumer <andreas@xss.co.at>
In newsgroup: linux.dev.kernel
> 
> To me it looks like lilo get's the initrd start address
> wrong if there is more than 1GB of RAM in the system.
> I haven't found anything in the lilo documentation how to 
> solve this problem. 
> 

The initrd end address should be obtained via the following algorithm:

        # high_addr here is the highest byte that can be occupied by
        # the initrd

	if ( bootproto >= 0x203 ) {
	   high_addr := header->ramdisk_max
        } else {
           high_addr := 0x37ffffff
        }

        high_addr := min(memsize-1, high_addr)


The "magic constant" 0x37ffffff was widely believed to have been
0x3bffffff (which it might have originally been); this value, however,
doesn't work with most kernels.

This is why the ramdisk ceiling needs to be explicitly reported by the
kernel, as is done in the 2.03 boot protocol.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
