Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267212AbUIEUy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267212AbUIEUy6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 16:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267223AbUIEUy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 16:54:58 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:12306 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S267212AbUIEUy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 16:54:56 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix possible leak in fbcon code.
Date: Sun, 5 Sep 2004 23:54:48 +0300
User-Agent: KMail/1.5.4
References: <200409011551.i81FpMZn000650@delerium.codemonkey.org.uk>
In-Reply-To: <200409011551.i81FpMZn000650@delerium.codemonkey.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409052354.48691.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 September 2004 18:51, Dave Jones wrote:
> Spotted with the source checker from Coverity.com.
>
> Signed-off-by: Dave Jones <davej@redhat.com>
>
>
> diff -urpN --exclude-from=/home/davej/.exclude
> bk-linus/drivers/video/console/fbcon.c
> linux-2.6/drivers/video/console/fbcon.c ---
> bk-linus/drivers/video/console/fbcon.c	2004-08-24 00:02:40.000000000 +0100
> +++ linux-2.6/drivers/video/console/fbcon.c	2004-09-01 13:31:12.000000000
> +0100 @@ -983,6 +983,7 @@ static void fbcon_init(struct vc_data *v
>  			vc->vc_y += logo_lines;
>  			vc->vc_pos += logo_lines * vc->vc_size_row;
>  			kfree(save);
> +			save = NULL;
>  		}
>  		if (logo_lines > vc->vc_bottom) {
>  			logo_shown = -1;
> @@ -1004,6 +1005,8 @@ static void fbcon_init(struct vc_data *v
>  			softback_top = 0;
>  		}
>  	}
> +	if (save)
> +		kfree(save);
>  }
>
>  static void fbcon_deinit(struct vc_data *vc)

kfree(NULL) is valid (it's a nop).
--
vda

