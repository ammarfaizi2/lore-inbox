Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbVAFVDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVAFVDq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 16:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263032AbVAFVAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 16:00:20 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:10437 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261173AbVAFU6F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 15:58:05 -0500
Message-ID: <41DDA6CB.6050307@sgi.com>
Date: Thu, 06 Jan 2005 14:59:55 -0600
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Paul Jackson <pj@sgi.com>, Steve Longerbeam <stevel@mwwireless.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
Subject: page migration patchset
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

Under the topic of modifying a processes's mems_allowed bitmask,
Paul Jackson has been telling me that this is hard, in general.
This is unfortunate, as part of the page migration work I am
doing, it seems that part of the necessary work is to change
the NUMA memory policy so newly allocated pages go onto the
new nodes.

Now I know there is no locking protection around the mems_allowed
bitmask, so changing this while the process is still running
sounds hard.  But part of the plan I am working under assumes
that the process is stopped before it is migrated.  (Shared
pages that are only shared among processes all of whom are to be
moved would similarly be handled; pages shsared among migrated
and non-migrated processes, e. g. glibc pages, would not
typically need to be moved at all, since they likely reside
somewhere outside the set of nodes to be migrated from.)

But if the process is suspended, isn't all that is needed just
to do the obvious translation on the mems_allowed vector?
(Similarly for the dedicated node stuff, I forget the name for
that at the moment...)

Am I missing something big here that makes this task harder
than I am thinking it is?
-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------
