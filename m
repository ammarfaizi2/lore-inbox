Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262112AbVBYXj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbVBYXj6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 18:39:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbVBYXj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 18:39:57 -0500
Received: from fire.osdl.org ([65.172.181.4]:56244 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262805AbVBYXiV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 18:38:21 -0500
Date: Fri, 25 Feb 2005 15:38:06 -0800
From: Chris Wright <chrisw@osdl.org>
To: Darren Hart <dvhltc@us.ibm.com>
Cc: Chris Wright <chrisw@osdl.org>, hugh@veritas.com, akpm@osdl.org,
       andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] allow vma merging with mlock et. al.
Message-ID: <20050225233806.GD15867@shell0.pdx.osdl.net>
References: <421E74B5.3040701@us.ibm.com> <20050225171122.GE28536@shell0.pdx.osdl.net> <20050225220543.GC15867@shell0.pdx.osdl.net> <421FA61B.9050705@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421FA61B.9050705@us.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Darren Hart (dvhltc@us.ibm.com) wrote:
> As I understand it, the reason we don't merge is because 
> it is expected that a task will lock and unlock the same memory range 
> more than once and we don't want to waste our time merging and splitting 
> the VMAs.

I don't have a good sampling of applications.  The one's I've used are
temporal like gpg, or they mlockall the whole thing and never look back.
But I did a quick benchmark since I was curious, a simple loop of a
million lock/unlock cycles of a page that could trigger a merge:

vanilla
(no merge): 659706 usecs

patched
(merge):    3567020 usecs

Heh, I was surprised to see it that much slower.

cheers,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
