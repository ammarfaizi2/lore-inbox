Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264913AbTLHAzO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 19:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264578AbTLHAzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 19:55:13 -0500
Received: from smtp800.mail.sc5.yahoo.com ([66.163.168.179]:27277 "HELO
	smtp800.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264913AbTLHAyo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 19:54:44 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Santiago Garcia Mantinan <manty@manty.net>,
       Lukas Hejtmanek <xhejtman@mail.muni.cz>
Subject: Re: Synaptics PS/2 driver and 2.6.0-test11
Date: Sun, 7 Dec 2003 19:54:31 -0500
User-Agent: KMail/1.5.4
Cc: Michal Jaegermann <michal@harddata.com>, linux-kernel@vger.kernel.org
References: <20031130214612.GP2935@mail.muni.cz> <20031207194404.GC13201@mail.muni.cz> <20031207221056.GA2990@man.beta.es>
In-Reply-To: <20031207221056.GA2990@man.beta.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200312071954.31897.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 07 December 2003 05:10 pm, Santiago Garcia Mantinan wrote:
> Sorry, I didn't notice this thread till now...
>
> > But why it does not hurt with kernel 2.4.22? Moreover how ACPI BIOS
> > influences synaptics driver? I do not see any BIOS call there...
>
> I have this problem reported as bug 1093 at bugme.osdl.org, my laptop
> is an ACER with intel chipset.
>
> The problem will happen even if you only check the batery status once a
> day, at that time, you can get the lost sync thing in 2.6, but not in
> 2.2, so the problem is not with the gnome applet, in fact I'm seing it
> under icewm and I have been able to reproduce it without any battery
> applet or anything like that, only running the "acpi -V" command each
> minute in a cron, that suffices for getting the errors.
>
> I believe that this should be solved, in 2.6, as it certainly doesn't
> happen on 2.4, if you want more info look at bug #1093 at
> bugme.osdl.org or if you need more details just ask for them.
>
> Hope this helps.
>
> Regards...

The difference is that GPM (I assume you are using it to get Synaptics
support) only logs "protocol violations" when in debug mode, and then it
only checks 2 first bytes. The XFree driver does check the protocol but
its messages usually don't show up in the syslog. In other words in-kernel
Synaptics driver just makes the problem apparent it seems.

>From what I saw in one case where Synaptics was loosing sync it looked
like 2 first bytes of the 6 byte packet were lost (psmouse never got them).
Would be interesting to compile i8042.c with debug and see the full flow 
of a problem system...

Dmitry
