Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262987AbTDNMKo (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 08:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262988AbTDNMKo (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 08:10:44 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:9893 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262987AbTDNMKn (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 08:10:43 -0400
Date: Mon, 14 Apr 2003 18:09:10 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: dipankar@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] dentry_stat fix
Message-ID: <20030414180910.B27092@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20030414144417.A27092@in.ibm.com> <20030414021448.08ff05a5.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030414021448.08ff05a5.akpm@digeo.com>; from akpm@digeo.com on Mon, Apr 14, 2003 at 02:14:48AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 14, 2003 at 02:14:48AM -0700, Andrew Morton wrote:
> Maneesh Soni <maneesh@in.ibm.com> wrote:
> >
> > This patch the corrects the dentry_stat.nr_unused calculation.
> 
> OK, I didn't even know we had a bug in there...
> 
> btw, can you explain to me why shrink_dcache_anon() and select_parent() are
> putting dentries at the wrong end of dentry_unused?
prune_dcache() picks up from this end in first round. It will reset the 
DCACHE_REFERENCED flag and will put it to the front of dentry_unused list.

> 
> Do these dentries have DCACHE_REFERENCED set?
They will have DCACHE_REFERENCED set as they are on the unused list. The flag
get reset in the first round of aging.
 
> Why shouldn't they get a full two rounds of aging?
They do get.  

> It is not clear what's going on in there.  Thanks.

I am posting one more patch which makes the DCACHE_REFERENCED flag uses 
proper following this one.

Maneesh

-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/
