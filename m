Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbVGTQd3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbVGTQd3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 12:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbVGTQd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 12:33:29 -0400
Received: from gate.in-addr.de ([212.8.193.158]:34204 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S261401AbVGTQd1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 12:33:27 -0400
Date: Wed, 20 Jul 2005 18:26:36 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: David Teigland <teigland@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-cluster@redhat.com,
       ocfs2-devel@oss.oracle.com
Subject: Re: [Ocfs2-devel] [RFC] nodemanager, ocfs2, dlm
Message-ID: <20050720162636.GL5416@marowsky-bree.de>
References: <20050718061553.GA9568@redhat.com> <20050719155214.GG13246@marowsky-bree.de> <20050720033546.GB9747@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050720033546.GB9747@redhat.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-07-20T11:35:46, David Teigland <teigland@redhat.com> wrote:

> > Also, eventually we obviously need to have state for the nodes - up/down
> > et cetera. I think the node manager also ought to track this.
> We don't have a need for that information yet; I'm hoping we won't ever
> need it in the kernel, but we'll see.

Hm, I'm thinking a service might have a good reason to want to know the
possible list of nodes as opposed to the currently active membership;
though the DLM as the service in question right now does not appear to
need such.

But, see below.

> There are at least two ways to handle this:
> 
> 1. Pass cluster events and data into the kernel (this sounds like what
> you're talking about above), notify the effected kernel components, each
> kernel component takes the cluster data and does whatever it needs to with
> it (internal adjustments, recovery, etc).
> 
> 2. Each kernel component "foo-kernel" has an associated user space
> component "foo-user".  Cluster events (from userland clustering
> infrastructure) are passed to foo-user -- not into the kernel.  foo-user
> determines what the specific consequences are for foo-kernel.  foo-user
> then manipulates foo-kernel accordingly, through user/kernel hooks (sysfs,
> configfs, etc).  These control hooks would largely be specific to foo.
> 
> We're following option 2 with the dlm and gfs and have been for quite a
> while, which means we don't need 1.  I think ocfs2 is moving that way,
> too.  Someone could still try 1, of course, but it would be of no use or
> interest to me.  I'm not aware of any actual projects pushing forward with
> something like 1, so the persistent reference to it is somewhat baffling.

Right. I thought that the node manager changes for generalizing it where
pushing into sort-of direction 1. Thanks for clearing this up.



Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

