Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266691AbUGQCfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266691AbUGQCfr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 22:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266686AbUGQCfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 22:35:47 -0400
Received: from holomorphy.com ([207.189.100.168]:21169 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266691AbUGQCfq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 22:35:46 -0400
Date: Fri, 16 Jul 2004 19:34:09 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Chris Wright <chrisw@osdl.org>,
       Ravikiran G Thirumalai <kiran@in.ibm.com>, linux-kernel@vger.kernel.org,
       dipankar@in.ibm.com
Subject: Re: [RFC] Lock free fd lookup
Message-ID: <20040717023409.GL3411@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Keith Owens <kaos@ocs.com.au>, Jesse Barnes <jbarnes@engr.sgi.com>,
	Chris Wright <chrisw@osdl.org>,
	Ravikiran G Thirumalai <kiran@in.ibm.com>,
	linux-kernel@vger.kernel.org, dipankar@in.ibm.com
References: <20040717011936.GK3411@holomorphy.com> <3310.1090030359@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3310.1090030359@ocs3.ocs.com.au>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jul 2004 18:19:36 -0700, William Lee Irwin III wrote:
>> This actually appears to confirm my earlier assertion about the linkage
>> of the data structure. Is this conclusion what you had in mind?

On Sat, Jul 17, 2004 at 12:12:39PM +1000, Keith Owens wrote:
> Not quite.  The 2-3-4 tree has embedded linkage, but it can be done
> lockfree if you really have to.  The problem is that a single 2-3-4
> list entry maps to two red-black list entries.  I could atomically
> update a single 2-3-4 list entry, including its pointers, even when the
> list was being read or updated by other users.  I could not work out
> how to do the equivalent update when the list linkage data was split
> over two red-black nodes.

2-3 trees have external linkage just like B/B+ trees as I had
envisioned what external linkage is. Terminological issue I guess.


On Sat, Jul 17, 2004 at 12:12:39PM +1000, Keith Owens wrote:
> The list structure is an implementation detail, the use of 2-3-4 or
> red-black is completely transparent to the main code.  The main code
> wants to lookup a structure from the list, to update a structure, to
> insert or to delete a structure without waiting.  How the list of
> structures is maintained is a problem for the internals of the API.

That kind of genericity is tough to come by in C. I guess callbacks and
void * can do it when pressed.


-- wli
