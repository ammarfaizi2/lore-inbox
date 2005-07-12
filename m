Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261653AbVGLRDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbVGLRDP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 13:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbVGLRC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 13:02:58 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:38596 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261653AbVGLRBL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 13:01:11 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17107.63309.475838.635711@tut.ibm.com>
Date: Tue, 12 Jul 2005 12:01:01 -0500
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tom Zanussi <zanussi@us.ibm.com>, Jason Baron <jbaron@redhat.com>,
       richardj_moore@uk.ibm.com, varap@us.ibm.com, karim@opersys.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Merging relayfs?
In-Reply-To: <1121186981.6917.67.camel@localhost.localdomain>
References: <17107.6290.734560.231978@tut.ibm.com>
	<Pine.LNX.4.61.0507121050390.25408@dhcp83-105.boston.redhat.com>
	<1121183607.6917.47.camel@localhost.localdomain>
	<17107.60140.948145.153144@tut.ibm.com>
	<1121185393.6917.59.camel@localhost.localdomain>
	<17107.61864.621401.440354@tut.ibm.com>
	<1121186981.6917.67.camel@localhost.localdomain>
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt writes:
 > On Tue, 2005-07-12 at 11:36 -0500, Tom Zanussi wrote:
 > 
 > >  > 
 > >  > I totally agree that the vmalloc way is faster, but I would also argue
 > >  > that the accounting to handle the separate pages would not even be
 > >  > noticeable with the time it takes to do the actual copying into the
 > >  > buffer.  So if the accounting adds 3ns on top of 500ns to complete, I
 > >  > don't think people will mind.
 > > 
 > > OK, it sounds like something to experiment with - I can play around
 > > with it, and later submit a patch to remove vmap if it works out.
 > > Does that sound like a good idea?
 > 
 > Sounds good to me, since different approaches to a problem are always
 > good, since it allows for comparing the plusses and minuses.  Not sure
 > if you want to take a crack using my ring buffers, but although they are
 > quite confusing, they have been fully tested, since I haven't changed
 > the ring buffer for a few years (although logdev itself has gone
through

I was thinking of something simpler, like just using the page array we
already have in relayfs, but not vmap'ing it and instead writing to
the current page, detecting when to split a record, moving on to the
next page, etc. and seeing how it compares with the vmap version.

Tom


