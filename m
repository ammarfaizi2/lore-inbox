Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422687AbWJFTZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422687AbWJFTZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 15:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbWJFTZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 15:25:56 -0400
Received: from mga09.intel.com ([134.134.136.24]:17039 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S932461AbWJFTZz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 15:25:55 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,273,1157353200"; 
   d="scan'208"; a="141473399:sNHT755588855"
Date: Fri, 6 Oct 2006 12:25:21 -0700
From: Valerie Henson <val_henson@linux.intel.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Matthew Wilcox <matthew@wil.cx>, netdev@vger.kernel.org,
       Helge Deller <deller@parisc-linux.org>,
       Kyle McMartin <kyle@parisc-linux.org>,
       Richard Henderson <rth@twiddle.net>,
       Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: More info on section mismatches (was Re: [PATCH] [TULIP] Fix section mismatch in de2104x.c)
Message-ID: <20061006192520.GB8620@goober>
References: <11601583542790-git-send-email-matthew@wil.cx> <4526A2ED.6030406@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4526A2ED.6030406@garzik.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2006 at 02:39:41PM -0400, Jeff Garzik wrote:
> Matthew Wilcox wrote:
> >From: Helge Deller <deller@parisc-linux.org>
> >
> >WARNING: drivers/net/tulip/de2104x.o - Section mismatch: reference to 
> >.init.text:de_init_one from .data.rel.local after 'de_driver' (at offset 
> >0x20)
> >WARNING: drivers/net/tulip/de2104x.o - Section mismatch: reference to 
> >.exit.text:de_remove_one from .data.rel.local after 'de_driver' (at offset 
> >0x28)
> 
> I'm a bit blind, so help me out here...  what precisely is mismatched?
> 
> AFAICS everything is properly marked __init or __exit.

(Cc'd Richard Henderson as resident gcc guru.)

We're discussing a way to get more information out of section mismatch
reports so that the causes of section mismatches are a little more
obvious.  I'd like to see something like:

foo() is marked __init at line 34
bar() calls foo() at line 57

Arjan points out that optimization may make this difficult; I'm happy
with a separate script running at a lower level of optimization that
you can run by hand when one of these warnings shows up.

Ideas?

-VAL
