Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbWDURH7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbWDURH7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 13:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWDURH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 13:07:59 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:9918 "EHLO
	palinux.external.hp.com") by vger.kernel.org with ESMTP
	id S1751310AbWDURH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 13:07:58 -0400
Date: Fri, 21 Apr 2006 11:07:53 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Adrian Bunk <bunk@stusta.de>
Cc: Steven Whitehouse <swhiteho@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/16] GFS2: Makefiles and Kconfig
Message-ID: <20060421170753.GW24104@parisc-linux.org>
References: <1145636558.3856.118.camel@quoit.chygwyn.com> <20060421164309.GE19754@stusta.de> <20060421164910.GV24104@parisc-linux.org> <20060421165351.GG19754@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060421165351.GG19754@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2006 at 06:53:51PM +0200, Adrian Bunk wrote:
> On Fri, Apr 21, 2006 at 10:49:10AM -0600, Matthew Wilcox wrote:
> > On Fri, Apr 21, 2006 at 06:43:09PM +0200, Adrian Bunk wrote:
> > > - "depends on SYSFS" instead of the select
> > 
> > Why?  It's more natural to select it rather than depend on it.
> 
> The rule of thumb is that an option is either user visible and should be 
> depended on or not user visible and should be select'ed.

What rubbish!  Who came up with this rule of thumb?

My rule of thumb is that if an option is infrastructure, then it should
be selected.  If it's an addition, then it should be depended.

For example, in SCSI, the transport attributes are individually
selectable, but any driver that wants to use a transport selects it.
It would be foolish to have to answer questions from users who want to
know why they can't select SCSI_AHA152X any more and are told they have
to enable the obscure piece of infrastructure.

An exmaple in the other direction is BRIDGE_NETFILTER.  It would be
silly to *not* depend on NETFILTER.  The user has said they don't want
to do any kind of network filtering, so would only get annoyed at being
asked about different kinds of network filtering.

This case is clearly infrastructure.  The user knows whether or not
they want GFS.  If they have to enable sysfs to get GFS, this will only
perplex them.

Obviously, it's not always easy to figure out whether the relationship
between two pieces of code is infrastructure or addition.  Sometimes
it's a judgement call.
