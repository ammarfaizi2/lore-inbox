Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262853AbVG3FLq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262853AbVG3FLq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 01:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262938AbVG3FLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 01:11:46 -0400
Received: from cerebus.immunix.com ([198.145.28.33]:19123 "EHLO
	ermintrude.int.immunix.com") by vger.kernel.org with ESMTP
	id S262853AbVG3FL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 01:11:26 -0400
Date: Fri, 29 Jul 2005 22:07:01 -0700
From: Tony Jones <tonyj@immunix.com>
To: serue@us.ibm.com
Cc: lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, James Morris <jmorris@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Michael Halcrow <mhalcrow@us.ibm.com>
Subject: Re: [patch 0/15] lsm stacking v0.3: intro
Message-ID: <20050730050701.GA22901@immunix.com>
References: <20050727181732.GA22483@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050727181732.GA22483@serge.austin.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2005 at 01:17:32PM -0500, serue@us.ibm.com wrote:

Hi Serge.

A few trivial things I noticed whilst writing some internal documentation
on Stacker.  Nothing deep here, but thought I'd pass them along.

I'll try to actually try out the code next week.

I made these notes as I was going along,  lmk if you need them annotated
to the original patch and I'll go back and redo.

Thanks again

Tony


1) Documentation refers to /security/stacker/list_modules,  code refers to
   "listmodules".  list_modules is more consistent with other file names.

2) symbol_get(ops) still at the end of stacker_register.

3) struct module_entry{
        struct list_head lsm_list;  /* list of active lsms */
        struct list_head all_lsms;  /* list of active lsms */

   fix comments

4) Would it be useful to change the struct elements lsm_list and all_lsms to
   be consistent with their list heads (stacked_modules and all_modules).

5) /*
 * Workarounds for the fact that get and setprocattr are used only by
 * selinux.  (Maybe)
 */

No complaints on selinux getting to avoid the (module), they are intree.
Just a FYI that SubDomain/AppArmor uses these hooks also.

6) stop_responding control file is misnamed, as stacker still continues to work
   it just removes the virtual file system

7) Does the lsm_list really need to be at the top of the struct?  Good style
but not sure it is required (must).

8) security-stack.h
 * If stacker is compiled in, then we use the full functions as
 * defined in security/security.c.  Otherwise we use the #defines
 * here.

I noticed the conditional CONFIG_SECURITY_STACKER code went away, previously
it would look at the value chain head only for the !case. But this comment
still remains.

> Hi,
> 
> The set of patches to follow introduces support for stacking LSMs.  This
> is its third posting to lkml.  I am sending it out in the hopes of
> soliciting more widespread feedback and testing, with the obvious eventual
> goal of mainline adoption.
> 
> Any feedback from people actually using this patch is appreciated.  Even
> better would be posts of (stackable) LSMs for upstream inclusion :)
