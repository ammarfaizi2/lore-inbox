Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261508AbUJ0ATr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbUJ0ATr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 20:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbUJ0ATr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 20:19:47 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:60105 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261508AbUJ0ATk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 20:19:40 -0400
Date: Wed, 27 Oct 2004 02:19:38 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: "J.A. Magallon" <jamagallon@able.es>
cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: kbuild dependencies and layout
In-Reply-To: <1098747145l.19825l.0l@werewolf.able.es>
Message-ID: <Pine.LNX.4.61.0410262008420.877@scrub.home>
References: <1098661432l.6459l.0l@werewolf.able.es> <Pine.LNX.4.61.0410251556430.17266@scrub.home>
 <1098747145l.19825l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 25 Oct 2004, J.A. Magallon wrote:

> (helps stripped...)
> I want to make PDC202XX_BURST and PDC202XX_FORCE be selectable if any of
> _OLD or _NEW is selected. So I wrote:
> 
> menu "Promise PDC support"
> config BLK_DEV_PDC202XX_OLD
>    tristate "PROMISE PDC202{46|62|65|67} support"
> config BLK_DEV_PDC202XX_NEW    tristate "PROMISE PDC202{68|69|70|71|75|76|77}
> support"
> config PDC202XX_BURST
>    bool "Special UDMA Feature"
>    depends on BLK_DEV_PDC202XX_OLD || BLK_DEV_PDC202XX_NEW
> config PDC202XX_FORCE
>    bool "Enable controller even if disabled by BIOS"
>    depends on BLK_DEV_PDC202XX_OLD || BLK_DEV_PDC202XX_NEW
> endmenu

Usually it already helps if the main options have some additional 
dependencies like "depends on PCI", which in this case is not needed 
anymore.
The other possibility is to put a dummy config symbol inbetween:

config PDC202XX_DUMMY
	bool

if it neither has prompt nor a default, it won't be saved, but I'd rather 
would like to avoid that for a minor esthetic problem.

bye, Roman
