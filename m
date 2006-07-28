Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161137AbWG1MnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161137AbWG1MnD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 08:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161142AbWG1MnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 08:43:03 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:34395 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161137AbWG1MnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 08:43:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ULavDOQwb6/Pgaiso9Ta50upIkR05bIU74GsUhhPN5uMNgD1x/DYwQNdkSbDi5Am7Gs8PQtqRnyvcBNLS3Q5LMQUJIW7KA7CMfkNQyRMA0ZAmlAtx/6dlYL9SCdEmMaNQtERk9yXEnpAkWj8FGVNgmG9wjfma0wJg1IFUeJdV6E=
Message-ID: <d120d5000607280543u6ca61a7epbb26ef98dafcae18@mail.gmail.com>
Date: Fri, 28 Jul 2006 08:43:00 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Zed 0xff" <zed.0xff@gmail.com>
Subject: Re: [patch] fix common mistake in polling loops
Cc: kernel-janitors@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <710c0ee0607280128g2d968c49ycff3bac9e073e7fa@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <710c0ee0607280128g2d968c49ycff3bac9e073e7fa@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/06, Zed 0xff <zed.0xff@gmail.com> wrote:
> @@ -955,11 +956,15 @@ static void psmouse_resync(void *p)
>  * repeat our attempts 5 times, otherwise we may be left out with disabled
>  * mouse.
>  */
> -       for (i = 0; i < 5; i++) {
> +       timeout = jiffies + msecs_to_jiffies(1000);
> +       for (;;) {
>                if (!ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_ENABLE)) {
>                        enabled = 1;
>                        break;
>                }
> +               if (time_after(timeout, jiffies)) {
> +                       break;
> +               }
>                msleep(200);
>        }
>

NAK. Have you read the comment above (that is partially visible in
your diff)? I do not really care about timeout here, I want my mouse
working.

-- 
Dmitry
