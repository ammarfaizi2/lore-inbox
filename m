Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751478AbWBQXjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbWBQXjH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 18:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbWBQXjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 18:39:07 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:1298 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751478AbWBQXjF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 18:39:05 -0500
Date: Sat, 18 Feb 2006 00:38:48 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: LKML <linux-kernel@vger.kernel.org>, len.brown@intel.com,
       Paul Bristow <paul@paulbristow.net>, mpm@selenic.com,
       B.Zolnierkiewicz@elka.pw.edu.pl, dtor_core@ameritech.net, kkeil@suse.de,
       linux-dvb-maintainer@linuxtv.org, philb@gnu.org, gregkh@suse.de,
       dwmw2@infradead.org
Subject: Re: kbuild: Section mismatch warnings
Message-ID: <20060217233848.GA26630@mars.ravnborg.org>
References: <20060217214855.GA5563@mars.ravnborg.org> <20060217224702.GA25761@mars.ravnborg.org> <20060217233253.GN4422@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060217233253.GN4422@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian

> > I did not find a way to look up the offending symbol but maybe some elf
> > expert can help?
> >...
>  
> I'm not an ELF expert, but simply checking all __init functions in this 
> files finds that this seems to be the following:
> 
> <--  snip  -->
> 
> ...
> static struct acpi_driver asus_hotk_driver = {
>         .name = ACPI_HOTK_NAME,
>         .class = ACPI_HOTK_CLASS,
>         .ids = ACPI_HOTK_HID,
>         .ops = {
>                 .add = asus_hotk_add,
>                 .remove = asus_hotk_remove,
>                 },
> };
> ...
> static int __init asus_hotk_add(struct acpi_device *device)
> ...
> 
Correct.
What I wanted was modpost to tell that the symbol being referenced in
the .data section was 'asus_hotk_add' and not just an offset after
asus_hotk_driver.

What is needed is a link from the RELOCATION RECORD to the symbol table.


	Sam
