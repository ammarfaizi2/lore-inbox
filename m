Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751279AbWGHAGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbWGHAGr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 20:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWGHAGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 20:06:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3771 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750770AbWGHAGn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 20:06:43 -0400
Date: Fri, 7 Jul 2006 17:10:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, davej@codemonkey.org.uk
Subject: Re: [PATCH] PCIE: create sysfs directory on first use
Message-Id: <20060707171015.688e4011.akpm@osdl.org>
In-Reply-To: <20060707165238.337c7a4a.rdunlap@xenotime.net>
References: <20060707165238.337c7a4a.rdunlap@xenotime.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rdunlap@xenotime.net> wrote:
>
> +			if (!pcie_dev_registered)
> +				pcie_port_bus_register();
> +

Wonderful.  You're forced to drop all error checking on the floor because
pcie_port_bus_register() assumes that nobody could possibly ever be
interested in actually checking for errors.

What happens if the bus_register() fails and the driver cheerily blunders
along assuming that pcie_port_bus_type is registered?  Incomprehensible lkml
oops reports, I'm suspecting..

Let's start stamping this out.  Could I please ask that you first prepare a
patch which fixes pcie_port_bus_register() (and mark it __must_check) and
then let's actually, like, check for errors?
