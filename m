Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751588AbWEEPWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588AbWEEPWu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 11:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751598AbWEEPWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 11:22:50 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:5338 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751588AbWEEPWt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 11:22:49 -0400
Subject: Re: [PATCH 10/13: eCryptfs] Mmap operations
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: David Howells <dhowells@redhat.com>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>,
       Phillip Hellewell <phillip@hellewell.homeip.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk, mike@halcrow.us,
       mhalcrow@us.ibm.com, mcthomps@us.ibm.com, toml@us.ibm.com,
       yoder1@us.ibm.com, James Morris <jmorris@namei.org>,
       "Stephen C. Tweedie" <sct@redhat.com>, Erez Zadok <ezk@cs.sunysb.edu>
In-Reply-To: <23514.1146779003@warthog.cambridge.redhat.com>
References: <84144f020605040813q29fcddcr1c846d27cf156432@mail.gmail.com>
	 <20060504031755.GA28257@hellewell.homeip.net>
	 <20060504034127.GI28613@hellewell.homeip.net>
	 <23514.1146779003@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Fri, 05 May 2006 10:22:28 -0500
Message-Id: <1146842548.10109.27.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-05-04 at 22:43 +0100, David Howells wrote:
> Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> 
> > > +               rc = mapping->a_ops->readpage(file, page);
> > 
> > What's the purpose of this second read?
> 
> When writing CacheFiles, I noticed that ext3 would occasionally unlock a page
> that had neither PG_uptodate nor PG_error set, and so I had to force another
> readpage() on it.

I understand this comes from the FiST package.  In that code, there is a
comment in one of these functions explaining the second read.  It would
be nice to have that comment in here too:

   /*
    * call readpage() again if we returned from wait_on_page with a
    * page that's not up-to-date; that can happen when a partial
    * page has a few buffers which are ok, but not the whole
    * page.
    */

I'm a bit surprised that this could happen.

Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

