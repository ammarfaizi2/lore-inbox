Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268104AbUI3Beb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268104AbUI3Beb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 21:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268129AbUI3Beb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 21:34:31 -0400
Received: from peabody.ximian.com ([130.57.169.10]:64700 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S268104AbUI3Be1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 21:34:27 -0400
Subject: Re: [RFC][PATCH] inotify 0.10.0
From: Robert Love <rml@novell.com>
To: Andrew Morton <akpm@osdl.org>
Cc: John McCutchan <ttb@tentacle.dhs.org>, ray-lk@madrabbit.org,
       cfriesen@nortelnetworks.com, linux-kernel@vger.kernel.org,
       gamin-list@gnome.org, viro@parcelfarce.linux.theplanet.co.uk,
       iggy@gentoo.org
In-Reply-To: <20040929211533.5e62988a.akpm@osdl.org>
References: <1096250524.18505.2.camel@vertex>
	 <20040926211758.5566d48a.akpm@osdl.org>
	 <1096318369.30503.136.camel@betsy.boston.ximian.com>
	 <1096350328.26742.52.camel@orca.madrabbit.org>
	 <20040928120830.7c5c10be.akpm@osdl.org>
	 <41599456.6040102@nortelnetworks.com>
	 <1096390398.4911.30.camel@betsy.boston.ximian.com>
	 <1096392771.26742.96.camel@orca.madrabbit.org>
	 <1096403685.30123.14.camel@vertex>  <20040929211533.5e62988a.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 29 Sep 2004 21:34:33 -0400
Message-Id: <1096508073.16832.17.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-29 at 21:15 -0700, Andrew Morton wrote:


> Or is it the case that you expect a single monitor on /etc will return
> "/etc/passwd" if someone modified that file, or "/etc/hosts" if someone
> modified that file?

A monitor on "/etc" will return "hosts" if hosts is modified.  Which I
think is OK--we don't pass the entire path, nor do we want to if we
could do it easily, for numerous reasons ..

> If so, perhaps we should take that feature away and
> require that userspace rescan the directory?

This is one of the issues with dnotify we want to fix.  And to do
generic file notification, it is not just rescanning the directory but
caching file modify timestamps (say, keep all of the stat structures in
memory) and then re-stat'ing everything and comparing.  Ugh.

> Because passing pathnames into and back from the kernel from this manner is
> really not a nice design.

Agreed.

> A halfway point might be to return {cookie-of-/etc,EVENT_MODIFY,"hosts"} to
> a monitor on the /etc directory.

This is what inotify does. ;-)

Everything is relative to the object being watched.

	Robert Love


