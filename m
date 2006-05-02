Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964793AbWEBNp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbWEBNp7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 09:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964818AbWEBNp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 09:45:59 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:33963 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964793AbWEBNp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 09:45:58 -0400
Date: Tue, 2 May 2006 14:45:36 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: Segher Boessenkool <segher@kernel.crashing.org>,
       Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org,
       paulus@samba.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>,
       linux-kernel@vger.kernel.org, cbe-oss-dev@ozlabs.org
Subject: Re: [PATCH 11/13] cell: split out board specific files
Message-ID: <20060502134536.GB26704@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Geoff Levand <geoffrey.levand@am.sony.com>,
	Segher Boessenkool <segher@kernel.crashing.org>,
	Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org,
	paulus@samba.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>,
	linux-kernel@vger.kernel.org, cbe-oss-dev@ozlabs.org
References: <20060429232812.825714000@localhost.localdomain> <20060429233922.167124000@localhost.localdomain> <F989FA67-91B5-493B-9A12-D02C3C14A984@kernel.crashing.org> <445690F7.5050605@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <445690F7.5050605@am.sony.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2006 at 03:51:35PM -0700, Geoff Levand wrote:
> makefiles don't have as rich a set of logical ops as the
> config files.  Its easy to express 'build A if B', but not
> so easy to do 'build A if not C'.  To make this work
> cleanly I made PPC_CELL denote !SOME_HYPERVISOR_THING,
> so I can have constructions like this in the makefile:
> 
> obj-$(CONFIG_PPC_CELL)	+= ...
> 
> I also got rid of SPUFS_PRIV1_MMIO, since SPUFS_PRIV1_MMIO
> just meant spufs with !SOME_HYPERVISOR_THING.

The Kconfig files has lots of nice operators.

Anyway, until we actually have the cell common hypervisor interface
out in the public adding any support for it in Kconfig or the
Makefile is completely pointless, and a patch like this even when
done correctly shouldn't go in.


> Split the Cell BPA support into generic and platform
> dependant parts.
> 
> Creates new config variable CONFIG_PPC_IBM_CELL_BLADE.

That's wrong.  Most of these files will be needed to support
the PS3 when running on bare hardware.  The right option will
be CELL_SPIDER_HARDWARE, which is right now the only cell
hardware generation supported.  It'll become meaningfull when
adding axon support.

