Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262585AbTCITea>; Sun, 9 Mar 2003 14:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262592AbTCITdR>; Sun, 9 Mar 2003 14:33:17 -0500
Received: from AMarseille-201-1-2-231.abo.wanadoo.fr ([193.253.217.231]:24615
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S262585AbTCIT2J>; Sun, 9 Mar 2003 14:28:09 -0500
Subject: Re: SWSUSP Discontiguous pagedir patch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Patrick Mochel <mochel@osdl.org>,
       Nigel Cunningham <ncunningham@clear.net.nz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030307202759.GA2447@elf.ucw.cz>
References: <20030305180222.GA2781@zaurus.ucw.cz>
	 <Pine.LNX.4.33.0303070950030.991-100000@localhost.localdomain>
	 <20030307202759.GA2447@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047238788.12206.143.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 09 Mar 2003 20:39:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > - It's dependent on the same exact kernel being loaded.
> >
> > It should only be dependent on the binary format of the written metadata.
> 
> ...which leads to simpler design and few megabytes less transfered to
> / from disk. I do not think there's easy way to do it with different
> kernels. State of devices before switching to new kernel is important...

I don't think so.

IMHO, the "old" kernel (used for loading the suspend image) should
quiesce devices in a pretty "normal" way in the exact same way
kexec does (and using the same code path/driver notifiers). I see
no reason why there should be any kind of dependency between the
"loader" kernel and the "loaded" kernel in this regard.

In fact, I'm considering for PPC to just trash the "loader" kernel
when possible and directly load the suspend image from the bootloader

Ben.

