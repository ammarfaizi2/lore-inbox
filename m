Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263452AbTCNRvO>; Fri, 14 Mar 2003 12:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263453AbTCNRvO>; Fri, 14 Mar 2003 12:51:14 -0500
Received: from air-2.osdl.org ([65.172.181.6]:58348 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S263452AbTCNRvM>;
	Fri, 14 Mar 2003 12:51:12 -0500
Date: Fri, 14 Mar 2003 09:59:06 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: joern@wohnheim.fh-wedel.de, alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Top stack (l)users for 2.5.64-ac4
Message-Id: <20030314095906.20a270cb.rddunlap@osdl.org>
In-Reply-To: <20030314174154.GX791@suse.de>
References: <200303141509.h2EF9R017016@devserv.devel.redhat.com>
	<20030314172820.GH23161@wohnheim.fh-wedel.de>
	<20030314174154.GX791@suse.de>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Mar 2003 18:41:54 +0100 Jens Axboe <axboe@suse.de> wrote:

| On Fri, Mar 14 2003, Joern Engel wrote:
| > Hi!
| > 
| > 47 functions using >=1k of kernel stack on i386.
| > 
| > One improvement over 2.5.64, i2o_proc_* is gone. 4 down, 47 to go. :)
| > 
| > 0xc02063f6 presto_get_fileid:                            sub    $0x1168,%esp
| > 0xc0204fc6 presto_copy_kml_tail:                         sub    $0x101c,%esp
| > 0xc07b92c8 isp2x00_make_portdb:                          sub    $0xc38,%esp
| > 0xc0879c05 cdromread:                                    sub    $0xa84,%esp
| 
| which function is this (cdromread)?

must be drivers/cdrom/optcd.c::cdromread() (line 1601 in 2.5.64),
due to
	char buf[CD_FRAMESIZE_RAWER];
and
#define CD_FRAMESIZE_RAWER 2646 /* The maximum possible returned bytes */ 
in include/linux/cdrom.h.

--
~Randy
