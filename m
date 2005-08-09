Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbVHIVgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbVHIVgO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 17:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbVHIVgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 17:36:14 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:48026 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750783AbVHIVgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 17:36:13 -0400
Date: Tue, 9 Aug 2005 23:36:00 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Chris Wright <chrisw@osdl.org>
cc: 7eggert@gmx.de, David Madore <david.madore@ens.fr>,
       Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: capabilities patch (v 0.1)
In-Reply-To: <20050809205206.GW7762@shell0.pdx.osdl.net>
Message-ID: <Pine.LNX.4.58.0508092259570.9779@be1.lrz>
References: <4zuQJ-20d-11@gated-at.bofh.it> <4zv0l-2b8-11@gated-at.bofh.it>
 <E1E2aaq-0002WB-Tj@be1.lrz> <20050809205206.GW7762@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Aug 2005, Chris Wright wrote:
> * Bodo Eggert (harvested.in.lkml@7eggert.dyndns.org) wrote:
> > Chris Wright <chrisw@osdl.org> wrote:
> > > * David Madore (david.madore@ens.fr) wrote:

> > >> * Second, a much more extensive change, the patch introduces a third
> > >> set of capabilities for every process, the "bounding" set.  Normally
> > > 
> > > this is not a good idea.  don't add more sets. if you really want to
> > > work on this i'll give you all the patches that have been done thus far,
> > > plus a set of tests that look at all the execve, ptrace, setuid type of
> > > corner cases.
> > 
> > How are you going to tell processes that may exec suid (or set-capability-)
> > programs from those that aren't supposed to gain certain capabilities?
> 
> typically you'd expect exec suid will reset to full caps.

ACK, but

1) I wouldn't want an exploited service to gain any privileges, even by
   chaining userspace exploits (e.g. exec sendmail < exploitstring).  For
   most services, I'd like CAP_EXEC being unset (but it doesn't exist).

2) There are environments (linux-vserver.org) which limit root to a subset
   of capabilities. I think they might use that feature, too. Off cause a
   simple "suid bit" == "all capabilities" scheme won't work there.

-- 
"Just because you are paranoid, do'nt mean they're not after you."
	-- K.Cobain
