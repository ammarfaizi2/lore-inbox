Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267945AbTBMA5D>; Wed, 12 Feb 2003 19:57:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267948AbTBMA5D>; Wed, 12 Feb 2003 19:57:03 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:50626 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S267945AbTBMA5C>;
	Wed, 12 Feb 2003 19:57:02 -0500
Date: Thu, 13 Feb 2003 02:06:29 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] input: sunkbd.c - fix reading beyond end of keycode array [14/14]
Message-ID: <20030213020629.A6095@ucw.cz>
References: <20030212120321.E1563@ucw.cz> <20030212120359.F1563@ucw.cz> <20030212120427.G1563@ucw.cz> <20030212120454.H1563@ucw.cz> <20030212120530.I1563@ucw.cz> <20030212120605.J1563@ucw.cz> <20030212120638.K1563@ucw.cz> <20030212120710.L1563@ucw.cz> <20030212120757.M1563@ucw.cz> <20030212083826.54a2b160.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030212083826.54a2b160.rddunlap@osdl.org>; from rddunlap@osdl.org on Wed, Feb 12, 2003 at 08:38:26AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2003 at 08:38:26AM -0800, Randy.Dunlap wrote:
> On Wed, 12 Feb 2003 12:07:57 +0100
> Vojtech Pavlik <vojtech@suse.cz> wrote:
> 
> | diff -Nru a/drivers/input/keyboard/sunkbd.c b/drivers/input/keyboard/sunkbd.c
> | --- a/drivers/input/keyboard/sunkbd.c	Wed Feb 12 11:56:22 2003
> | +++ b/drivers/input/keyboard/sunkbd.c	Wed Feb 12 11:56:22 2003
> | @@ -268,7 +268,7 @@
> |  	sprintf(sunkbd->name, "Sun Type %d keyboard", sunkbd->type);
> |  
> |  	memcpy(sunkbd->keycode, sunkbd_keycode, sizeof(sunkbd->keycode));
> | -	for (i = 0; i < 255; i++)
> | +	for (i = 0; i < 127; i++)
> |  		set_bit(sunkbd->keycode[i], sunkbd->dev.keybit);
> |  	clear_bit(0, sunkbd->dev.keybit);
> |  
> 
> 
> If sunkbd has a valid keycode 127, that new loop test won't handle it,
> so it should/could be:
> | +	for (i = 0; i < 128; i++)

You're right. It doesn't, though.

-- 
Vojtech Pavlik
SuSE Labs
