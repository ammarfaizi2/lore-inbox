Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031273AbWK3TkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031273AbWK3TkY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 14:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031272AbWK3TkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 14:40:24 -0500
Received: from vs2067197.netfabrik.de ([85.25.67.197]:63202 "EHLO obenhuber.de")
	by vger.kernel.org with ESMTP id S1031273AbWK3TkX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 14:40:23 -0500
Subject: Re: [RFC] dynsched - different cpu schedulers per cpuset
From: Felix Obenhuber <felix@obenhuber.de>
To: Paul Menage <menage@google.com>
Cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org,
       dynsched-devel@lists.sourceforge.net
In-Reply-To: <6599ad830611300008n329ca4a5s133ac62a35bb8d06@mail.gmail.com>
References: <1164557189.10306.12.camel@athrose>
	 <20061129201310.54da1618.pj@sgi.com>
	 <6599ad830611300008n329ca4a5s133ac62a35bb8d06@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 30 Nov 2006 20:40:24 +0100
Message-Id: <1164915624.4784.32.camel@athrose>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Possibly, if it was some kind of multi-level scheduler - i.e. a
> top-level scheduler picks which container to run, and then a
> configurable per-container scheduler picks a task from that container.

What do you think about Plugsched? Peter Williams introduced a simple
scheduler interface for scheduler testing purposes. It should be
possible to integrate into your CPU Controller. The CPU Controller seems
to be quite suited for that purpose, as far as I can appraise after
reading some of your documentation.

Unfortunately, I didn't know about CKRM some months ago, when we decided
to use cpusets. As I wrote, Dynsched is a student project at sunset and
it's future is quite ambiguous. Maybe we'll find some time to take a
look at.

> But (having glanced at the code even less than you) it sounded like it
> was intended to be a single level scheduler, configured on a per-cpu
> basis. In that case tying it to (exclusive) cpusets sounds like it
> might be more reasonable.

You're right. We tie up the scheduler to cpus with some per_cpu
functionality, and chose cpusets for management, cause we didn't want
add another interface (e.g sysfs files for each cpu). Cpusets is quite
adequate for our purpose, but there are lots of issues we're currently
dealing with. Think about (not exclusive) subsets with different
schedulers...

Felix
