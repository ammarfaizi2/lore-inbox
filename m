Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267383AbTBLQb1>; Wed, 12 Feb 2003 11:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267385AbTBLQb1>; Wed, 12 Feb 2003 11:31:27 -0500
Received: from air-2.osdl.org ([65.172.181.6]:4020 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267383AbTBLQb0>;
	Wed, 12 Feb 2003 11:31:26 -0500
Date: Wed, 12 Feb 2003 08:38:26 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] input: sunkbd.c - fix reading beyond end of keycode array [14/14]
Message-Id: <20030212083826.54a2b160.rddunlap@osdl.org>
In-Reply-To: <20030212120757.M1563@ucw.cz>
References: <20030212120154.C1563@ucw.cz>
	<20030212120242.D1563@ucw.cz>
	<20030212120321.E1563@ucw.cz>
	<20030212120359.F1563@ucw.cz>
	<20030212120427.G1563@ucw.cz>
	<20030212120454.H1563@ucw.cz>
	<20030212120530.I1563@ucw.cz>
	<20030212120605.J1563@ucw.cz>
	<20030212120638.K1563@ucw.cz>
	<20030212120710.L1563@ucw.cz>
	<20030212120757.M1563@ucw.cz>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2003 12:07:57 +0100
Vojtech Pavlik <vojtech@suse.cz> wrote:

| diff -Nru a/drivers/input/keyboard/sunkbd.c b/drivers/input/keyboard/sunkbd.c
| --- a/drivers/input/keyboard/sunkbd.c	Wed Feb 12 11:56:22 2003
| +++ b/drivers/input/keyboard/sunkbd.c	Wed Feb 12 11:56:22 2003
| @@ -268,7 +268,7 @@
|  	sprintf(sunkbd->name, "Sun Type %d keyboard", sunkbd->type);
|  
|  	memcpy(sunkbd->keycode, sunkbd_keycode, sizeof(sunkbd->keycode));
| -	for (i = 0; i < 255; i++)
| +	for (i = 0; i < 127; i++)
|  		set_bit(sunkbd->keycode[i], sunkbd->dev.keybit);
|  	clear_bit(0, sunkbd->dev.keybit);
|  


If sunkbd has a valid keycode 127, that new loop test won't handle it,
so it should/could be:
| +	for (i = 0; i < 128; i++)


--
~Randy
