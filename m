Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263086AbVG3R63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263086AbVG3R63 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 13:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263090AbVG3R61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 13:58:27 -0400
Received: from graphe.net ([209.204.138.32]:60804 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S263086AbVG3R45 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 13:56:57 -0400
Date: Sat, 30 Jul 2005 10:56:55 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Paul Jackson <pj@sgi.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] String conversions for memory policy
In-Reply-To: <20050729230026.1aa27e14.pj@sgi.com>
Message-ID: <Pine.LNX.4.62.0507301042420.26355@graphe.net>
References: <Pine.LNX.4.62.0507291137240.3864@graphe.net>
 <20050729152049.4b172d78.pj@sgi.com> <Pine.LNX.4.62.0507291746000.8663@graphe.net>
 <20050729230026.1aa27e14.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jul 2005, Paul Jackson wrote:

> Oh - I should have mentioned this before - if you are displaying and
> parsing node lists (nodemask_t) then there are wrappers for these
> bitmap routines in linux/nodemask.h:
> 
>  * int nodemask_scnprintf(buf, len, mask) Format nodemask for printing
>  * int nodemask_parse(ubuf, ulen, mask)   Parse ascii string as nodemask
>  * int nodelist_scnprintf(buf, len, mask) Format nodemask as list for printing
>  * int nodelist_parse(buf, map)           Parse ascii string as nodelist
> 
> See nodemask.h for other such useful routines.

Hmmm. Would be great if we had a nodelist in the policy structure but it 
is a zonelist instead and my conversion functions deal with zonelists and 
not nodelists. Strangely mpol_new converts a node bit mask into a 
list of zones.

As a consequence the zonelist always begins with zones of the lowest node. 
Page allocation will therefore always fill up the lower nodes before going
to the higher nodes. Is this what we intended? I would have expected that 
BIND would restrict to a set of nodes and then allocate locally on the 
node the process is running on if possible. That is at least what I 
gather from reading the documentation.

Maybe I do not fully understand what is going on here but this kind of 
implementation for bind must be hurting performance of applications by 
not allocating pages locally. It also puts extremely high 
memory pressure on lower numbered nodes.
