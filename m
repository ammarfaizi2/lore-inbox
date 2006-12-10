Return-Path: <linux-kernel-owner+w=401wt.eu-S1762488AbWLJUtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762488AbWLJUtO (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 15:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762514AbWLJUtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 15:49:14 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:33439 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1762488AbWLJUtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 15:49:13 -0500
Date: Sun, 10 Dec 2006 12:49:07 -0800
From: Paul Jackson <pj@sgi.com>
To: Jay Cliburn <jacliburn@bellsouth.net>
Cc: linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [BUG] commit 3c517a61, slab: better fallback allocation
 behavior
Message-Id: <20061210124907.60c4a0aa.pj@sgi.com>
In-Reply-To: <457C64C5.9030108@bellsouth.net>
References: <457C64C5.9030108@bellsouth.net>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good report - thanks.

Christoph - fallback_alloc() can be called with interrupts off.

I fixed the cpuset_zone_allowed() call from fallback_alloc() to avoid
sleeping.  Notice the __GFP_HARDWALL added in Linus's version, or the
new function cpuset_zone_allowed_hardwall() in Andrew's version, all
done in the last week.

But apparently kmem_getpages() can also sleep, as it calls __alloc_pages().

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
