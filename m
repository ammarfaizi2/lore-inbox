Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268256AbUHQOXD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268256AbUHQOXD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 10:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268258AbUHQOXC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 10:23:02 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12930 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268256AbUHQOTf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 10:19:35 -0400
Date: Tue, 17 Aug 2004 10:18:37 -0400
From: Alan Cox <alan@redhat.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@redhat.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: PATCH: straighten out the IDE layer locking and add hotplug
Message-ID: <20040817141837.GA14738@devserv.devel.redhat.com>
References: <20040815151346.GA13761@devserv.devel.redhat.com> <200408171512.26568.bzolnier@elka.pw.edu.pl> <200408171612.37898.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408171612.37898.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2004 at 04:12:37PM +0200, Bartlomiej Zolnierkiewicz wrote:
> this is dubious for many non PCI drivers which use ide_register_hw() to only
> claim/fill ide_hwifs[] entry but actual probing is done later by ide-generic 
> driver - we end up with hwif->present == 0 and hwif->configured == 1
> and if ide_register_hw() will try to unregister such hwif it will possibly 
> crash (because we now check for ->configured not ->present in 
> ide_unregister_hwif) - you've correctly noticed in the FIXMEs that we 

We check present as well as we free the various parts.  The problem we have
is interfaces exist in "allocated by someone but not present" cases. Right
now the lack of hotplug hides the fact this is totally broken. The unregister
code tries to be smart about this and unregisters only certain bits of the
object if its configured & !present. Thats why I save and use the present
value on entry. 

I've not looked at how it affects SCAN_HWIF but the other seemed ok. 

Alan

