Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751069AbWBQXcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbWBQXcz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 18:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751058AbWBQXcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 18:32:55 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:28171 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751483AbWBQXcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 18:32:54 -0500
Date: Sat, 18 Feb 2006 00:32:53 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: LKML <linux-kernel@vger.kernel.org>, len.brown@intel.com,
       Paul Bristow <paul@paulbristow.net>, mpm@selenic.com,
       B.Zolnierkiewicz@elka.pw.edu.pl, dtor_core@ameritech.net, kkeil@suse.de,
       linux-dvb-maintainer@linuxtv.org, philb@gnu.org, gregkh@suse.de,
       dwmw2@infradead.org
Subject: Re: kbuild: Section mismatch warnings
Message-ID: <20060217233253.GN4422@stusta.de>
References: <20060217214855.GA5563@mars.ravnborg.org> <20060217224702.GA25761@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060217224702.GA25761@mars.ravnborg.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2006 at 11:47:02PM +0100, Sam Ravnborg wrote:
>...
> Syntax:
> The offset refer to the relative offset from the referenced symbol.
> So
> WARNING: drivers/acpi/asus_acpi.o - Section mismatch: reference to .init.text from .data between 'asus_hotk_driver' (at offset 0xc0) and 'model_conf'
> should be read as:
> 
> At 0xc0 bytes after asus_hotk_driver there is a reference to a symbol
> placed in the section .init.text.
> 
> I did not find a way to look up the offending symbol but maybe some elf
> expert can help?
>...
 
I'm not an ELF expert, but simply checking all __init functions in this 
files finds that this seems to be the following:

<--  snip  -->

...
static struct acpi_driver asus_hotk_driver = {
        .name = ACPI_HOTK_NAME,
        .class = ACPI_HOTK_CLASS,
        .ids = ACPI_HOTK_HID,
        .ops = {
                .add = asus_hotk_add,
                .remove = asus_hotk_remove,
                },
};
...
static int __init asus_hotk_add(struct acpi_device *device)
...

<--  snip  -->

> 	Sam
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

