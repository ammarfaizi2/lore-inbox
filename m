Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316657AbSEVS0O>; Wed, 22 May 2002 14:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316643AbSEVSZD>; Wed, 22 May 2002 14:25:03 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:55557 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316644AbSEVSYf>; Wed, 22 May 2002 14:24:35 -0400
Subject: Re: [PATCH] Fix complete freeze on Dell latitude in nm256_audio.c
To: jas@extundo.com (Simon Josefsson)
Date: Wed, 22 May 2002 19:16:08 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <ilur8k4t6n9.fsf@latte.josefsson.org> from "Simon Josefsson" at May 22, 2002 07:49:14 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17Aaee-0002Sj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Please add this to the 2.4 tree.  Without it, Dell Latitude laptops
> completely freeze when loading the module.  Thanks.

The change below has been in the tree for a while already

> --- linux/drivers/sound/nm256_audio.c.orig      Sun Sep 30 21:26:08 2001
> +++ linux/drivers/sound/nm256_audio.c   Wed May 22 19:46:48 2002
> @@ -896,7 +896,9 @@
> 
>      /* Reset the mixer.  'Tis magic!  */
>      nm256_writePort8 (card, 2, 0x6c0, 1);
> -    nm256_writePort8 (card, 2, 0x6cc, 0x87);
> +    /* The following line crashes Dell Latitude laptops and doesn't
> +     * seem to do any harm on other machines.
> +    nm256_writePort8 (card, 2, 0x6cc, 0x87); */
>      nm256_writePort8 (card, 2, 0x6cc, 0x80);
>      nm256_writePort8 (card, 2, 0x6cc, 0x0);

