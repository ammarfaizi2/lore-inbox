Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbVCHHHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVCHHHL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 02:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbVCHHGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 02:06:01 -0500
Received: from isilmar.linta.de ([213.239.214.66]:30672 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261179AbVCHHF1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 02:05:27 -0500
Date: Tue, 8 Mar 2005 08:05:22 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: dereferencing module-internal pointer in scripts/mod/file2alias.c
Message-ID: <20050308070522.GA5435@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is there any feasible way to dereference a pointer inside
__mod_*_device_table which points to a string? 

e.g.:

include/linux/mod_devicetable.h:

struct pcmcia_device_id {
	...
	const char * prod_id;
	...
}

drivers/some/driver.c:

static struct pcmcia_device_id some_ids[] = {
	{.prod_id = "some device string", ...},
	...
}
MODULE_DEVICE_TABLE(some_ids);


scripts/mod/file2alias.c:

do_pcmcia_entry (..., struct pcmcia_device_id *id, ...) 
{
	const char *tmp = id->prod_id + SOME_MAGIC_VALUE;
}


Thanks,
	Dominik
