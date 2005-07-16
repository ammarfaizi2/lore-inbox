Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261641AbVGPPG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbVGPPG0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 11:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbVGPPG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 11:06:26 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:4878 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261641AbVGPPGX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 11:06:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rJjm3MB6ex7cdPJZdwCKF3nLvbsulI/G4ucovmBT5wn5zdnhionS8glvPBWr9Zbesia+tKOa/M3DvuMkx9ghGiSwBQzWBbSliNlrljmH6CpUttmFZdybQ7ikvzPrS2X+0GrM6YBdxZSv6M+7EMMZUqwtY1YTLG6Vs6ltk7LLCDU=
Message-ID: <105c793f05071608065ceb5b8b@mail.gmail.com>
Date: Sat, 16 Jul 2005 11:06:22 -0400
From: Andrew Haninger <ahaning@gmail.com>
Reply-To: Andrew Haninger <ahaning@gmail.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: PS/2 Keyboard is dead after resume.
Cc: linux-kernel@vger.kernel.org,
       suspend2-users <suspend2-users@lists.suspend2.net>
In-Reply-To: <200507160135.39220.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <105c793f0507141935403fc828@mail.gmail.com>
	 <200507150024.46293.dtor_core@ameritech.net>
	 <105c793f0507150443b1e8359@mail.gmail.com>
	 <200507160135.39220.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/05, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> Ok, so you start with IRQ 12 disabled.. You don't have a PS/2 mouse,
> do you?
Nope :).

> > serio: i8042 AUX port at 0x60,0x64 irq 12
> > serio: i8042 KBD port at 0x60,0x64 irq 1
> 
> You did not select PNP support (but as far as keyboard controller settings
> go we don't trust it anyway on i386).
I've never ever found it to work, so I usually disable it.

> And here you have a bunch of hardware gets assigned to IRQ 12...
> Hmm, I tought ACPI would try not use 12 unless it is absolutely
> necessary. What appens if you use "pci=routeirq" boot option?
The keyboard was still dead after resume.

> You can try working around this with "i8042.noaux" kernel boot option,
> but we should probably teach i8042 driver to not touch AUX port on resume
> if it was disabled.
This worked. Strangely enough, after googling for i8042 and suspend
last night, I found the 2.6.12 kernel boot options file. I tried
i8042.nomux, i8042.direct, and some others, but nothing worked. Just
for fun, I tried booting without any kernel boot options (just the
suspend2 option) and with a PS/2 mouse plugged in. On suspend, the
keyboard worked.

Maybe this could/should be added to the suspend2 code as well?

Whatever. It works for now. If you'd like any more information, just
let me know. Thanks!

-Andy
