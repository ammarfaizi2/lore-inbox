Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262536AbUCLUmu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 15:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262509AbUCLUjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 15:39:43 -0500
Received: from ns.suse.de ([195.135.220.2]:9384 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262345AbUCLUjJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 15:39:09 -0500
Subject: Re: [PATCH] per-backing dev unplugging #2
From: Chris Mason <mason@suse.com>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
In-Reply-To: <20040312203452.GD16880@suse.de>
References: <20040311083619.GH6955@suse.de>
	 <1079121113.4181.189.camel@watt.suse.com>
	 <20040312120322.0108a437.akpm@osdl.org> <20040312200253.GA16880@suse.de>
	 <1079123647.4186.211.camel@watt.suse.com>  <20040312203452.GD16880@suse.de>
Content-Type: text/plain
Message-Id: <1079124097.4187.216.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 12 Mar 2004 15:41:37 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-03-12 at 15:34, Jens Axboe wrote:

> 
> I don't see how this can make too much of a difference, aside of perhaps
> just moving the window a little. If page->mapping can disappear here,
> that's still a possibility.

As Andrew pointed out, the mapping struct won't disappear, but
page->mapping may go null.  So the idea is to use barriers to get a
trusted copy of page->mapping, and use the copy everywhere.

This could be completely bogus, and my test tree has a number of other
patches applied.  So, unless someone sees a really obvious bug in this
path, please don't waste brain cells on this one.  

I'll try to reproduce on something a little closer to vanilla if my
patch doesn't fix things.

-chris


