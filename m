Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964977AbVI0Q0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbVI0Q0Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 12:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964985AbVI0Q0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 12:26:24 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:37356 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S964977AbVI0Q0X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 12:26:23 -0400
Date: Tue, 27 Sep 2005 09:26:00 -0700
From: Paul Jackson <pj@sgi.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: haveblue@us.ibm.com, mrmacman_g4@mac.com, jschopp@austin.ibm.com,
       akpm@osdl.org, lhms-devel@lists.sourceforge.net, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, kravetz@us.ibm.com
Subject: Re: [Lhms-devel] Re: [PATCH 1/9] add defrag flags
Message-Id: <20050927092600.2e9c7b47.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.58.0509271415460.12421@skynet>
References: <4338537E.8070603@austin.ibm.com>
	<43385412.5080506@austin.ibm.com>
	<21024267-29C3-4657-9C45-17D186EAD808@mac.com>
	<1127780648.10315.12.camel@localhost>
	<20050926224439.056eaf8d.pj@sgi.com>
	<Pine.LNX.4.58.0509271415460.12421@skynet>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel wrote:
> > If you have good reason to keep __GFP_USER meanin either user or buffer,
> > then perhaps the name __GFP_USER is misleading.
> >
> 
> Possibly but we are stuck for terminology here. It's hard to think of a
> good term that reflects the intention.

You make several good points.  How about:
  * Rename __GFP_USER to __GFP_EASYRCLM
  * Shift the two __GFP_*RCLM flags up to 0x80000u and 0x100000u
  * Leave __GFP_BITS_SHIFT at the 21 in your patch (and fix its comment)
    (or should we go up the next nibble, to 24?).

This results in the two key GFP defines being:

#define __GFP_EASYRCLM  0x80000u /* Easily reclaimed user or buffer page */
#define __GFP_KERNRCLM 0x100000u /* Reclaimable kernel page */

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
