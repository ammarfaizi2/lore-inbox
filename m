Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263091AbUDATdn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 14:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262770AbUDATdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 14:33:39 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:42961 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263091AbUDATa3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 14:30:29 -0500
Subject: Re: CONFIG_DEBUG_PAGEALLOC and virt_addr_valid()
From: Dave Hansen <haveblue@us.ibm.com>
To: "Sridhar Samudrala [imap]" <sri@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0404011105120.1956@localhost.localdomain>
References: <Pine.LNX.4.58.0404011105120.1956@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1080847824.24060.39.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 01 Apr 2004 11:30:24 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-01 at 11:11, Sridhar Samudrala wrote:
> When CONFIG_DEBUG_PAGEALLOC is enabled, i am noticing that virt_addr_valid()
> (called from sctp_is_valid_kaddr()) is returning true even for freed objects.
> Is this a bug or expected behavior?

It's expected.  Right now it just makes sure the address translates to a
valid pfn.  Figuring out whether there are actually pagetables
underneath that address would require a pagetable walk.  

Don't we unmap things when they are free'd with CONFIG_DEBUG_PAGEALLOC? 
I guess we could add a pagetable walk in the debug case to
virt_addr_valid(), but it would probably make CONFIG_DEBUG_PAGEALLOC
even more of a dog than it already is.  

-- Dave

