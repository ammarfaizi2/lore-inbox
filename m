Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262907AbUCKAzh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 19:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262926AbUCKAzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 19:55:37 -0500
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:16327 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S262907AbUCKAzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 19:55:35 -0500
Date: Thu, 11 Mar 2004 01:55:15 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Albert Cahalan <albert@users.sourceforge.net>
cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       corliss@digitalmages.com, riel@redhat.com, jerj@coplanar.net
Subject: Re: [PATCH] 2.6.x BSD Process Accounting w/High UID
In-Reply-To: <1078956556.2233.586.camel@cube>
Message-ID: <Pine.LNX.4.53.0403110126240.16538@gockel.physik3.uni-rostock.de>
References: <1078883951.2232.501.camel@cube> 
 <Pine.LNX.4.53.0403100940240.12833@gockel.physik3.uni-rostock.de> 
 <1078936898.2232.571.camel@cube>  <Pine.LNX.4.53.0403101844140.15085@gockel.physik3.uni-rostock.de>
 <1078956556.2233.586.camel@cube>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2004, Albert Cahalan wrote:

> > But I favor your suggestion of 32-bit IEEE floats even more,
> > as it doesn't need a change to the GNU acct tools.
> 
> I'm surprised. Do the tools rely on a #define for this?

They check the types with autoconf. In case of a comp_t, the 
hard-coded conversion routine is called, otherwise the value is
just cast to a double.

> Is there a reason to have the whole struct be a
> power of two?

Not that I'm aware of. But I hesitate to change the length of the
struct since seeking in a file with mixed field lengths would become
a nightmare. And why would we want to store a version number in each
acct record if we can't mix them afterwards?

So my current plot would be to expand the most interesting fields to
floats, using up the padding, and leave the others as comp_t.

Actually, the only field of interest here seems to be ac_etime where, as 
Arthur Corliss pointed out, also precision matters.
Less impotant candidates might be ac_io, ac_rw and/or ac_minflt.

For ac_utime and ac_stime, on the other hand, 497 days of cpu time for
each job seems rather plentyful. Even more, if we'd fix the internal
overflow in GNU acct's comp_t conversion routine and have 1988 days at
hand.


Tim
