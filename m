Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263458AbTCNRwe>; Fri, 14 Mar 2003 12:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263459AbTCNRwe>; Fri, 14 Mar 2003 12:52:34 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:23698 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S263458AbTCNRwd>;
	Fri, 14 Mar 2003 12:52:33 -0500
Date: Fri, 14 Mar 2003 19:03:27 +0100
From: Jens Axboe <axboe@suse.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: joern@wohnheim.fh-wedel.de, alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Top stack (l)users for 2.5.64-ac4
Message-ID: <20030314180327.GY791@suse.de>
References: <200303141509.h2EF9R017016@devserv.devel.redhat.com> <20030314172820.GH23161@wohnheim.fh-wedel.de> <20030314174154.GX791@suse.de> <20030314095906.20a270cb.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030314095906.20a270cb.rddunlap@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 14 2003, Randy.Dunlap wrote:
> On Fri, 14 Mar 2003 18:41:54 +0100 Jens Axboe <axboe@suse.de> wrote:
> 
> | On Fri, Mar 14 2003, Joern Engel wrote:
> | > Hi!
> | > 
> | > 47 functions using >=1k of kernel stack on i386.
> | > 
> | > One improvement over 2.5.64, i2o_proc_* is gone. 4 down, 47 to go. :)
> | > 
> | > 0xc02063f6 presto_get_fileid:                            sub    $0x1168,%esp
> | > 0xc0204fc6 presto_copy_kml_tail:                         sub    $0x101c,%esp
> | > 0xc07b92c8 isp2x00_make_portdb:                          sub    $0xc38,%esp
> | > 0xc0879c05 cdromread:                                    sub    $0xa84,%esp
> | 
> | which function is this (cdromread)?
> 
> must be drivers/cdrom/optcd.c::cdromread() (line 1601 in 2.5.64),
> due to
> 	char buf[CD_FRAMESIZE_RAWER];
> and
> #define CD_FRAMESIZE_RAWER 2646 /* The maximum possible returned bytes */ 
> in include/linux/cdrom.h.

Ahh, ok so a lot less interesting. Also why I didn't catch it here. I'd
be inclining to just making buf global there.

-- 
Jens Axboe

