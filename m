Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbVCHW7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbVCHW7k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 17:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbVCHW7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 17:59:40 -0500
Received: from fire.osdl.org ([65.172.181.4]:10191 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261568AbVCHW7b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 17:59:31 -0500
Date: Tue, 8 Mar 2005 14:54:57 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
cc: Andrew Morton <akpm@osdl.org>, linux-pcmcia@lists.infradead.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, jt@hpl.hp.com,
       Greg KH <greg@kroah.com>
Subject: Re: PCMCIA product id strings -> hashes generation at compilation
 time? [Was: Re: [patch 14/38] pcmcia: id_table for wavelan_cs]
In-Reply-To: <20050308191138.GA16169@isilmar.linta.de>
Message-ID: <Pine.LNX.4.58.0503081438040.13251@ppc970.osdl.org>
References: <20050227161308.GO7351@dominikbrodowski.de>
 <20050307225355.GB30371@bougret.hpl.hp.com> <20050307230102.GA29779@isilmar.linta.de>
 <20050307150957.0456dd75.akpm@osdl.org> <20050307232339.GA30057@isilmar.linta.de>
 <20050308191138.GA16169@isilmar.linta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 8 Mar 2005, Dominik Brodowski wrote:
>
>				 Unfortunately, these strings cannot
> be passed to userspace for easy userspace-based loading of appropriate
> modules (MODNAME -- hotplug), so my suggestion is to also store crc32 hashes
> of the strings in the MODULE_DEVICE_TABLEs, e.g.:
> 
> PCMCIA_DEVICE_PROD_ID12("LINKSYS", "E-CARD", 0xf7cb0b07, 0x6701da11),

Hmm.. I'm with Andrew on this one - I'd much rather really pass them to 
user space as strings. We already pass a number of strings as environment 
variables.

In fact, what's wrong with DEVPATH? Which we already expose as the
NAME=xxx environment variable. So if the kboject associated with a device
has has this string associated with its name (which it should), then 
hotplug will automatially pass that as the DEVPATH.

So if you just fill out the kobject name with the product ID's (well, 
with the proper escaping of strange characters, of course), everything 
should just work. No?

		Linus
