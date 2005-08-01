Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbVHAXYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbVHAXYW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 19:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbVHAXYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 19:24:22 -0400
Received: from graphe.net ([209.204.138.32]:20924 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261336AbVHAXYU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 19:24:20 -0400
Date: Mon, 1 Aug 2005 16:24:19 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Paul Jackson <pj@sgi.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
Subject: Re: [PATCH] String conversions for memory policy
In-Reply-To: <20050801160351.71ee630a.pj@sgi.com>
Message-ID: <Pine.LNX.4.62.0508011618120.9351@graphe.net>
References: <Pine.LNX.4.62.0507291137240.3864@graphe.net>
 <20050729152049.4b172d78.pj@sgi.com> <Pine.LNX.4.62.0507291746000.8663@graphe.net>
 <20050729230026.1aa27e14.pj@sgi.com> <Pine.LNX.4.62.0507301042420.26355@graphe.net>
 <20050730181418.65caed1f.pj@sgi.com> <Pine.LNX.4.62.0507301814540.31359@graphe.net>
 <20050730190126.6bec9186.pj@sgi.com> <Pine.LNX.4.62.0507301904420.31882@graphe.net>
 <20050730191228.15b71533.pj@sgi.com> <Pine.LNX.4.62.0508011147030.5541@graphe.net>
 <20050801160351.71ee630a.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Aug 2005, Paul Jackson wrote:

> In your related patch, you show how to merge this display of mempolicy
> into the new /proc/<pid>/smap (rss size of each memory area) file.
> But this smap file (or, as you renamed it, emap file) is read-only,
> so far as I can tell.  It enables display of information, but not
> changing it.  How do you propose to support changing a memory policy?

That is not clear yet. We need to discuss that. First I thought of just
having a patch that creates /proc/<pid>/numa_policy which allows
to read and write the process policy (write via notifier not directly).

> that other half should not also be used to display memory policies,
> instead of adapting smap aka emap.

e/smap is a generic way to get information about storage use of a vma. 
Therefore displaying numa node information etc there makes a lot of 
sense.

> Would it be better to have two files, the first of which has one of
> the strings:

Yes. I initially had something like that in mind and have a partial 
implementation but such an approach gets extremely complicated and 
difficult to handle since you need to create multiple 
levels of directories in /proc/<pid>/xx. It is easier to obtain the 
complete memory information from a single file. We already have that in 
/proc/<pid>/maps.
