Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbVIZKqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbVIZKqO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 06:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbVIZKqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 06:46:14 -0400
Received: from grendel.sisk.pl ([217.67.200.140]:57776 "HELO grendel.sisk.pl")
	by vger.kernel.org with SMTP id S1750764AbVIZKqO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 06:46:14 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH][Fix] Prevent swsusp from corrupting page translation tables during resume on x86-64
Date: Mon, 26 Sep 2005 12:46:18 +0200
User-Agent: KMail/1.8.2
Cc: kernel list <linux-kernel@vger.kernel.org>, Andi Kleen <ak@muc.de>
References: <200509241936.12214.rjw@sisk.pl> <20050925220738.GF2775@elf.ucw.cz>
In-Reply-To: <20050925220738.GF2775@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509261246.19085.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday, 26 of September 2005 00:07, Pavel Machek wrote:
> Hi!
> 
> > The following patch fixes Bug #4959.  It creates temporary page translation
> > tables located in the page frames that are not overwritten by swsusp while copying
> > the image.
> > 
> > The temporary page translation tables are generally based on the existing ones
> > with the exception that the mappings using 4KB pages are replaced with the
> > equivalent mappings that use 2MB pages only.  The temporary page tables are
> > only used for copying the image.
> 
> Would not it be simpler to create them from scratch? mm/init.c has
> some handy functions, they should be applicable. [init_memory_mapping,
> phys_pud_init]. Perhaps even initialize only simple direct mapping,
> and place virt_to_phys() at strategic places?

Perhaps, but the outcome would be very much the same.  The problem is to what
extent we can use the existing constructs, because I'd rather like to avoid the situation
in which any future changes to the initialization code would have to be replicated
in the swsusp code.  I'll have a look at that, but I'm not sure.  Also I don't really know
what the Andi's preferences are with this respect.

Anyway do you think that creating temporary page tables at the beginning of
swsusp_arch_resume() is a good idea?  If not, where do you think should they be
created?

Greetings,
Rafael
