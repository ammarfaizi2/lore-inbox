Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262827AbUKXULL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbUKXULL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 15:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262830AbUKXULE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 15:11:04 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31666 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262827AbUKXUI7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 15:08:59 -0500
Message-ID: <41A4EA47.2040304@pobox.com>
Date: Wed, 24 Nov 2004 15:08:39 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Tomita, Haruo" <haruo.tomita@toshiba.co.jp>
CC: Alan Cox <alan@redhat.com>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Marcelo Tosatti <marcelo@hera.kernel.org>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: linux-2.4.28 released
References: <BF571719A4041A478005EF3F08EA6DF062D0B5@pcsmail03.pcs.pc.ome.toshiba.co.jp>
In-Reply-To: <BF571719A4041A478005EF3F08EA6DF062D0B5@pcsmail03.pcs.pc.ome.toshiba.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomita, Haruo wrote:
> It may be unavoidable one that ata_piix does not work. 
> But, it is a problem that a DMA transfer does not enable by piix. 
> Don't you think so?


This is unavoidable.  Two drivers grabbing the same PCI I/O range is
dangerous.

Now that libata supports PATA, it would be easier to let libata support
both SATA and PATA.  Since that is a single driver, it makes DMA easy to
support for both SATA/PATA.

If libata does this, there needs to be a "ide=disable" or
"legacy_ide=libata" switch added somewhere, for the cases (most distros)
where IDE driver is built-in.

	Jeff


