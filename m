Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbUDIRCF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 13:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbUDIRCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 13:02:05 -0400
Received: from ns.suse.de ([195.135.220.2]:26087 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261321AbUDIRCA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 13:02:00 -0400
Date: Fri, 9 Apr 2004 19:02:05 +0200
From: Andi Kleen <ak@suse.de>
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.5-mm3, x86_64: probe_roms()
Message-Id: <20040409190205.1781d33d.ak@suse.de>
In-Reply-To: <4076CDA5.4090609@keyaccess.nl>
References: <4076CDA5.4090609@keyaccess.nl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Apr 2004 18:21:57 +0200
Rene Herman <rene.herman@keyaccess.nl> wrote:

> Hi Andrew, Andi.
> 
> Andi, this patch sent to Andrew since he has the i386 equivalent. If you 
> want it yourself, or don't want it at all, please holler.
> 
> x86_64 inherits arch/x86_64/kernel/setup.c:probe_roms() from i386 and 
> shares its problems (minus the first) described at:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=107991009932451&w=2
> 
> Like the i386 version, the attached x86_64 version also c99ifies the 
> data and adds IORESOURCE_* type flags. It's been (cross-)compiled but 
> not booted due to lack of hardware.

The C99ification is really ugly, because the tables end up more or less 
unreadable unlike the previous version.  I don't think it's a good 
idea to use values from the ROM unchecked (like you did with the length
for the checksum). In fact this checksum change looks quite dangerous on i386
because there is very likely a machine out somewhere with bogus
length bytes which explodes when you do an access after the video ROM.
Chipsets sometimes have interesting errata in these areas.
[that's probably more an issue on i386 than on x86-64, but it's better
to be safe than sorry]

The other changes look ok. If you send me a patch just for these 
I will apply it.

-Andi
