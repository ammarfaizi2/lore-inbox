Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750916AbVHLSlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbVHLSlp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 14:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbVHLSlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 14:41:45 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:56408 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750915AbVHLSlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 14:41:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Disposition:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=55pSjHLNaUDhTQaZBPPbPbmMDgDXUFA/dNFtXZ7CJ+t4qX0DD6ja8LmvUUQswaw9LvONGOQAdFuSe3oYzfLpK9+eCRjecS8h3JnB//dlMaqVXos+fLL6Gu5JgnBTi7ps/6FnxOxQOMEk7XVv5BA0kl26fNLIyWxDex9gLo8Oltg=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Jeff Dike <jdike@addtoit.com>
Subject: Re: [patch 1/3] uml: share page bits handling between 2 and 3 level pagetables
Date: Fri, 12 Aug 2005 20:37:38 +0200
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
References: <20050728185655.9C6ADA3@zion.home.lan> <20050730160218.GB4585@ccure.user-mode-linux.org>
In-Reply-To: <20050730160218.GB4585@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200508122037.38473.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 30 July 2005 18:02, Jeff Dike wrote:
> On Thu, Jul 28, 2005 at 08:56:53PM +0200, blaisorblade@yahoo.it wrote:
> > As obvious, a "core code nice cleanup" is not a "stability-friendly
> > patch" so usual care applies.

> These look reasonable, as they are what we discussed in Ottawa.

> I'll put them in my tree and see if I see any problems.  I would
> suggest sending these in early after 2.6.13 if they seem OK.

I've discovered that we're not the only one to miss dirty / accessed 
"hardware" bits: see include/asm-alpha/pgtable.h (they don't have the 
accessed bit). So maybe we could drop the "fault-on-access" thing.

Also, note the comment before handle_pte_fault:
/*
 * These routines also need to handle stuff like marking pages dirty
 * and/or accessed for architectures that don't do it in hardware (most
 * RISC architectures).  The early dirtying is also good on the i386.
 */

I'm not able to find where we clean the dirty bit on a pte, however it's not 
only done by pte_mkclean, there are some macros like ptep_clear... in 
asm-generic/pgtable.h
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
