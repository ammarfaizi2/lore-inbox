Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268118AbUHKQ2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268118AbUHKQ2j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 12:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268114AbUHKQ2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 12:28:39 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:13547 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S268108AbUHKQ2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 12:28:22 -0400
Subject: Re: [PATCH] SCSI midlayer power management
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Nathan Bryant <nbryant@optonline.net>, Pavel Machek <pavel@ucw.cz>,
       Linux SCSI Reflector <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <1092237664.19009.23.camel@localhost.localdomain>
References: <4119611D.60401@optonline.net>
	<20040811080935.GA26098@elf.ucw.cz>  <411A1B72.1010302@optonline.net>
	<1092231462.2087.3.camel@mulgrave> 
	<1092237664.19009.23.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 11 Aug 2004 11:28:06 -0500
Message-Id: <1092241693.1590.1.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-08-11 at 10:21, Alan Cox wrote:
> In addition we are not doing SCSI target so multi-initiator is ok.
> One question James - what are the rules for power management with
> SCSI when we provide termpwr to a shared bus ?

I don't believe the spec addresses that.

The rules we use in HA are that each bus entity supplies termpwr (i.e.
all initiators and targets) and each terminator draws its power from the
bus).  Thus the bus is properly terminated until the last device powers
down.

You have to jumper this specially on most SCSI cards (especially if
they're at the end of the bus and have internal termination).

James


