Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263540AbUDMQfo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 12:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263544AbUDMQfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 12:35:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24247 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263540AbUDMQfg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 12:35:36 -0400
Message-ID: <407C16CA.6010503@pobox.com>
Date: Tue, 13 Apr 2004 12:35:22 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 427] Amiga Zorro8390 Ethernet section conflict
References: <200404130838.i3D8c6pa018442@callisto.of.borg>
In-Reply-To: <200404130838.i3D8c6pa018442@callisto.of.borg>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven wrote:
> Zorro8390: const data cannot be in the init data section (from Roman Zippel)

ACK, but this patch highlights a bug:

one is __initdata:

	static const struct card_info {
	    zorro_id id;
	    const char *name;
	    unsigned int offset;
	} cards[] __initdata = {

and the lone caller is __devinit:

static int __devinit zorro8390_init_one(struct zorro_dev *z,
                                       const struct zorro_device_id *ent)

