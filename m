Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265229AbUGTDH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265229AbUGTDH1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 23:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265245AbUGTDH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 23:07:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2780 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265229AbUGTDHZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 23:07:25 -0400
Date: Mon, 19 Jul 2004 20:06:08 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, vojtech@suse.cz, zaitcev@redhat.com
Subject: Re: [PATCH][2.4 Backport] x445 usb legacy fix
Message-Id: <20040719200608.280d17a1@lembas.zaitcev.lan>
In-Reply-To: <1090289222.1388.461.camel@cog.beaverton.ibm.com>
References: <1090289222.1388.461.camel@cog.beaverton.ibm.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jul 2004 19:07:03 -0700
john stultz <johnstul@us.ibm.com> wrote:

The patch looks a little dirty in small places, e.g. the double
semicolon, the HZ/100 instead of HZ/10, space, two variables
named "base" in two blocks. I do not believe Vojtech wrote it.
He must have gotten it from someone else.

> While Greg was cautious that this method couldn't always be used, I've
> added to Vojtech's patch a boot option which allows you to specify
> "no-usb-legacy". Additionally this patch enables the "no-usb-legacy"
> option by default for x440/x445 systems.

The boot option may be useful, but in the core of the patch looks
like like a roundabout way to do things. Why don't you trigger
the meat of the quirk from, say, a DMI scan?

> +	{ PCI_FIXUP_FINAL,	PCI_ANY_ID,		PCI_ANY_ID,		quirk_usb_disable_smm_bios },

This looks like a bizzare place to use as a hook. The x400 and x445
obviously have their own bridges with own IDs (their NUMA cannot
be using Intel parts, right?). So why don't hook off that?

IIRC, we don't have 7 level of initcalls in 2.4, so perhaps you
need that particular hook location. But it just looks wrong.

The routines to take ownership look sane from USB HC access
(not sane from C programming standpoint, as I mentioned above).

But in any case, it's not something I can decide. Marcelo has that
power for stock kernels, and for Red Hat kernels there's a process
which starts with Bugzilla.

-- Pete
