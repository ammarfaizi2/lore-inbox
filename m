Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267992AbUIUTNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267992AbUIUTNi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 15:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267998AbUIUTNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 15:13:38 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:9118 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S267992AbUIUTNg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 15:13:36 -0400
Subject: Re: [ACPI] Re: [PATCH/RFC] exposing ACPI objects in sysfs
From: Alex Williamson <alex.williamson@hp.com>
To: Andi Kleen <ak@suse.de>
Cc: Pavel Machek <pavel@ucw.cz>, acpi-devel <acpi-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040921190606.GE18938@wotan.suse.de>
References: <1095716476.5360.61.camel@tdi>
	 <20040921122428.GB2383@elf.ucw.cz> <1095785315.6307.6.camel@tdi>
	 <20040921172625.GA30425@elf.ucw.cz>  <20040921190606.GE18938@wotan.suse.de>
Content-Type: text/plain
Organization: LOSL
Date: Tue, 21 Sep 2004 13:13:55 -0600
Message-Id: <1095794035.24751.54.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-21 at 21:06 +0200, Andi Kleen wrote:
> On Tue, Sep 21, 2004 at 07:26:25PM +0200, Pavel Machek wrote:
> > > +struct special_cmd {
> > > +        u32                     magic;
> > > +        unsigned int            cmd;
> > > +        char                    *args;
> > > +};
> > 
> > Talk to Andi Kleen; passing such structures using read/write is evil,
> > because (unlike ioctl) there's no place to put 32/64bit
> > translation. Imagine i386 application running on x86-64 system.
> 
> Yes, Pavel is right. Please don't pass pointers by read/write
> because it cannot be 32bit emulated.

   All pointers are actually interpreted as offsets into the buffer for
this interface.  They are not actually pointers.  I believe the 32bit
emulation problem is limited to an ILP32 application generating data
structures appropriate for an LP64 kernel.  While difficult, it can be
done.

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab

