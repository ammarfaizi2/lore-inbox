Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964820AbWBVTni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbWBVTni (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 14:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbWBVTni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 14:43:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:58277 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964820AbWBVTnh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 14:43:37 -0500
Date: Wed, 22 Feb 2006 11:39:33 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <gregkh@suse.de>
cc: Gabor Gombas <gombasg@sztaki.hu>, "Theodore Ts'o" <tytso@mit.edu>,
       Andrew Morton <akpm@osdl.org>, Kay Sievers <kay.sievers@suse.de>,
       penberg@cs.helsinki.fi, bunk@stusta.de, rml@novell.com,
       linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: Re: 2.6.16-rc4: known regressions
In-Reply-To: <20060222191832.GA14638@suse.de>
Message-ID: <Pine.LNX.4.64.0602221135290.30245@g5.osdl.org>
References: <20060221153305.5d0b123f.akpm@osdl.org> <20060222000429.GB12480@vrfy.org>
 <20060221162104.6b8c35b1.akpm@osdl.org> <Pine.LNX.4.64.0602211631310.30245@g5.osdl.org>
 <Pine.LNX.4.64.0602211700580.30245@g5.osdl.org> <20060222112158.GB26268@thunk.org>
 <20060222154820.GJ16648@ca-server1.us.oracle.com> <20060222162533.GA30316@thunk.org>
 <20060222173354.GJ14447@boogie.lpds.sztaki.hu> <20060222185923.GL16648@ca-server1.us.oracle.com>
 <20060222191832.GA14638@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 Feb 2006, Greg KH wrote:
> 
> RHEL is a very different kernel from mainline (just like SLES is).  Have
> you looked through their patches to see if they are including something
> that causes this behavior?

Quite apart from that, we have definitely had issues where pure timing 
makes a difference - the kernel does the same exact thing, but just 
switches the order of some driver initialization, so that when /sbin/init 
starts, some discovery is still on-going.

It's _rare_, but it's one kind of bug that the kernel really can't do a 
lot about. For example, for the longest time we held off from the 
scheduler running child programs before returning to the parent after a 
fork(), simply because that triggered a real race condition in "bash". 

Eventually, we could say "screw it, it's a user-level timing bug", but the 
point being that sometimes timing changes, and while we _can_ try to keep 
even timing-related behaviour like that similar, sometimes it just isn't 
possible.

It's quite possible that nothing has really "changed", and that some part 
of the kernel just finishes more quickly (or slowly), triggering this 
problem. 

		Linus
