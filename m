Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbVFFUtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbVFFUtk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 16:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbVFFUtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 16:49:36 -0400
Received: from mail.dvmed.net ([216.237.124.58]:202 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261668AbVFFUt2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 16:49:28 -0400
Message-ID: <42A4B6D1.9010402@pobox.com>
Date: Mon, 06 Jun 2005 16:49:21 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jim Ramsay <jim.ramsay@gmail.com>
CC: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: sata_promise driver and 2.6.11 on a MIPS board
References: <4789af9e05060613394b1809c3@mail.gmail.com>
In-Reply-To: <4789af9e05060613394b1809c3@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Ramsay wrote:
> The driver then waits via a wait_for_completion apparently waiting for
> the PCI card to throw an interrupt so it can continue.  However, I
> never see this interrupt generated, and the driver code waits forever.


This is a known bug that definitely needs fixing:

(to ATA developers)
Any time an ATA command is issued outside of the SCSI layer, we need to 
employ a timer to time out commands.

Since most commands are done within the SCSI layer, which provides a lot 
of error handling apparatus, most commands properly time out.  The ones 
during probe - IDENTIFY DEVICE, set xfer mode, etc. - do not have such a 
timer.

	Jeff


