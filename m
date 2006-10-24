Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965151AbWJXPKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965151AbWJXPKs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 11:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965154AbWJXPKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 11:10:48 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:26124 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S965151AbWJXPKr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 11:10:47 -0400
Date: Tue, 24 Oct 2006 11:07:00 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, akpm@osdl.org,
       kernel-janitors@lists.osdl.org, maxk@qualcomm.com, kjhall@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [KJ] [PATCH] Correct misc_register return code handling in several drivers
Message-ID: <20061024150700.GA1735@hmsreliant.homelinux.net>
References: <20061023171910.GA23714@hmsreliant.homelinux.net> <1161660875.10524.535.camel@localhost.localdomain> <20061024125306.GA1608@hmsreliant.homelinux.net> <20061024132437.GP25210@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061024132437.GP25210@parisc-linux.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2006 at 07:24:37AM -0600, Matthew Wilcox wrote:
> On Tue, Oct 24, 2006 at 08:53:06AM -0400, Neil Horman wrote:
> > The INIT_LIST_HEAD is there to prevent a potential oops on module removal.
> > misc_register, if it fails, leaves miscdevice.list unchanged.  That means its
> > next and prev pointers contain NULL or garbage, when both pointers should contain
> > &miscdevice.list. If we don't do that, then there is a chance we will oops on
> > module removal when we do a list_del in misc_deregister on the moudule_exit
> > routine.  I could have done this statically, but I thought it looked cleaner to
> > do it with the macro in the code.
> 
> Maybe it would be better to have misc_register() call INIT_LIST_HEAD in
> the failure case?

Hmm, that seems reasonable.  If you don't mind, since there are other unrelated
clean-ups in this patch, I'll make that change in a follow on patch.  But I
think thats a good idea.

Thanks & Regards
Neil

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *gpg keyid: 1024D / 0x92A74FA1 - http://pgp.mit.edu
 ***************************************************/
