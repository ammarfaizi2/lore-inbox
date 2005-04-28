Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262164AbVD1QkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbVD1QkF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 12:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262167AbVD1QkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 12:40:04 -0400
Received: from fire.osdl.org ([65.172.181.4]:5276 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262164AbVD1Qjr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 12:39:47 -0400
Subject: Re: [PATCH 1b/7] dlm: core locking
From: Daniel McNeil <daniel@osdl.org>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: David Teigland <teigland@redhat.com>, Steven Dake <sdake@mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050428123315.GP21645@marowsky-bree.de>
References: <20050425165826.GB11938@redhat.com>
	 <1114466097.30427.32.camel@persist.az.mvista.com>
	 <20050426054933.GC12096@redhat.com>
	 <1114537223.31647.10.camel@persist.az.mvista.com>
	 <20050427030217.GA9963@redhat.com> <20050427134142.GZ4431@marowsky-bree.de>
	 <20050427142638.GG16502@redhat.com>
	 <20050428123315.GP21645@marowsky-bree.de>
Content-Type: text/plain
Message-Id: <1114706362.18352.85.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 28 Apr 2005 09:39:22 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-28 at 05:33, Lars Marowsky-Bree wrote:
> On 2005-04-27T22:26:38, David Teigland <teigland@redhat.com> wrote:
<snip>
> 
> > > And, I assume that the delivery of a "node down" membership event
> > > implies that said node also has been fenced.
> > Typically it does if you're combining the dlm with something that requires
> > fencing (like a file system).  Fencing isn't relevant to the dlm itself,
> > though, since the dlm software isn't touching any storage.
> 
> Ack. Good point, I was thinking too much in terms of GFS/OCFS2 here ;-)
> 

Since a DLM is a distributed lock manager, its usage is entirely for
locking some shared resource (might not be storage, might be shared
state, shared data, etc).   If the DLM can grant a lock, but not
guarantee that other nodes (including the ones that have been kicked
out of the cluster membership) do not have a conflicting DLM lock, then
any applications that depend on the DLM for protection/coordination
be in trouble.  Doesn't the GFS code depend on the DLM not being
recovered until after fencing of dead nodes?

Is there a existing DLM that does not depend on fencing? (you said
yours was modeled after the VMS DLM, didn't they depend on fencing?)

How would an application use a DLM that does not depend on fencing?

Thanks,

Daniel



 

