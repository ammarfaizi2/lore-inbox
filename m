Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268801AbUHLVYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268801AbUHLVYK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 17:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268818AbUHLVYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 17:24:08 -0400
Received: from the-village.bc.nu ([81.2.110.252]:54229 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268807AbUHLVWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 17:22:20 -0400
Subject: Re: SG_IO and security
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040812182914.GA16953@suse.de>
References: <1092313030.21978.34.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0408120929360.1839@ppc970.osdl.org>
	 <Pine.LNX.4.58.0408120943210.1839@ppc970.osdl.org>
	 <20040812173532.GD5136@suse.de>  <20040812182914.GA16953@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092341997.22360.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 12 Aug 2004 21:19:58 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-08-12 at 19:29, Jens Axboe wrote:
> +static int sg_allowed_cmd(unsigned char opcode, int may_write)
> +{
> +	if (capable(CAP_SYS_RAWIO))
> +		return 1;
> +	if (may_write)
> +		return 1;

I agree with passing the data down, unfortunately anyone with a raw
device access they can open for write can still physically anihiliate
the hardware. That causes real problems for anyone allocating partitions
for databases like Oracle, giving direct user access to devices for
virtualization like UML, giving direct user access to a M/O drive.

It also doesn't solve the read/write outside of partition problem.


Alan

