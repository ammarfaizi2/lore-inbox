Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbVBRRMC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbVBRRMC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 12:12:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbVBRRLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 12:11:34 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:58024 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261404AbVBRRJ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 12:09:58 -0500
Message-ID: <42161FBF.70200@sgi.com>
Date: Fri, 18 Feb 2005 11:02:55 -0600
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Andi Kleen <ak@muc.de>, Ray Bryant <raybry@austin.rr.com>,
       linux-mm <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 2.6.11-rc2-mm2 0/7] mm: manual page migration -- overview
 II
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com> <m1vf8yf2nu.fsf@muc.de> <42114279.5070202@sgi.com> <20050215121404.GB25815@muc.de> <421241A2.8040407@sgi.com> <20050215214831.GC7345@wotan.suse.de> <4212C1A9.1050903@sgi.com> <20050217235437.GA31591@wotan.suse.de>
In-Reply-To: <20050217235437.GA31591@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

> You and Robin mentioned some problems with "double migration"
> with that, but it's still not completely clear to me what
> problem you're solving here. Perhaps that needs to be reexamined.
> 
> 
There is one other case where Robin and I have talked about double
migration.  That is the case where the set of old nodes and new
nodes overlap.  If one is not careful, and the system call interface
is assumed to be something like:

page_migrate(pid, old_node, new_node);

then if one is not careful (and depending on what the complete list
of old_nodes and new_nodes are), then if one does something like:

page_migrate(pid, 1, 2);
page_migrate(pid, 2, 3);

then you can end up actually moving pages from node 1 to node 2,
only to move them again from node 2 to node 3.  This is another
form of double migration that we have worried about avoiding.

-- 
-----------------------------------------------
Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
	 so I installed Linux.
-----------------------------------------------

