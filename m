Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbWDRQuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbWDRQuG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 12:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbWDRQuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 12:50:06 -0400
Received: from mx2.mail.ru ([194.67.23.122]:42819 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S1751102AbWDRQuE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 12:50:04 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: PATCH [3/3]: Provide generic backlight support in Toshiba ACPI driver
Date: Tue, 18 Apr 2006 20:49:53 +0400
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604182049.55003.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> @@ -546,6 +591,12 @@ static int __init toshiba_acpi_init(void
>                         remove_proc_entry(PROC_TOSHIBA, acpi_root_dir);
>         }
>
> +       tosh_backlight_device = backlight_device_register ("tosh-bl", NULL,
> +                                                          &toshbl_data);
> +
> +       if (IS_ERR (tosh_backlight_device))
> +               printk("Failed to register Toshiba backlight device\n");
> +
>         return (ACPI_SUCCESS(status)) ? 0 : -ENODEV;
>  }
>

Should not this be

       if (IS_ERR (tosh_backlight_device)) {
               printk("Failed to register Toshiba backlight device\n");
               tosh_backlight_device = NULL;
       }

> @@ -556,6 +607,8 @@ static void __exit toshiba_acpi_exit(voi
>         if (toshiba_proc_dir)
>                 remove_proc_entry(PROC_TOSHIBA, acpi_root_dir);
>
> +       backlight_device_unregister(tosh_backlight_device);
> +
>         return;
>  }

What if it failed register before?

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFERRiyR6LMutpd94wRAgldAJ4mK7HeL0UUY29XewfrCODvfa3t7wCgqLN8
dPbb6SKWJrMdmO3s/o7Gnns=
=JhuH
-----END PGP SIGNATURE-----
