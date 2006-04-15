Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751449AbWDOAeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbWDOAeJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 20:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbWDOAeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 20:34:09 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:31174 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751449AbWDOAeH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 20:34:07 -0400
Subject: Re: [PATCH] make: add modules_update target
From: Dustin Kirkland <dustin.kirkland@us.ibm.com>
Reply-To: Dustin Kirkland <dustin.kirkland@us.ibm.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Kylene Jo Hall <kjhall@us.ibm.com>, kbuild-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060414170222.GA19172@thunk.org>
References: <1145027216.12054.164.camel@localhost.localdomain>
	 <20060414170222.GA19172@thunk.org>
Content-Type: text/plain
Organization: IBM
Date: Fri, 14 Apr 2006 19:33:39 -0500
Message-Id: <1145061219.4001.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-14 at 13:02 -0400, Theodore Ts'o wrote: 
> This works as long as the .config hasn't been changed so that some
> configuration options haven't been changed so that a driver which had
> been previously built as a module is now built into the kernel.  In
> that case, you really want to make sure the no-longer applicable .ko
> file has been removed from the system.  If the developer knows that to
> be true, they can use your proposed modules_update without any problems.
> 
> As a suggestion, something that might be worth trying would be to
> change to modules_install so that it uses cp -u, but also so that it
> tries to delete all files that could have previously installed as
> modules (by using the obj-y list).  This should hopefully speed up
> modules_install, and make it do the right thing all the time.

Ted-

So I found the obj-y list a little tough to work with, as the objects
listed there do not contain fully qualified paths describing their
locations.

Here's another approach...

What you would think of some logic such that 

        if .config file has changed since last modules_install
                call normal brute force modules_install target
        else
                call this new, more efficient modules_update target
        
I was looking through the top level Makefile for a flag or some such
that would determine if a .config file has changed since last build, to
no avail.

It would be pretty easy to maintain an md5sum/sha1sum signature of
the .config used to perform a modules install/update (.config.md5), and
compare the signature of the current .conf with the previous to
determine change.

It looks like it may not be easy to drop in modules_update as a more
efficient alternative to modules_install, but note that is not the patch
that Kylie submitted...  

I suggest that it might be sufficient to document modules_update as a
handy, more efficient development build target when someone is working
on one particular module-built aspect of the kernel.  And clearly note
that to perform a full, clean /lib/modules/`uname -r`/kernel
synchronization with a given build tree, the more thorough
modules_install target is preferred.

Thoughts?

:-Dustin

