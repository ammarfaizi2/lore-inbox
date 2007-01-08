Return-Path: <linux-kernel-owner+w=401wt.eu-S1161279AbXAHXSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161279AbXAHXSK (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 18:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161269AbXAHXSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 18:18:10 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:51869 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161266AbXAHXSI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 18:18:08 -0500
Date: Mon, 8 Jan 2007 18:15:24 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Andrew Morton <akpm@osdl.org>
Cc: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, hch@infradead.org, viro@ftp.linux.org.uk,
       torvalds@osdl.org, mhalcrow@us.ibm.com,
       David Quigley <dquigley@fsl.cs.sunysb.edu>,
       Erez Zadok <ezk@cs.sunysb.edu>
Subject: Re: [PATCH 01/24] Unionfs: Documentation
Message-ID: <20070108231524.GA1269@filer.fsl.cs.sunysb.edu>
References: <1168229596580-git-send-email-jsipek@cs.sunysb.edu> <1168229596875-git-send-email-jsipek@cs.sunysb.edu> <20070108111852.ee156a90.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070108111852.ee156a90.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2007 at 11:18:52AM -0800, Andrew Morton wrote:
> On Sun,  7 Jan 2007 23:12:53 -0500
> "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu> wrote:
> 
> > +Modifying a Unionfs branch directly, while the union is mounted, is
> > +currently unsupported.
> 
> Does this mean that if I have /a/b/ and /c/d/ unionised under /mnt/union, I
> am not allowed to alter anything under /a/b/ and /c/d/?  That I may only
> alter stuff under /mnt/union?
 
That's correct.
 
> If so, that sounds like a significant limitation.

It is significant, and I am trying to figure out a nice clean way to allow
_all_ stackable filesystems (yes, ecryptfs which is in vanilla has the same
problem too) to have data modified under them without any cache incoherence.

> > Any such change can cause Unionfs to oops, or stay
> > silent and even RESULT IN DATA LOSS.
> 
> With a rather rough user interface ;)

That statement is meant to scare people away from modifying the lower fs :)
I tortured unionfs quite a bit, and it can oops but it takes some effort.

> Also, is it possible to add new branches to an existing union mount?  And
> to take old ones away?

Not in the code in the 20-odd patches, it is a minimal version of the code,
maade to be as clean as possible. I hope to   port the  more complex
features into this code when things like lower branch manipulation are fixed
in a real way - there have been suggestions of (ab)using inotify to keep
track of the lower files, but I would prefer to find a real solution.

Josef "Jeff" Sipek.

-- 
Research, n.:
  Consider Columbus:
    He didn't know where he was going.
    When he got there he didn't know where he was.
    When he got back he didn't know where he had been.
    And he did it all on someone else's money.
