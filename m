Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267863AbUI1UqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267863AbUI1UqX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 16:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267785AbUI1UqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 16:46:22 -0400
Received: from coriana6.CIS.McMaster.CA ([130.113.128.17]:50867 "EHLO
	coriana6.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S267863AbUI1Ukm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 16:40:42 -0400
Subject: Re: [RFC][PATCH] inotify 0.10.0
From: John McCutchan <ttb@tentacle.dhs.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Ray Lee <ray-lk@madrabbit.org>, rml@novell.com,
       linux-kernel@vger.kernel.org, gamin-list@gnome.org,
       viro@parcelfarce.linux.theplanet.co.uk, iggy@gentoo.org
In-Reply-To: <20040928120830.7c5c10be.akpm@osdl.org>
References: <1096250524.18505.2.camel@vertex>
	 <20040926211758.5566d48a.akpm@osdl.org>
	 <1096318369.30503.136.camel@betsy.boston.ximian.com>
	 <1096350328.26742.52.camel@orca.madrabbit.org>
	 <20040928120830.7c5c10be.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096404035.30123.22.camel@vertex>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 28 Sep 2004 16:40:35 -0400
X-PMX-Version-Mac: 4.7.0.111621, Antispam-Engine: 2.0.0.0, Antispam-Data: 2004.9.28.2
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_VERSION 0, __SANE_MSGID 0'
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-28 at 15:08, Andrew Morton wrote:
> Ray Lee <ray-lk@madrabbit.org> wrote:
> >
> > The current way pads out the structure unnecessarily, and still doesn't
> > handle the really long filenames, by your admission. It incurs extra
> > syscalls, as few filenames are really 256 characters in length. 
> 
> Why don't you pass a file descriptor into the syscall instead of a pathname?
> You can then take a ref on the inode and userspace can close the file.
> That gets you permission checking for free.
> 

I don't think moving inotify to a syscall based interface is worth it.

First off, on startup, this would require about 2k open() calls,
followed by 2k syscalls to inotify. Not as nice as just 2k ioctl()
calls.

The character device interface right now suits it perfectly. If we used
syscalls we would need to provide a syscall that gives user space a FD
that it can read events on, then more 2 more syscalls to provide the
watch and ignore functionality. Switching to the syscall interface would
also require implementing the idea of the inotify device instance
without the assistance of the char device subsystem. If the ioctl()
based interface is so bad, we could change it to a write() based
interface.

John
