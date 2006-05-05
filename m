Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751602AbWEEPiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbWEEPiv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 11:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751610AbWEEPiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 11:38:51 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:2729 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751602AbWEEPiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 11:38:50 -0400
Subject: Re: [PATCH 10/13: eCryptfs] Mmap operations
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: David Howells <dhowells@redhat.com>,
       Phillip Hellewell <phillip@hellewell.homeip.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk, mike@halcrow.us,
       mhalcrow@us.ibm.com, mcthomps@us.ibm.com, toml@us.ibm.com,
       yoder1@us.ibm.com, James Morris <jmorris@namei.org>,
       "Stephen C. Tweedie" <sct@redhat.com>, Erez Zadok <ezk@cs.sunysb.edu>
In-Reply-To: <1146842548.10109.27.camel@kleikamp.austin.ibm.com>
References: <84144f020605040813q29fcddcr1c846d27cf156432@mail.gmail.com>
	 <20060504031755.GA28257@hellewell.homeip.net>
	 <20060504034127.GI28613@hellewell.homeip.net>
	 <23514.1146779003@warthog.cambridge.redhat.com>
	 <1146842548.10109.27.camel@kleikamp.austin.ibm.com>
Date: Fri, 05 May 2006 18:38:48 +0300
Message-Id: <1146843528.11271.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-05-04 at 22:43 +0100, David Howells wrote:
> > When writing CacheFiles, I noticed that ext3 would occasionally unlock a page
> > that had neither PG_uptodate nor PG_error set, and so I had to force another
> > readpage() on it.

On Fri, 2006-05-05 at 10:22 -0500, Dave Kleikamp wrote:
> I understand this comes from the FiST package.  In that code, there is a
> comment in one of these functions explaining the second read.  It would
> be nice to have that comment in here too:
> 
>    /*
>     * call readpage() again if we returned from wait_on_page with a
>     * page that's not up-to-date; that can happen when a partial
>     * page has a few buffers which are ok, but not the whole
>     * page.
>     */
> 
> I'm a bit surprised that this could happen.

Me too. How do we know we don't end up the same way for the second read?

			Pekka

