Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264779AbRGEWPP>; Thu, 5 Jul 2001 18:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264791AbRGEWPF>; Thu, 5 Jul 2001 18:15:05 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:35844 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S264779AbRGEWO4>;
	Thu, 5 Jul 2001 18:14:56 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200107052214.f65ME2q61970@saturn.cs.uml.edu>
Subject: Re: [OT] Re: LILO calling modprobe?
To: wakko@animx.eu.org (Wakko Warner)
Date: Thu, 5 Jul 2001 18:14:02 -0400 (EDT)
Cc: aaronl@vitelus.com (Aaron Lehmann), dwguest@win.tue.nl (Guest section DW),
        sburns@farpointer.net (Stephen C Burns), linux-kernel@vger.kernel.org,
        83710@bugs.debian.org
In-Reply-To: <20010705180331.A10315@animx.eu.org> from "Wakko Warner" at Jul 05, 2001 06:03:31 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wakko Warner writes:

> I believe there is.  It wants to find what drive is bios drive 80h.  Really
> annoying since there's no way (correct me if I'm wrong) to read bios from
> linux.  If there is, lilo should do that.  But since it's an old copy, this
> probably was fixed.
>
> I had a machine at work with both ide and scsi.  ide hdd was hdc and ide
> cdrom was hda just to keep lilo from thinking hdc is the first bios drive
> which infact sda was

The easy way to handle this is to md5 checksum the disks at boot.
Read the first and last track of the first and last cylinder of
every BIOS drive. Then match up the disks when partition tables
get scanned.

The hard way involves running the BIOS in virtual-8088 mode to
trap IO accesses, then mapping to drivers by IO region later.

Neither way is 100% reliable, but the current guess is worse.
