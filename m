Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267977AbUI1Vcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267977AbUI1Vcl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 17:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268039AbUI1Vck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 17:32:40 -0400
Received: from sb0-cf9a48a7.dsl.impulse.net ([207.154.72.167]:35789 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id S267977AbUI1VcQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 17:32:16 -0400
Subject: Re: [RFC][PATCH] inotify 0.10.0
From: Ray Lee <ray-lk@madrabbit.org>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: Andrew Morton <akpm@osdl.org>, rml@novell.com,
       linux-kernel@vger.kernel.org, gamin-list@gnome.org,
       viro@parcelfarce.linux.theplanet.co.uk, iggy@gentoo.org
In-Reply-To: <1096404035.30123.22.camel@vertex>
References: <1096250524.18505.2.camel@vertex>
	 <20040926211758.5566d48a.akpm@osdl.org>
	 <1096318369.30503.136.camel@betsy.boston.ximian.com>
	 <1096350328.26742.52.camel@orca.madrabbit.org>
	 <20040928120830.7c5c10be.akpm@osdl.org>  <1096404035.30123.22.camel@vertex>
Content-Type: text/plain
Organization: http://madrabbit.org/
Date: Tue, 28 Sep 2004 14:32:12 -0700
Message-Id: <1096407132.5177.34.camel@issola.madrabbit.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-28 at 16:40 -0400, John McCutchan wrote:
> On Tue, 2004-09-28 at 15:08, Andrew Morton wrote:
> > Ray Lee <ray-lk@madrabbit.org> wrote:
> > >
> > > The current way pads out the structure unnecessarily, and still doesn't
> > > handle the really long filenames, by your admission. It incurs extra
> > > syscalls, as few filenames are really 256 characters in length. 
> > 
> > Why don't you pass a file descriptor into the syscall instead of a pathname?
> > You can then take a ref on the inode and userspace can close the file.
> > That gets you permission checking for free.
> > 
> 
> I don't think moving inotify to a syscall based interface is worth it.
> 
> First off, on startup, this would require about 2k open() calls,
> followed by 2k syscalls to inotify.

And then 2k close() calls.

> Not as nice as just 2k ioctl() calls.

<shrug> Syscalls aren't free, but they aren't the end of the world.

> The character device interface right now suits it perfectly. If we used
> syscalls we would need to provide a syscall that gives user space a FD
> that it can read events on,

Again, apologies, I should know better than to write email on short
sleep. All I was suggesting was that we pass in an fd that comes from
open(), and that we should look at replacing the ioctl with write(). I
like it as a character device, honest.

Ray

