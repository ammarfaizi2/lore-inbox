Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262459AbVD2IZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbVD2IZH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 04:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262461AbVD2IZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 04:25:07 -0400
Received: from smtp.istop.com ([66.11.167.126]:13774 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S262260AbVD2IYp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 04:24:45 -0400
From: Daniel Phillips <phillips@istop.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Subject: Re: [PATCH 1b/7] dlm: core locking
Date: Fri, 29 Apr 2005 04:25:24 -0400
User-Agent: KMail/1.7
Cc: Daniel McNeil <daniel@osdl.org>, David Teigland <teigland@redhat.com>,
       Steven Dake <sdake@mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <20050425165826.GB11938@redhat.com> <1114706362.18352.85.camel@ibm-c.pdx.osdl.net> <20050428164529.GF21645@marowsky-bree.de>
In-Reply-To: <20050428164529.GF21645@marowsky-bree.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504290425.24485.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 April 2005 12:45, Lars Marowsky-Bree wrote:
> On 2005-04-28T09:39:22, Daniel McNeil <daniel@osdl.org> wrote:
> > Since a DLM is a distributed lock manager, its usage is entirely for
> > locking some shared resource (might not be storage, might be shared
> > state, shared data, etc).   If the DLM can grant a lock, but not
> > guarantee that other nodes (including the ones that have been kicked
> > out of the cluster membership) do not have a conflicting DLM lock, then
> > any applications that depend on the DLM for protection/coordination
> > be in trouble.  Doesn't the GFS code depend on the DLM not being
> > recovered until after fencing of dead nodes?
>
> It makes a whole lot of sense to combine a DLM with (appropriate)
> fencing so that the shared resources are protected. I understood David's
> comment to rather imply that fencing is assumed to happen outside the
> DLM's world in a different component; ie more of a comment on sane
> modularization instead of sane real-world configuration.

But just because fencing is supposed to happen in an external component, 
we can't wave our hands at it and skip the analysis.  We _must_ identify the 
fencing assumptions and trace the fencing paths with respect to every 
recovery algorithm in every cluster component, including the dlm.

I suspect that when we do get around to properly scrutinizing fencing 
requirements of specific recovery algorithms, we will find that the fencing 
system currently on offer for gfs needs a little work.

Regards,

Daniel
