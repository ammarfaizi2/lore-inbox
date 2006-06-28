Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751771AbWF1XTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771AbWF1XTk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 19:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751764AbWF1XTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 19:19:40 -0400
Received: from xenotime.net ([66.160.160.81]:15327 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751771AbWF1XTk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 19:19:40 -0400
Date: Wed, 28 Jun 2006 16:22:25 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Erik Frederiksen <erik_frederiksen@pmc-sierra.com>
Cc: nathans@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: IS_ERR Threshold Value
Message-Id: <20060628162225.23720be8.rdunlap@xenotime.net>
In-Reply-To: <1151536413.3903.1135.camel@girvin.pmc-sierra.bc.ca>
References: <20060629084128.C1344246@wobbly.melbourne.sgi.com>
	<1151536413.3903.1135.camel@girvin.pmc-sierra.bc.ca>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2006 17:13:33 -0600 Erik Frederiksen wrote:

> Hi Nathan,
> 
> On Wed, 2006-06-28 at 16:41, Nathan Scott wrote:
> > 
> > Hmm, I'm not sure I understand the XFS side of your report here - on
> > open, for quota to be coming into play we must be creating a new inode
> > and those code paths inside XFS have no use of IS_ERR/ERR_PTR magic...
> > did you mean there's generic problems here (I can see those macros are
> > used in the generic VFS open() code) ... or am I missing your point?
> 
> Yes, that's right.  The error is being returned from xfs_create when
> quota has been exceeded.  It ends up carrying back to the filp_open call
> in do_sys_open, which returns it as a pointer to a filp structure. 
> Because the errno is so large, IS_ERR reports it as being a valid
> pointer incorrectly.
> 
> XFS has acted correctly.  The only reason I bring it up is this is how
> the bug was brought to my attention.  
> 
> If there won't be any strange side effects (I don't have the experience
> to accurately comment on this), I think turning the threshold value up
> to something we can get away with in IS_ERR_VALUE() would be
> appropriate.

We need to get the threshold == 4095 patch into -mm to make sure
that it doesn't break anything and/or fix whatever it breaks.

Are you planning to do that patch?  If not, someone else (or I) can.

---
~Randy
