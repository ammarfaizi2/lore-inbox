Return-Path: <linux-kernel-owner+w=401wt.eu-S932894AbXAADig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932894AbXAADig (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 22:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933245AbXAADig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 22:38:36 -0500
Received: from flex.com ([206.126.0.13]:59684 "EHLO flex.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932894AbXAADif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 22:38:35 -0500
Message-ID: <45988210.7070300@flex.com>
Date: Sun, 31 Dec 2006 19:37:52 -0800
From: David Kahn <dmk@flex.com>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
CC: hch@infradead.org, wmb@firmworks.com, devel@laptop.org,
       linux-kernel@vger.kernel.org, jg@laptop.org
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
References: <45978CE9.7090700@flex.com>	<20061231.024917.59652177.davem@davemloft.net>	<20061231154103.GA7409@infradead.org> <20061231.124612.21926488.davem@davemloft.net>
In-Reply-To: <20061231.124612.21926488.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Folks,

If we reused the current code in fs/proc/proc_devtree.c
and re-wrote the underlying of_* routines for i386 only,
(in the hope of removing the complexity not needed for
this implementation) would that be an acceptable
implementation?

In other words, the of_* routines continue to define the
interface between kernel and the firmware/OS
layer. Although that code in proc_devtree.c defining
the functions duplicate_name() and fixup_name() is still
troubling to me.

IMHO, the directory entries in the filesystem
should be in the form "node-name@unit-address" (eg: /pci@1f,0,
"pci" is the node name, "@" is the separator character defined
by IEEE 1275, and "1f,0" is the unit-address,
which are always guaranteed to be unique. That's part of the
reason we did a separate implementation. I'm not sure
how we'll resolve that part of it or what problem that
code is trying to resolve by changing the directory names
that appear in the filesystem in a rather odd way. It's
not possible to have two ambiguously fully qualified nodes in the OFW
device tree, otherwise you would never be able to select
a specific one by name.

-David

