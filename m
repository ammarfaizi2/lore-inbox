Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbULWRg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbULWRg2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 12:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbULWRg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 12:36:28 -0500
Received: from smtp20.libero.it ([193.70.192.147]:17866 "EHLO smtp20.libero.it")
	by vger.kernel.org with ESMTP id S261275AbULWRgJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 12:36:09 -0500
Message-ID: <41CAA62B.5030001@gmail.com>
Date: Thu, 23 Dec 2004 12:04:11 +0100
From: Luca Falavigna <dktrkranz@gmail.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: selvakumar nagendran <kernelselva@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Printk output on console
References: <20041221094302.14478.qmail@web60608.mail.yahoo.com>
In-Reply-To: <20041221094302.14478.qmail@web60608.mail.yahoo.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Selvakumar,
| While the
|> kernel is in execution where the output of all these
|> statements will go?

printk messages go to /proc/kmsg. You can read them using cat (e.g. cat
/proc/kmsg)
| can we redirect the output of
|> printk to our console?

There is another way to display kernel messages on a console: managing
ttys. Here is some code (taken from Peter Salzman's "The Linux Kernel
Module Programming Guide"):

static void print_string(char *str)
{
	struct tty_struct *tty;

#if ( LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,5) )
	tty = current->tty;
#else
	tty = current->signal->tty;
#endif

	if (!tty)
		return;

	((my_tty->driver)->write) (my_tty, 0, str, strlen(str));
	((my_tty->driver)->write) (my_tty, 0, "\015\012", 2);

}

Regards,

					Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQEVAwUBQcqmKxZrwl7j21nOAQKKegf/ZvQxx4FlaObzfeRQYXr5rRyK3/CSwaMX
3vFxX4fGm1Bn0PkTM1NgmgGnDdWaRFyME4odSy6k5XjnyPwO1DqkDUqJarexaq2V
8wrFhQMe3duEhgxonhOSVn/n+/ZIkqxkLujgk5YNpI8jE2vgzw9SwgGb5ck4wEz3
KbqF7YDRPnPot2rud3RTVVzc1MOb0Ti0zDRMpmvyOxkjOL1eocYKJfo5ZalNBQZi
k6B7Akk4zWZ6iFjl2Ojxw4RrZVoUupPb2qbkGWp11ghStTur1Qpw5WJyQ25zQB40
8r8ERFfzE02dbE/jiUj5SucJ8DVIKY38KXcMTS64+vWtH9263GkuxQ==
=1DIB
-----END PGP SIGNATURE-----

