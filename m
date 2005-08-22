Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbVHVUoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbVHVUoV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 16:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbVHVUoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 16:44:21 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:41959 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751143AbVHVUoU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 16:44:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=pG5t3yIZ0NSj+w4MGnrogFUjtwi7ro8BZvali+FsI/bmFze1EJOSytA9U0EDDnXWr8fNJrUKwU1ES0RrbKrgopUN8eKiA459LqqIn5FVkfzTVes+IrsLojxgyHVPyYiQMbTdNvB5kHrKi2vNSih7ldxt8gZnKs7g4msNt2wPj5A=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [patch 11/39] remap_file_pages protection support: add MAP_NOINHERIT flag
Date: Mon, 22 Aug 2005 18:06:33 +0200
User-Agent: KMail/1.8.1
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, akpm@osdl.org, jdike@addtoit.com,
       linux-kernel@vger.kernel.org
References: <20050812182123.C896324E7DD@zion.home.lan> <20050812204315.B21152@flint.arm.linux.org.uk>
In-Reply-To: <20050812204315.B21152@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508221806.33667.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 August 2005 21:43, Russell King wrote:
> On Fri, Aug 12, 2005 at 08:21:23PM +0200, blaisorblade@yahoo.it wrote:
> > From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> >
> > Add the MAP_NOINHERIT flag to arch headers, for use with
> > remap-file-pages.

> Does this mean ARM will break when these patches are merged?
Sorry for missing answer, I was disconnected.

Well, when they'll be merged in -mm you(and other archs) will see a bit of 
things screwing up, but *this* patch is trivial to port to all archs.

The real problem will be updating the PTE encoding macros (see pte_file and 
sys_remap_file_pages) to also store the page protections. Or at least pretend 
they do - things won't compile otherwise.

However, those patches stayed around in -mm for a while, since 2.6.4-rc2-mm1 
to 2.6.5-mm1, so the (basic) fixes will be of the same kind.

VM_FAULT_SIGSEGV is much more though, however. When VMA pages can change 
protection, permission checking must move to the generic VM. See patches for 
i386 about that (patches for other architectures are compile-only, and don't 
handle properly this aspect).

However, don't worry for now, we'll be discussing this on next try. Mass arch 
updating will happen after the patch has been set into its definitive shape.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
