Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261819AbVBOTAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbVBOTAO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 14:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbVBOTAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 14:00:14 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:56501 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261819AbVBOTAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 14:00:06 -0500
Date: Tue, 15 Feb 2005 12:59:43 -0600
From: Robin Holt <holt@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: Robin Holt <holt@sgi.com>, haveblue@us.ibm.com, raybry@sgi.com,
       taka@valinux.co.jp, hugh@veritas.com, akpm@osdl.org,
       marcello@cyclades.com, raybry@austin.rr.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC 2.6.11-rc2-mm2 7/7] mm: manual page migration -- sys_page_migrate
Message-ID: <20050215185943.GA24401@lnx-holt.americas.sgi.com>
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com> <20050212032620.18524.15178.29731@tomahawk.engr.sgi.com> <1108242262.6154.39.camel@localhost> <20050214135221.GA20511@lnx-holt.americas.sgi.com> <1108407043.6154.49.camel@localhost> <20050214220148.GA11832@lnx-holt.americas.sgi.com> <20050215074906.01439d4e.pj@sgi.com> <20050215162135.GA22646@lnx-holt.americas.sgi.com> <20050215083529.2f80c294.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050215083529.2f80c294.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2005 at 08:35:29AM -0800, Paul Jackson wrote:
> What about the suggestion I had that you sort of skipped over, which
> amounted to changing the system call from a node array to just one
> node:
> 
>     sys_page_migrate(pid, va_start, va_end, count, old_nodes, new_nodes);
> 
> to:
> 
>     sys_page_migrate(pid, va_start, va_end, old_node, new_node);
> 
> Doesn't that let you do all you need to?  Is it insane too?

Migration could be done in most cases and would only fall apart when
there are overlapping node lists and no nodes available as temp space
and we are not moving large chunks of data.

What is the fundamental concern with passing in an array of integers?
That seems like a fairly easy to verify item with very little chance
of breaking.  I don't feel the concern that others seem to.

I do see the benefit to those arrays as being a single pass through the
page tables, the ability to migrate without using a temporary node, and
reducing the number of times data is copied when there are overlapping
nodes.  To me, those seem to be very compelling reasons when compared
to the potential for a possible problem with an array of integers.

Thanks,
Robin
