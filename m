Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753923AbWKII63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753923AbWKII63 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 03:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753932AbWKII62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 03:58:28 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:8684 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1753923AbWKII62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 03:58:28 -0500
Subject: Re: Abysmal PATA IDE performance
From: Arjan van de Ven <arjan@infradead.org>
To: "J.A." =?ISO-8859-1?Q?Magall=F3n?= <jamagallon@ono.com>
Cc: Stephen.Clark@seclark.us,
       =?ISO-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
       Mark Lord <lkml@rtr.ca>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20061109094014.1c8b6bed@werewolf-wl>
References: <455206E7.2050104@seclark.us> <45526D50.5020105@rtr.ca>
	 <455277E1.3040803@seclark.us> <20061109020758.GA21537@atjola.homenet>
	 <4552A638.4010207@seclark.us>  <20061109094014.1c8b6bed@werewolf-wl>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 09 Nov 2006 09:58:20 +0100
Message-Id: <1163062700.3138.467.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Probably your drives are renamed.
> Before you had (wild guess, look at your boot log messages):
> - ata bus -> hdc,hdd
> - sata -> sda (if you really have any sata bus...)
> 
> Now all hdX become sdX, and PATA is detected _before_ SATA, so you names
> probaly became:
> - ata via libata -> sda (HD), sr0 (CDROM)
> - sata -> sdb.

on fedora this doesn't matter (due to mount-by-label)

the bigger problem I suspect is that the sata modules aren't part of the
initrd!

you can force the issue by adding

alias scsi_hostadapter1 ata_piix

to the /etc/modprobe.conf file, and then recreating the initrd
(see the mkinitrd tool, or just install the kernel rpm)



