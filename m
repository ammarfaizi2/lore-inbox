Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267777AbUI1U0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267777AbUI1U0c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 16:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267785AbUI1U0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 16:26:32 -0400
Received: from sigma957.CIS.McMaster.CA ([130.113.64.83]:62096 "EHLO
	sigma957.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S267777AbUI1U0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 16:26:30 -0400
Subject: Re: [RFC][PATCH] inotify 0.10.0
From: John McCutchan <ttb@tentacle.dhs.org>
To: Ray Lee <ray-lk@madrabbit.org>
Cc: Robert Love <rml@novell.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, gamin-list@gnome.org,
       viro@parcelfarce.linux.theplanet.co.uk, iggy@gentoo.org
In-Reply-To: <1096350328.26742.52.camel@orca.madrabbit.org>
References: <1096250524.18505.2.camel@vertex>
	 <20040926211758.5566d48a.akpm@osdl.org>
	 <1096318369.30503.136.camel@betsy.boston.ximian.com>
	 <1096350328.26742.52.camel@orca.madrabbit.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096403167.30123.5.camel@vertex>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 28 Sep 2004 16:26:07 -0400
X-PMX-Version-Mac: 4.7.0.111621, Antispam-Engine: 2.0.0.0, Antispam-Data: 2004.9.28.2
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_VERSION 0, __SANE_MSGID 0'
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-28 at 01:45, Ray Lee wrote:
> On Mon, 2004-09-27 at 16:52 -0400, Robert Love wrote:
> > > > +struct inotify_event {
> > > > +	int wd;
> > > > +	int mask;
> > > > +	int cookie;
> > > > +	char filename[INOTIFY_FILENAME_MAX];
> > > > +};
> > > 
> > > yeah, that's not very nice.  Better to kmalloc the pathname.
> > 
> > That is the structure that we communicate with to user-space.
> > 
> > We could kmalloc() filename, but it makes the user-space use a bit more
> > complicated (and right now it is trivial and wonderfully simple).
> > 
> > We've been debating the pros and cons.
> 
> The current way pads out the structure unnecessarily, and still doesn't
> handle the really long filenames, by your admission. It incurs extra
> syscalls, as few filenames are really 256 characters in length. It makes
> userspace double-check whether the filename extends all the way to the
> boundary of the structure, and if so, then go back to the disk to try to
> guess what the kernel really meant to say.

I thought that filenames where limited to 256 characters? That was the
idea behind the 256 character limit.

John
