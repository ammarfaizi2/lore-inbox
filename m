Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265199AbUFVUP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265199AbUFVUP4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 16:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265195AbUFVUM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 16:12:26 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:21848 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265655AbUFVULa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 16:11:30 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Brent Casavant <bcasavan@sgi.com>
Subject: Re: [PATCH] Add kallsyms_lookup() result cache
Date: Tue, 22 Jun 2004 16:10:17 -0400
User-Agent: KMail/1.6.2
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       Andrew Morton OSDL <akpm@osdl.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>, ak@suse.de
References: <1087605785.8188.834.camel@cube> <1087650315.8188.915.camel@cube> <Pine.SGI.4.58.0406221426580.27967@kzerza.americas.sgi.com>
In-Reply-To: <Pine.SGI.4.58.0406221426580.27967@kzerza.americas.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406221610.17077.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, June 22, 2004 3:45 pm, Brent Casavant wrote:
> On Sat, 19 Jun 2004, Albert Cahalan wrote:
> > I'm not so sure anything needs to be fixed, save for SGI upgrading
> > to a more modern procps. There are many more important things:
>
> OK, I looked into this more closely, and gave procps 3.2.1 a spin.
> This gives us a similar speedup (top now only consumes 60% of a CPU)
> to that which I obtained by cacheing symbol lookups and using an old
> procps.  This difference is certainly explainable by top now only
> obtaining wchan information for displayed processes.
>
> 60% is far better than 800%, so this is certainly progress.  However
> 60% is also still quite a bit of CPU time.  I'll spend some cycles
> trying to whittle it down some more, but I'm not all that hopeful.

Is the 60% mainly kernel or user time now?  There were some good ideas in this 
thread that we could use to speed up symbol table searching.  And if opening 
and reading /proc/kallsyms is taking a significant portion of the time, we 
could probably trim it down too by only reading it once and polling for 
module insertion/removal.

Jesse
