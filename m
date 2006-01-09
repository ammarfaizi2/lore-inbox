Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751643AbWAIX6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbWAIX6q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 18:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751647AbWAIX6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 18:58:46 -0500
Received: from ns2.suse.de ([195.135.220.15]:6814 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751635AbWAIX6p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 18:58:45 -0500
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SUSE Labs / Novell Inc.
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Subject: Re: [patch 0/2] Tmpfs acls
Date: Tue, 10 Jan 2006 00:59:46 +0100
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
References: <200601090023.16956.agruen@suse.de> <E1Evk3m-00043Y-00@chiark.greenend.org.uk>
In-Reply-To: <E1Evk3m-00043Y-00@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601100059.47317.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 January 2006 00:34, Matthew Garrett wrote:
> Andreas Gruenbacher <agruen@suse.de> wrote:
> > This is an update of the tmpfs acl patches against 2.6.15-git4. (The
> > first version of these patches was posted on 2 February 2005.) We'll
> > have our /dev tree on tmpfs in the future, and we need acls there to
> > manage device inode permissions of logged-in users. Other distributions
> > will be in exactly the same situation, and need this patchset as well.
>
> Hmm. Do you have any infrastructure for revoking open file descriptors
> when a user logs out?

Open file descriptors have nothing to do with it. The device permissions are 
set by different pam modules on different distributions (pam_console, 
pam_resmgr).

Without acls, permissions are assigned by changing file ownership. With acls, 
the respective user or users can be given access as appropriate, which is 
more flexible. There are a few cases in which it is desirable to grant access 
to a device to more than one locally logged in user. This also obsoletes the 
resmgr hack of passing around open file descriptors and several hacks in 
applications that use this mechanism, because permissions can be set as 
appropriate.

Andreas
