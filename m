Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131448AbQK3IvO>; Thu, 30 Nov 2000 03:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131581AbQK3Iux>; Thu, 30 Nov 2000 03:50:53 -0500
Received: from 213-120-136-24.btconnect.com ([213.120.136.24]:18948 "EHLO
        penguin.homenet") by vger.kernel.org with ESMTP id <S131401AbQK3Iup>;
        Thu, 30 Nov 2000 03:50:45 -0500
Date: Thu, 30 Nov 2000 08:22:13 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Patrick van de Lageweg <patrick@bitwizard.nl>
cc: Rogier Wolff <wolff@bitwizard.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] New user space serial port driver
In-Reply-To: <Pine.LNX.4.21.0011300903470.11226-100000@panoramix.bitwizard.nl>
Message-ID: <Pine.LNX.4.21.0011300817320.846-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2000, Patrick van de Lageweg wrote:
> +static struct tty_struct * ussp_table[USSP_MAX_PORTS] = { NULL, };

this wastes at least 4 * USSP_MAX_PORTS bytes in the kernel image.
Typically around 64 bytes but could be more. For more info see the recent
silly flamewars on the list. The correct way is not to initialize the data
to zero explicitly as BSS is cleared automatically on boot. It is also
probably documented in the lkml FAQ at the bottom of this message.

Also, it makes your code look consistent as, e.g. in cases below you do
the right thing:

> +static struct termios    * ussp_termios[USSP_MAX_PORTS];
> +static struct termios    * ussp_termios_locked[USSP_MAX_PORTS];

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
