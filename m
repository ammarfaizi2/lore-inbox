Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269301AbUI3PbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269301AbUI3PbO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 11:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269260AbUI3PbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 11:31:13 -0400
Received: from sb0-cf9a48a7.dsl.impulse.net ([207.154.72.167]:49619 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id S269301AbUI3P3n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 11:29:43 -0400
Subject: Re: [RFC][PATCH] inotify 0.10.0
From: Ray Lee <ray-lk@madrabbit.org>
To: Paul Jackson <pj@sgi.com>
Cc: Robert Love <rml@novell.com>, akpm@osdl.org, ttb@tentacle.dhs.org,
       cfriesen@nortelnetworks.com,
       Linux Kernel <linux-kernel@vger.kernel.org>, gamin-list@gnome.org,
       viro@parcelfarce.linux.theplanet.co.uk, iggy@gentoo.org
In-Reply-To: <20040929200525.4e7bb489.pj@sgi.com>
References: <1096250524.18505.2.camel@vertex>
	 <20040926211758.5566d48a.akpm@osdl.org>
	 <1096318369.30503.136.camel@betsy.boston.ximian.com>
	 <1096350328.26742.52.camel@orca.madrabbit.org>
	 <20040928120830.7c5c10be.akpm@osdl.org>
	 <41599456.6040102@nortelnetworks.com>
	 <1096390398.4911.30.camel@betsy.boston.ximian.com>
	 <1096392771.26742.96.camel@orca.madrabbit.org>
	 <1096403685.30123.14.camel@vertex> <20040929211533.5e62988a.akpm@osdl.org>
	 <1096508073.16832.17.camel@localhost>  <20040929200525.4e7bb489.pj@sgi.com>
Content-Type: text/plain
Organization: http://madrabbit.org/
Date: Thu, 30 Sep 2004 08:29:40 -0700
Message-Id: <1096558180.26742.133.camel@orca.madrabbit.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-29 at 20:05 -0700, Paul Jackson wrote:
> Robert wrote:
> > A monitor on "/etc" will return "hosts" if hosts is modified.  Which I
> > think is OK--we don't pass the entire path, nor do we want to if we
> > could do it easily, for numerous reasons ..
> 
> How about returning the inode number?
> 
> Notice that this can be converted to the name without using stat, using
> the d_ino field in the struct dirent returned from an opendir/readdir
> loop.

This changes an O(1) process to O(N), where N is the size of the
directory. That's one of the issues with dnotify that they're trying to
fix.

Bottom line, the kernel has that information available to it, and
cheaply. Forcing userspace to rederive that information for the
advantage of not spewing filenames out of the kernel is a false economy,
when viewed from the entire system.

Ray

