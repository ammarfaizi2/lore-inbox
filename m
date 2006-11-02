Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWKBOWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWKBOWf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 09:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbWKBOWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 09:22:35 -0500
Received: from ra.tuxdriver.com ([70.61.120.52]:58128 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1750739AbWKBOWd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 09:22:33 -0500
Date: Thu, 2 Nov 2006 09:21:46 -0500
From: Neil Horman <nhorman@tuxdriver.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       kernel-janitors@lists.osdl.org, kjhall@us.ibm.com, maxk@qualcomm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [KJ][PATCH] Correct misc_register return code handling in several drivers
Message-ID: <20061102142146.GA4021@hmsreliant.homelinux.net>
References: <20061023171910.GA23714@hmsreliant.homelinux.net> <1161660875.10524.535.camel@localhost.localdomain> <20061024125306.GA1608@hmsreliant.homelinux.net> <1161729762.10524.660.camel@localhost.localdomain> <20061101135619.GA3459@hmsreliant.homelinux.net> <20061101155541.1e88a2f3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061101155541.1e88a2f3.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2006 at 03:55:41PM -0800, Andrew Morton wrote:
> On Wed, 1 Nov 2006 08:56:19 -0500
> Neil Horman <nhorman@tuxdriver.com> wrote:
> 
> > 	Since Andrew hasn't incorporated this patch yet, and I had the time, I
> > redid the patch taking Benjamin's INIT_LIST_HEAD and Joes mmtimer cleanup into
> > account.  New patch attached, replacing the old one, everything except the
> > aforementioned cleanups is identical.  
> 
> Please prepare a description for this patch.  The INIT_LIST_HEAD() in
> misc_register() is mysterious.

Andrew-
	This is a patch to clean up several code points in which the return code
from misc_register is not handled properly.  Several modules failed to
deregister various hooks when misc_register fails, and this patch cleans them
up.  Also there are a few modules that legitimately don't care about the failure
status of misc register.  These drivers however unilaterally call
misc_deregister on module unload.  Since misc_register doesn't initialize the
list_head in the init_routine if it fails, the deregister operation is at risk
for oopsing when list_del is called.  The initial solution was to manually init
the list in the miscdev structure in each of those modules, but the consensus in
this thread was to consolodate and do that universally inside misc_register.

Thanks & Regards
Neil

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *gpg keyid: 1024D / 0x92A74FA1 - http://pgp.mit.edu
 ***************************************************/
