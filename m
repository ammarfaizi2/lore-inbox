Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbUKAEmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbUKAEmI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 23:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261268AbUKAEmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 23:42:08 -0500
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:10414 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261223AbUKAEmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 23:42:03 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.10-rc1-mm2] keyboard / synaptics not working
Date: Sun, 31 Oct 2004 23:42:01 -0500
User-Agent: KMail/1.6.2
Cc: Matthias Hentges <mailinglisten@hentges.net>
References: <200410311903.06927@zodiac.zodiac.dnsalias.org> <200410312131.20088.dtor_core@ameritech.net> <1099277136.11089.1.camel@mhcln03>
In-Reply-To: <1099277136.11089.1.camel@mhcln03>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200410312342.01850.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 31 October 2004 09:45 pm, Matthias Hentges wrote:
> Am Mo, den 01.11.2004 schrieb Dmitry Torokhov um 3:31:
> 
> [...]
> 
> > Can I get a binary version of it (straight out of /proc/acpi/dsdt) please?
> > The one you send was converted into C source while I need ASL.
> > 
> Sure, it's attached.

Hmm, i8042 already recognizes both PNP IDs from your DSDT:

>                 Device (PS2K)
>                 {
>                     Name (_HID, EisaId ("PNP0303"))
>                     Name (_CRS, ResourceTemplate ()
>                     {
>                         IO (Decode16, 0x0060, 0x0060, 0x01, 0x01)
>                         IO (Decode16, 0x0064, 0x0064, 0x01, 0x01)
>                         IRQ (Edge, ActiveHigh, Exclusive) {1}
>                     })
>                 }
> 
>                 Device (PS2M)
>                 {
>                     Name (_HID, EisaId ("PNP0F13"))
> 

I wonder what is going on... I see there was big ACPI update in -mm2,
could you try reverting bk-acpi.patch.

Btw, you said you are using 2.6.10-rc1 - is there -mm suffix missing?
Linus's tree does not have i8042 ACPI enumeration patch yet so 
i8042.noacpi does not have any effect and should not even be recognized
by the kernel.

-- 
Dmitry
