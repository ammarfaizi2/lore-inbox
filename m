Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbWDNRC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbWDNRC0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 13:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWDNRC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 13:02:26 -0400
Received: from thunk.org ([69.25.196.29]:42395 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751289AbWDNRC0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 13:02:26 -0400
Date: Fri, 14 Apr 2006 13:02:22 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: kbuild-devel@lists.sourceforge.net, dustin.kirkland@us.ibm.com,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make: add modules_update target
Message-ID: <20060414170222.GA19172@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Kylene Jo Hall <kjhall@us.ibm.com>,
	kbuild-devel@lists.sourceforge.net, dustin.kirkland@us.ibm.com,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1145027216.12054.164.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145027216.12054.164.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2006 at 10:06:56AM -0500, Kylene Jo Hall wrote:
> Here is a a patch that adds a kernel build target called
> "modules_update".  
> 
> The existing "modules_install" target blows away the entire 
> /lib/modules/`uname -r`/kernel directory and copies out every single
> module when called at the top level.
> 
> This new "modules_update" target only copies out modules that have
> changed, using "cp -u".  This less zealous method is a more efficient
> approach to module installation for kernel developers working on single,
> or small numbers of modules.  

Hi Kylene,

This works as long as the .config hasn't been changed so that some
configuration options haven't been changed so that a driver which had
been previously built as a module is now built into the kernel.  In
that case, you really want to make sure the no-longer applicable .ko
file has been removed from the system.  If the developer knows that to
be true, they can use your proposed modules_update without any problems.

As a suggestion, something that might be worth trying would be to
change to modules_install so that it uses cp -u, but also so that it
tries to delete all files that could have previously installed as
modules (by using the obj-y list).  This should hopefully speed up
modules_install, and make it do the right thing all the time.

Regards,

						- Ted
