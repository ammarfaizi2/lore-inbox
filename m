Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751491AbWCETXD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbWCETXD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 14:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbWCETXB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 14:23:01 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:57327 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751491AbWCETXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 14:23:00 -0500
Date: Sun, 5 Mar 2006 11:22:48 -0800
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Daniel Phillips <phillips@google.com>, linux-kernel@vger.kernel.org,
       ocfs2-devel@oss.oracle.com
Subject: Re: Ocfs2 performance bugs of doom
Message-ID: <20060305192247.GH31587@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <4408C2E8.4010600@google.com> <20060303233617.51718c8e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060303233617.51718c8e.akpm@osdl.org>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2006 at 11:36:17PM -0800, Andrew Morton wrote:
> >  -	hash = full_name_hash(name, len);
> 
> err, you might want to calculate that hash outside the spinlock.
Hmm, good catch.

> Maybe have a lock per bucket, too.
That could be an avenue to explore. I guess we probably want to optimize the
actual lookup and memory usage before looking at that.

> A 1MB hashtable is verging on comical.  How may data are there in total?
Yes 1MB is much too big. We're looking right now at 3 lock resources per
inode, so total number of elements depends upon your file system I suppose.
Hopefully I'll have some time today to run some basic tests which may show
us what size strikes a better balance of performance versus memory overhead.
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
