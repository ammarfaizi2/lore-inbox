Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbWB0Pmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbWB0Pmz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 10:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964779AbWB0Pmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 10:42:54 -0500
Received: from ns1.suse.de ([195.135.220.2]:48807 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964786AbWB0Pmc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 10:42:32 -0500
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [Patch 4/4] Tell GCC 4.1 to move unlikely() code to a separate section
Date: Mon, 27 Feb 2006 16:39:34 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
References: <1141053825.2992.125.camel@laptopd505.fenrus.org> <1141054284.2992.136.camel@laptopd505.fenrus.org>
In-Reply-To: <1141054284.2992.136.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602271639.34776.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 February 2006 16:31, Arjan van de Ven wrote:
> This patch is more controversial I assume; it offers the option 
> to use the gcc 4.1 option to move unlikely() code to a separate section.
> On the con side, this means that longer byte sequences are needed to jump
> to this code, on the Pro side it means that the unlikely() code isn't sharing
> icache cachelines and tlbs anymore.

I don't think this will do anything because the default Makefile
still has

CFLAGS += -fno-reorder-blocks 

That was me because it made assembly debugging much easier. I would be willing
to reconsider this if you can give me some hard data just from this change:
- benchmark changes
- .text size increase

Also I don't like it being an separate CONFIG options. We already have too many
obscure ones. Either it should be on by default or not there at all.

-Andi
