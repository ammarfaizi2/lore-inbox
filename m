Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbTHYRDX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 13:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbTHYRDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 13:03:23 -0400
Received: from [213.39.233.138] ([213.39.233.138]:8150 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262008AbTHYRCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 13:02:50 -0400
Date: Mon, 25 Aug 2003 19:02:50 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Dan Aloni <da-x@gmx.net>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] One strdup() to rule them all
Message-ID: <20030825170250.GB17608@wohnheim.fh-wedel.de>
References: <20030825161435.GB8961@callisto.yi.org> <20030825163745.GA17608@wohnheim.fh-wedel.de> <20030825165512.GA9782@callisto.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030825165512.GA9782@callisto.yi.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 August 2003 19:55:12 +0300, Dan Aloni wrote:
> > 
> > My gut feeling is always afraid when something "must not be NULL",
> > someone will ignore this and Bad Things (tm) happen.  Is strdup ever
> > used such performance critical code that the extra check would hurt?
> 
> There are two reasons while it shouldn't have a NULL check. One,
> persistency: the other str*() functions don't do this sort of check.
> Two, for general uses like that:
> 
>      new_name = strdup(name);
>      if (!new_name)
>          goto allocation_failed;
> 	 
> With this check, NULL would be returning from strdup() either because 
> name == NULL or when the allocation fails.

True, I missed that one.

> Passing NULL to strdup() is a bug, which would have NOT show as an
> Oops if you add this check, and that is bad. Maybe it would be worth 
> to add a BUG_ON(s == NULL) instead, and perhaps also add this to the 
> other str*() functions, but that is a different patch.

Ok.  Will you write that patch then or do I have to put it onto my
list?

Jörn

-- 
When in doubt, use brute force.
-- Ken Thompson
