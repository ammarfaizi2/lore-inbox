Return-Path: <linux-kernel-owner+w=401wt.eu-S1750773AbXAIAZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbXAIAZH (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 19:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbXAIAZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 19:25:07 -0500
Received: from main.gmane.org ([80.91.229.2]:36258 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750774AbXAIAZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 19:25:06 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: [PATCH 01/24] Unionfs: Documentation
Date: Tue, 9 Jan 2007 01:19:48 +0100
Message-ID: <1pw35070vgjt0.vkrm8bjemedb$.dlg@40tude.net>
References: <20070108111852.ee156a90.akpm@osdl.org> <200701082051.l08KpV8b011212@agora.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-84-221-49-157.cust-adsl.tiscali.it
User-Agent: 40tude_Dialog/2.0.15.1
Cc: linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2007 15:51:31 -0500, Erez Zadok wrote:

> Now, we've discussed a number of possible solutions.  Thanks to suggestions
> we got at OLS, we discussed a way to hide the lower namespace, or make it
> readonly, using existing kernel facilities.  But my understanding is that
> even it'd work, it'd only address new processes: if an existing process has
> an open fd in a lower branch before we "lock up" the lower branch's name
> space, that process may still be able to make lower-level changes.
> Detecting such processes may not be easy.  What to do with them, once
> detected, is also unclear.  We welcome suggestions.

As a simple user without much knowledge of kernel internals, much less
so filesystems, couldn't something based on the same principle of
lsof+fam be used to handle these situations? lsof, if I'm not
mistaken, can tell a user if someone (and who) has fd opened on a file
system; and fam can notify other processes that a particular file has
been modified. Unionfs could use something like lsof (or som similar
ad hoc solution) to see if something has anything opened on a
filesystem, and it could use something like fam to detect changes in
the underlying filesystem and flush caches as appropriate.

Of course, this wouldn't solve "concurrent changes" problems, but this
could be made possible by having a system to synchronize locks across
filesystems.

-- 
Giuseppe "Oblomov" Bilotta

[W]hat country can preserve its liberties, if its rulers are not
warned from time to time that [the] people preserve the spirit of
resistance? Let them take arms...The tree of liberty must be
refreshed from time to time, with the blood of patriots and
tyrants.
	-- Thomas Jefferson, letter to Col. William S. Smith, 1787

