Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262547AbVBXXJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbVBXXJU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 18:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262551AbVBXXJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 18:09:20 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:24311 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262547AbVBXXJH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 18:09:07 -0500
Date: Thu, 24 Feb 2005 14:53:32 -0800
From: Chandra Seetharaman <sekharan@us.ibm.com>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, akpm@osdl.org,
       Rik van Riel <riel@redhat.com>, Chris Mason <mason@suse.com>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [PATCH] CKRM: 3/10 CKRM: Core ckrm, rcfs
Message-ID: <20050224225332.GB13400@chandralinux.beaverton.ibm.com>
References: <20050224211108.GA24969@kroah.com> <E1D4QYk-0004HB-00@w-gerrit.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1D4QYk-0004HB-00@w-gerrit.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2005 at 01:30:10PM -0800, Gerrit Huizenga wrote:
> > > 
> > > The classification engines can be loadable modules.
> > 
> > Then you have a race condition in the above code that needs to be fixed.
> > And no, using an atomic_t is not the solution.
> 
> Why not?  This simply gives an EBUSY if someone tries to load multiple
> classification engines in parallel - one wins, one loses.  I'm not sure
> if there is a higher level mutex on module loading that might even prevent
> this race although I wouldn't be surprised if there were.  If there is,
> I think this code might be removable.  If there isn't, it provides a
> first-one-wins approach.
> 
> Hmm.  Oh, partial answer to my own question...  I think in theory you
> could have a classification engine compiled into the kernel and another
> one built as a module.  But no, you still wouldn't have a race like this.
> All built-in CE's would be executed linearly, only module loads could
> potentially race.
> 
> Chandra, do you know if this is the only race this is protecting against?
> It is the only one I see at the moment.

We want to have only one CE active at any point of time, for that we need
to have some internal variable. using atomic helps us get that along with
protecting against a very unlikely race condition.

> 
> gerrit

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------
