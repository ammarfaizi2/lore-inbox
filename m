Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265495AbUFYJGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265495AbUFYJGY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 05:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265590AbUFYJGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 05:06:24 -0400
Received: from gate.in-addr.de ([212.8.193.158]:42925 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S265495AbUFYJGW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 05:06:22 -0400
Date: Fri, 25 Jun 2004 11:04:13 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Andreas Gruenbacher <agruen@suse.de>,
       Andreas Dilger <adilger@clusterfs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: Testing for kernel features in external modules
Message-ID: <20040625090413.GM3956@marowsky-bree.de>
References: <20040624203043.GA4557@mars.ravnborg.org> <20040624203516.GV31203@schnapps.adilger.int> <200406251032.22797.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200406251032.22797.agruen@suse.de>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-06-25T10:32:22,
   Andreas Gruenbacher <agruen@suse.de> said:

> I disagree. I don't think we want to clutter the code with feature
> definitions that have no known users. That doesn't age/scale very
> well. It's easy enough to test for features in the external module.

True enough, but how do you propose to do that? I do understand the pain
of the external module builds who have to try and support the vanilla
kernel plus several vendor trees.

Yes, of course, we could end up with a autoconf like approach for
building them, but ... you know ... that's sort of ugly.

Having a list of defines to document the version of a specific API in
the kernel, and a set of defines pre-fixed with <vendor>_ to document
vendor tree extensions may not be the worst thing:

- if the vendor backports a given feature + API from mainstream, the
  define can be set to match the mainstream version;
- If vendor introduces a vendor API extension, the vendor extension
  would come into play.
- If the vendor API eventually merges with the mainstream API again, the
  vendor define goes away again and rule 1 applies.

This should age pretty well - as soon as an external code tree drops
support for a given version, they can clean out all the #ifdefs they had
based on this.

Now the granularity of the API versioning is interesting - per .h is too
coarse, and per-call would be too fine. But I'm sure someone could come
up with a sane proposal here.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	    \ ever tried. ever failed. no matter.
SUSE Labs, Research and Development | try again. fail again. fail better.
SUSE LINUX AG - A Novell company    \ 	-- Samuel Beckett

