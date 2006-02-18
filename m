Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751065AbWBRAPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbWBRAPP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 19:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbWBRAPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 19:15:15 -0500
Received: from sccrmhc11.comcast.net ([63.240.77.81]:59122 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1751065AbWBRAPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 19:15:13 -0500
Subject: Re: kbuild: Section mismatch warnings
From: Nicholas Miell <nmiell@comcast.net>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Adrian Bunk <bunk@stusta.de>, LKML <linux-kernel@vger.kernel.org>,
       len.brown@intel.com, Paul Bristow <paul@paulbristow.net>,
       mpm@selenic.com, B.Zolnierkiewicz@elka.pw.edu.pl,
       dtor_core@ameritech.net, kkeil@suse.de,
       linux-dvb-maintainer@linuxtv.org, philb@gnu.org, gregkh@suse.de,
       dwmw2@infradead.org
In-Reply-To: <20060217233848.GA26630@mars.ravnborg.org>
References: <20060217214855.GA5563@mars.ravnborg.org>
	 <20060217224702.GA25761@mars.ravnborg.org>
	 <20060217233253.GN4422@stusta.de>
	 <20060217233848.GA26630@mars.ravnborg.org>
Content-Type: text/plain
Date: Fri, 17 Feb 2006 16:14:59 -0800
Message-Id: <1140221699.2907.5.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-02-18 at 00:38 +0100, Sam Ravnborg wrote:
> Hi Adrian
> 
> > > I did not find a way to look up the offending symbol but maybe some elf
> > > expert can help?
> > >...
> >  
> > I'm not an ELF expert, but simply checking all __init functions in this 
> > files finds that this seems to be the following:
> > 
> > <--  snip  -->
> > 
> > ...
> > static struct acpi_driver asus_hotk_driver = {
> >         .name = ACPI_HOTK_NAME,
> >         .class = ACPI_HOTK_CLASS,
> >         .ids = ACPI_HOTK_HID,
> >         .ops = {
> >                 .add = asus_hotk_add,
> >                 .remove = asus_hotk_remove,
> >                 },
> > };
> > ...
> > static int __init asus_hotk_add(struct acpi_device *device)
> > ...
> > 
> Correct.
> What I wanted was modpost to tell that the symbol being referenced in
> the .data section was 'asus_hotk_add' and not just an offset after
> asus_hotk_driver.
> 
> What is needed is a link from the RELOCATION RECORD to the symbol table.

The r_info field of Elf{32,64}_Rel{,a} contains an index into the symbol
table which can be extracted using the ELF{32,64}_R_SYM() macro.

-- 
Nicholas Miell <nmiell@comcast.net>

