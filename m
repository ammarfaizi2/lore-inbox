Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263439AbTLBF31 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 00:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263526AbTLBF31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 00:29:27 -0500
Received: from ms-smtp-02.rdc-kc.rr.com ([24.94.166.122]:36819 "EHLO
	ms-smtp-02.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S263439AbTLBF3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 00:29:25 -0500
From: Paul Misner <paul@misner.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Promise 20378 + 2.6.0-test10 + libata patch 1
Date: Mon, 1 Dec 2003 23:29:17 -0600
User-Agent: KMail/1.5.93
References: <BAY7-F71W9F0qnqEBQd00001253@hotmail.com>
In-Reply-To: <BAY7-F71W9F0qnqEBQd00001253@hotmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200312012329.17809.paul@misner.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 01 December 2003 09:24 pm, Joe Blow wrote:
> >No plans.
>
> Curiious:  How come when I disable RAID support in the BIOS and just have
> it <supposedly> act just like a dumb IDE controller, why aren't the drives
> aren't recognized that way?  The BIOS claims it is plugging them in as
> plain IDE drives, or is something still different about this controller,
> even in that mode?

Under Windows, the Promise driver, that you loaded, assumes that they are 
being used as a RAID controller.  If you unload the driver, you can use the 
two IDE channels as IDE channels under Windows 2000 and Windows XP.

>
> >Using standard kernel drivers, Promise RAID _is_ md.
>
> <confused> I understand what md is, but I don't understand how Promise RAID
> is md.  If I set the controller to RAID in the BIOS, and I configure a RAID
> 1 mirror, for example, how is that md?  In this mode, isn't one copy of the
> data being sent to the controller and the controller "intelligence" figures
> out that one copy of the data goes to each drive?  Where is if it were
> providing two drives to the OS, the md driver would have to send two copies
> of the data across the bus, one to each drive?

Repeat after me... Hardware raid is smart, wonderful, and expensive.  Software 
raid is cheap, the controller card is dumb, and is what people put on 
motherboards, and inexpensive controller cards.

There are two IDE controller channels on the Promise RAID controller card, a 
bios chip, and not much else.  They have no processor.

The bios is only used for booting, since the operating system drivers aren't 
loaded yet.  Once booted, the Windows driver pretends it is a hardware Raid, 
by using software in the driver (I.E. Software Raid).  Linux uses the md 
driver to map access to the of drives, which it makes into a Raid set (I.E. 
Software Raid).

>
> Perhaps this is a dumb question, but why are these RAID controller
> companies seemingly making this so difficult?  To me it seems like the most
> logical way to design these controllers would be to make them look like
> standard IDE controllers to the system and hide the RAID complexities
> inside the controller intelligence.  The most expensive part of these
> controllers for the manufacturers has to be in providing drivers and
> support for all the different, primarily MS, OSes.  I must be missing
> something.

A hardware Raid card is a complete computer, that happens to plug into your 
PCI bus, and it has a software Raid driver.  It frequently costs more than 
the motherboard it is plugged in to.

Paul
