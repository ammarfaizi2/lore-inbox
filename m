Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965664AbWKDVSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965664AbWKDVSW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 16:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965696AbWKDVSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 16:18:22 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:48863 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965664AbWKDVSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 16:18:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=A65DJI/Purbd8G7Ua0n1TzchTuBoPFnoOdWd8fKDT7eob7YhE7FIBgyZ8B1nFnqVzjGnfdLPE2uH0lYZcKz4YSM5bzdFUsRyKNQ2+JS7+el1apChezKog/XhrDG508yBCCa+EjUqfyS03KY6bZFoooKyUPUVbiQfHV0oD2ldFR4=
Message-ID: <454D03B8.1080507@gmail.com>
Date: Sat, 04 Nov 2006 22:18:25 +0059
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc4-mm2] epca get_termio cleanup
References: <200611042148.16096.m.kozlowski@tuxland.pl>
In-Reply-To: <200611042148.16096.m.kozlowski@tuxland.pl>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mariusz Kozlowski wrote:
> Hello,
> 
> The code using get_termio was already '#if 0' but get_termio itself was not. 

You would rather wipe it out or better, wipe the whole driver out, we have an
ack from Digi ;).

> Hence the warning:
> drivers/char/epca.c:2744: warning: 'get_termio' defined but not used
> 
> Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
> 
> diff -up linux-2.6.19-rc4-orig/drivers/char/epca.c 
> linux-2.6.19-rc4/drivers/char/epca.c
> --- linux-2.6.19-rc4-orig/drivers/char/epca.c   2006-11-04 20:31:54.000000000 
> +0100
> +++ linux-2.6.19-rc4/drivers/char/epca.c        2006-11-04 21:27:50.000000000 
> +0100
> @@ -209,7 +209,9 @@ static void digi_send_break(struct chann
>  static void setup_empty_event(struct tty_struct *tty, struct channel *ch);
>  void epca_setup(char *, int *);
>  
> +#if 0
>  static int get_termio(struct tty_struct *, struct termio __user *);
> +#endif
>  static int pc_write(struct tty_struct *, const unsigned char *, int);
>  static int pc_init(void);
>  static int init_PCI(void);
> @@ -2740,10 +2742,12 @@ static void setup_empty_event(struct tty
>  
>  /* --------------------- Begin get_termio ----------------------- */
>  
> +#if 0
>  static int get_termio(struct tty_struct * tty, struct termio __user * termio)
>  { /* Begin get_termio */
>         return kernel_termios_to_user_termio(termio, tty->termios);
>  } /* End get_termio */
> +#endif
>  
>  /* ---------------------- Begin epca_setup  -------------------------- */
>  void epca_setup(char *str, int *ints)

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
