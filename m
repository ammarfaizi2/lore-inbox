Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266081AbUGENbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266081AbUGENbT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 09:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266085AbUGENbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 09:31:19 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:6167 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S266081AbUGENbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 09:31:17 -0400
X-Ironport-AV: i="3.81R,149,1083560400"; 
   d="scan'208"; a="52641106:sNHT25775904"
Date: Mon, 5 Jul 2004 08:31:17 -0500 (CDT)
From: Matt Domsch <Matt_Domsch@dell.com>
X-X-Sender: mdomsch@humbolt.us.dell.com
To: Andries Brouwer <aebr@win.tue.nl>
cc: Jeff Garzik <jgarzik@pobox.com>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, David Balazic <david.balazic@hermes.si>
Subject: Re: Weird:  30 sec delay during early boot
In-Reply-To: <20040704232716.GA18403@pclin040.win.tue.nl>
Message-ID: <Pine.LNX.4.44.0407050827200.30783-100000@humbolt.us.dell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jul 2004, Andries Brouwer wrote:

> On Sun, Jul 04, 2004 at 03:52:51PM -0500, Matt Domsch wrote:
> 
> > Only that it's now probing more than just the first disk, but the
> > first 16 possible BIOS disks.  If the BIOS behaves badly to an int13
> > READ_SECTORS command, that'd be good to know...
> 
> I recall text fragments like
> 
>  "Any device claiming compliance to ATA-3 or later as indicated in
>   IDENTIFY DEVICE or IDENTIFY PACKET DEVICE data should properly
>   release PDIAG- after a power-on or hardware reset upon receiving
>   the first command or after 31 seconds have elapsed since the reset,
>   whichever comes first."
> 
> that seem to imply that probing a nonexistent device may take 31 sec
> before one is allowed to conclude that there is nothing there.

I wonder if, for our purposes, we could first issue the int13 fn41 (check
extensions present) as we do before calling fn48 later.  This doesn't read
the disk itself, and hopefully can return immediately with a failure on
the nonexistant device, thus we can stop before reading the MBR.  No one
has indicated that the fn41 or fn48 code causes any delay, only the fn02
(read sectors)...

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

