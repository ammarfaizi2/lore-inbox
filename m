Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262977AbSJ1Hjg>; Mon, 28 Oct 2002 02:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262981AbSJ1Hjg>; Mon, 28 Oct 2002 02:39:36 -0500
Received: from daimi.au.dk ([130.225.16.1]:59790 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S262977AbSJ1Hjg>;
	Mon, 28 Oct 2002 02:39:36 -0500
Message-ID: <3DBCEB2E.BC3956FD@daimi.au.dk>
Date: Mon, 28 Oct 2002 08:45:50 +0100
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.18-17.7.xsmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [CFT] kexec syscall for 2.5.43 (linux booting linux)
References: <m1k7kfzffk.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" wrote:
> 
> +static void i8259A_remove(struct device *dev)
> +{
> +       /* Restore the i8259A to it's legacy dos setup.
> +        * The kernel won't be using it any more, and it
> +        * just might make reboots, and kexec type applications
> +        * more stable.
> +        */
> +       outb(0xff, 0x21);       /* mask all of 8259A-1 */
> +       outb(0xff, 0xA1);       /* mask all of 8259A-1 */
> +
> +       outb_p(0x11, 0x20);     /* ICW1: select 8259A-1 init */
> +       outb_p(0x08, 0x21);     /* ICW2: 8259A-1 IR0-7 mappend to 0x8-0xf */
> +       outb_p(0x01, 0x21);     /* Normal 8086 auto EOI mode */
> +
> +       outb_p(0x11, 0xA0);     /* ICW1: select 8259A-2 init */
> +       outb_p(0x08, 0xA1);     /* ICW2: 8259A-2 IR0-7 mappend to 0x70-0x77 */
                 ^^^^                                               ^^^^

This looks wrong to me.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:aaarep@daimi.au.dk
Don't do this at home kids: touch -- -rf
