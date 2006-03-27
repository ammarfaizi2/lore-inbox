Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750917AbWC0Lm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbWC0Lm0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 06:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbWC0Lm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 06:42:26 -0500
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:31666 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750911AbWC0LmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 06:42:25 -0500
Date: Mon, 27 Mar 2006 13:42:15 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Linus Torvalds <torvalds@osdl.org>
cc: Bodo Eggert <7eggert@gmx.de>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Move SG_GET_SCSI_ID from sg to scsi
In-Reply-To: <Pine.LNX.4.64.0603261424590.15714@g5.osdl.org>
Message-ID: <Pine.LNX.4.58.0603271306140.3209@be1.lrz>
References: <Pine.LNX.4.58.0603262108500.13001@be1.lrz>
 <Pine.LNX.4.64.0603261424590.15714@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Mar 2006, Linus Torvalds wrote:
> On Sun, 26 Mar 2006, Bodo Eggert wrote:

> > Having a SCSI ID is a generic SCSI property
> 
> No it's not.

With respect to sg vs. scsi, it is.

> Havign a SCSI ID is a f*cking idiotic thing to do.
> 
> Only idiots like Joerg Schilling thinks that any such thing even _exists_. 
> It does not, never has, and never will.

For the host ID ACK, but some transports do support channel/ID/LUN. In
/these/ cases having them exported is a sane thing to do. I don't even try
to argue if it's better to use sysfs or ioctl.

> The way you reach a SCSI device is through the device filename, and trying 
> to use controller/channel/id/lun naming IS INSANE!

ACK, and having an address space of 340 * 10^36 will make it perfectly
clear. One day a subsystem might hand out ID and LUN cookies instead of
counters, and a certain table of sg numbers will stop fitting in memory.
I'm just handing out the bigger gun with the automatic foot-finder.-)

</chasing the pink herring>

> Stop it now. We should kill that ioctl, not try to make it look like it is 
> sensible. It's not a sensible way to look up SCSI devices, and the fact 
> that some SCSI people think it is is doesn't make it so.

Schedule for removal?

As I understand, having a /dev/sd0815 corresponding to a /dev/sg4711 is
the root of all evil and idiotic things, and moving all sg functions into
the apropiate place is the sane thing to do.

This patch is a part of the process, and as soon as all sg functions are
available using /dev/s[dtr]*, the corresponding sg devices should be
deprecated and removed.

-- 
Those who desire to give up Freedom in order to gain Security,
will not have, nor do they deserve, either one.
	-- T. Jefferson
