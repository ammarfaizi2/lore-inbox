Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261756AbVAGX2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbVAGX2B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 18:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbVAGXZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 18:25:28 -0500
Received: from 208.177.141.226.ptr.us.xo.net ([208.177.141.226]:17578 "EHLO
	ash.lnxi.com") by vger.kernel.org with ESMTP id S261700AbVAGXWE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 18:22:04 -0500
Subject: Re: MS_NOUSER and rootfs
From: Thayne Harbaugh <tharbaugh@lnxi.com>
Reply-To: tharbaugh@lnxi.com
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       lkml <linux-kernel@vger.kernel.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20050107214548.GB6052@pclin040.win.tue.nl>
References: <1105024095.15293.74.camel@tubarao>
	 <200501071932.35184.vda@port.imtp.ilyichevsk.odessa.ua>
	 <1105131212.18437.15.camel@tubarao>
	 <20050107214548.GB6052@pclin040.win.tue.nl>
Content-Type: text/plain
Organization: Linux Networx
Date: Fri, 07 Jan 2005 15:54:37 -0700
Message-Id: <1105138477.18437.30.camel@tubarao>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-07 at 22:45 +0100, Andries Brouwer wrote:
> On Fri, Jan 07, 2005 at 01:53:32PM -0700, Thayne Harbaugh wrote:
> > On Fri, 2005-01-07 at 19:32 +0200, Denis Vlasenko wrote:
> > > On Thursday 06 January 2005 17:08, Thayne Harbaugh wrote:
> > > > What is the purpose of the MS_NOUSER flag serve and why is it set on
> > > > rootfs?
> 
> Some random docs say

Much thanks for the randomness.

> The <tt>FS_NOMOUNT</tt> flag says that this filesystem must never
> be mounted from userland, but is used only kernel-internally.
> This flag was introduced in 2.3.99-pre7 and disappeared in Linux 2.5.22.
> This was used, for example, for pipefs, the implementation of Unix pipes
> using a kernel-internal filesystem (see <tt>fs/pipe.c</tt>).
> Even though the flag has disappeared, the concept remains,
> and is now represented by the MS_NOUSER flag.

Okay, I can buy that there are filesystems, such as pipefs, that
shouldn't be mounted from userland.  I'm wondering, however, why that
applies to rootfs.  Is it a security reason (if it is, why - I'd like to
understand), is it a technical reason to simplify some VFS
requirement/limitation, or was it simply picked because it seemed to
make sense but it could be changed if something else made more sense?

Here's my application:

I have an early-userspace with early init programs and kernel modules.
Hotplug events load drivers and then the early init mounts the real
root.  I want to take the modules from the early-userspace to the real
root by a mount bind of /lib/modules to /newroot/lib/modules.  The mount
bind is the slickest way to do it rather than copying everything from /
to /newroot.  That's where the MS_NOUSER is getting in the way.

I've removed MS_NOUSER from rootfs_get_sb() in my tree and things work
great.  I'm just wondering if this might cause some real, unforeseen
problem or if it's something that might be changed in the main tree.

-- 
Thayne Harbaugh
Linux Networx

