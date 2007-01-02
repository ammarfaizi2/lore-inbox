Return-Path: <linux-kernel-owner+w=401wt.eu-S932626AbXABAIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932626AbXABAIW (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 19:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932636AbXABAIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 19:08:22 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:37652 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932626AbXABAIV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 19:08:21 -0500
Subject: Re: [RFC] MTD driver for MMC cards
From: David Woodhouse <dwmw2@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Pierre Ossman <drzeus-mmc@drzeus.cx>, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org,
       =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
In-Reply-To: <200701012322.14735.arnd@arndb.de>
References: <200612281418.20643.arnd@arndb.de> <4597ADD2.90700@drzeus.cx>
	 <200701012322.14735.arnd@arndb.de>
Content-Type: text/plain
Date: Tue, 02 Jan 2007 00:08:40 +0000
Message-Id: <1167696520.18169.26.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2007-01-01 at 23:22 +0100, Arnd Bergmann wrote:
> There are multiple efforts in progress to get a jffs2 replacement. NAND
> flash in embedded devices has the same size as it has on MMC card
> potentially, so we will need one soon. David Woodhouse has pushed the
> limit that jffs2 can reasonably used to 512MB, which is the size used
> in the OLPC XO laptop. If there are ways to get beyond that (which I
> find unlikely), there will be a hard limit 2GB or 4GB because of
> limitations in the fs layout.

The main weakness of JFFS2 (at this kind of size) is that there _is_ no
fs layout -- so there isn't a hard 2GiB or 4GiB limit in the format,
because we never encode offsets anywhere but in memory.

We'll push JFFS2 further than the current 512MiB by enlarging the data
nodes -- so each node covers something like 16KiB of data instead of
only 4KiB, and then there'll be about 1/3 as many of them, which will
cut the memory usage and reduce the amount we need to read in the
"summary" blocks. But logfs is the way forward, I agree.

-- 
dwmw2

