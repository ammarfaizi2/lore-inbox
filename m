Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262754AbUJ1E3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262754AbUJ1E3O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 00:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbUJ1E3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 00:29:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:19865 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262754AbUJ1E3F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 00:29:05 -0400
Date: Wed, 27 Oct 2004 21:29:03 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] error out on execve with no binfmts
Message-ID: <20041027212903.N2357@build.pdx.osdl.net>
References: <20041027184339.M2357@build.pdx.osdl.net> <20041027185617.3b44eb6a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041027185617.3b44eb6a.akpm@osdl.org>; from akpm@osdl.org on Wed, Oct 27, 2004 at 06:56:17PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> Chris Wright <chrisw@osdl.org> wrote:
> >
> > Early calls to userspace can invoke an execve() before any binfmt handlers
> > are registered.  Properly return an error in this case rather than 0.
> > On at least one arch (x86_64) without this patch, the system will double
> > fault on early attempts to call_usermodehelper.  Suggestions on a better
> > error?
> 
> These handlers are installed at core_initcall() time.  Who is calling out
> to userspace so early?

kobject_add()->kobject_hotplug() stuff during driver_init(), like platform bus
initialization, etc.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
