Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263720AbUDQAoy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 20:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263740AbUDQAox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 20:44:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:4532 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263720AbUDQAov (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 20:44:51 -0400
Date: Fri, 16 Apr 2004 17:44:34 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Jones <davej@redhat.com>
cc: Jeff Garzik <jgarzik@pobox.com>, viro@parcelfarce.linux.theplanet.co.uk,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       bfennema@falcon.csc.calpoly.edu
Subject: Re: Fix UDF-FS potentially dereferencing null
In-Reply-To: <20040416231823.GZ20937@redhat.com>
Message-ID: <Pine.LNX.4.58.0404161720450.3947@ppc970.osdl.org>
References: <20040416214104.GT20937@redhat.com>
 <20040416220014.GI24997@parcelfarce.linux.theplanet.co.uk> <40806880.1030007@pobox.com>
 <20040416231823.GZ20937@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 17 Apr 2004, Dave Jones wrote:
> 
> And there's a *lot* of them. Those half dozen or so patches earlier were
> results of just a quick random skim of the list the coverity folks came up with.
> 
> It'll take a lot of effort to 'fix' them all, and given the non-severity
> of a lot of them, I'm not convinced it's worth the effort.

Just for the fun of it, I added a "safe" attribute to sparse (hey, it was 
trivial), and made it warn if you test a safe variable. 

You can do

	#define __safe __attribute__((safe))

	static struct denty *
	udf_lookup(struct inode * __safe dir,
			struct dentry * __safe dentry,
			struct nameidata * __safe nd);

or

	int notify_change(struct dentry * dentry, struct iattr * attr)
	{
		struct inode * __safe inode = dentry->d_inode;

and it should actually warn you if you test such a safe variable:

	warning: fs/attr.c:138:6: testing a 'safe expression'

Ehh?

		Linus
