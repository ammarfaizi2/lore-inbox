Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751069AbWBWSZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbWBWSZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 13:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWBWSZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 13:25:57 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:6272 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751069AbWBWSZ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 13:25:57 -0500
Date: Thu, 23 Feb 2006 10:25:48 -0800
From: Paul Jackson <pj@sgi.com>
To: Arjan van de Ven <arjan@intel.linux.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, akpm@osdl.org
Subject: Re: [Patch 3/3] prepopulate/cache cleared pages
Message-Id: <20060223102548.17ce2184.pj@sgi.com>
In-Reply-To: <1140686994.4672.4.camel@laptopd505.fenrus.org>
References: <1140686238.2972.30.camel@laptopd505.fenrus.org>
	<1140686994.4672.4.camel@laptopd505.fenrus.org>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a random idea, offered with little real understanding
of what's going on ...

  Instead of a per-task clear page, how about a per-cpu clear page,
  or short queue of clear pages?

  This lets the number of clear pages be throttled to whatever
  is worth it.  And it handles such cases as a few threads using
  the clear pages rapidly, while many other threads don't need any,
  with a much higher "average usefulness" per clear page (meaning
  the average time a cleared page sits around wasting memory prior
  to its being used is much shorter.)

  Some locking would still be needed, but per-cpu locking is
  a separate, quicker beast than something like mmap_sem.

Mind you, I am not commenting one way or the other on whether any
of this is a good idea.  Not my expertise ...

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
