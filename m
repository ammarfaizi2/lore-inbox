Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264863AbVBDSYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264863AbVBDSYe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 13:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264026AbVBDSVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 13:21:13 -0500
Received: from mummy.ncsc.mil ([144.51.88.129]:3509 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S264778AbVBDSUW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 13:20:22 -0500
Subject: Re: [PATCH][SELINUX] Fix selinux_inode_setattr hook
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>, selinux@tycho.nsa.gov
In-Reply-To: <20050204101440.N24171@build.pdx.osdl.net>
References: <1107539956.8078.109.camel@moss-spartans.epoch.ncsc.mil>
	 <20050204101440.N24171@build.pdx.osdl.net>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1107540806.8078.114.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 04 Feb 2005 13:13:26 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-04 at 13:14, Chris Wright wrote:
> * Stephen Smalley (sds@tycho.nsa.gov) wrote:
> > This patch against 2.6.11-rc3 fixes the selinux_inode_setattr hook
> > function to honor the ATTR_FORCE flag, skipping any permission checking
> > in that case.  Otherwise, it is possible though unlikely for a denial
> > from the hook to prevent proper updating, e.g. for remove_suid upon
> > writing to a file.  This would only occur if the process had write
> > permission to a suid file but lacked setattr permission to it.  Please
> > apply.
> 
> Is there any reason not to promote this to the framework?

I wasn't sure if a security module might still want to be notified of
forced changes (e.g. to adjust some state in its own security
structure), even if it skips permission checking on such changes.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency

