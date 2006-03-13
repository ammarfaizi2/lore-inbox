Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751486AbWCMXXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbWCMXXF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 18:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751600AbWCMXXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 18:23:04 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:46001 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751486AbWCMXXD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 18:23:03 -0500
Subject: Re: [PATCH 004 of 4] Make address_space_operations->invalidatepage
	return void
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Neil Brown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <17429.64506.967102.246581@cse.unsw.edu.au>
References: <20060313104910.15881.patches@notabene>
	 <1060312235331.15985@suse.de>
	 <1142267531.9971.5.camel@kleikamp.austin.ibm.com>
	 <17429.64506.967102.246581@cse.unsw.edu.au>
Content-Type: text/plain
Date: Mon, 13 Mar 2006 17:22:52 -0600
Message-Id: <1142292172.9923.5.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-14 at 10:10 +1100, Neil Brown wrote:
> On Monday March 13, shaggy@austin.ibm.com wrote:

> > I'm a little concerned about adding a BUG_ON for something this function
> > used to allow, but it looks like the BUG_ON is valid.  I'm asking myself
> > why did I add the test for PageWriteback in the first place.
> 
> Yes.... as far as I can tell, ->invalidatepage is only called with
> the page locked, and with Writeback clear, so PageWriteback can never
> be true.  So the BUG_ON should be a no-op.

Either I was being overly paranoid when I put in that test, or some code
previously called invalidatepage with Writeback set and it's since been
fixed.

> > I'll try to stress test jfs with these patches to see if I can trigger
> > the an oops here.
> 
> Thanks.  I'd be very interested if you do.
> I got on oops with a similar bug_on in the new nfs_invalidatepage and
> it turned out to be a bug in radixtree (which I had already found and
> fixed, but not in that source tree).

Aside from the jbd assert that Andrew fixed, my stress testing of jfs
was successful.  I ACK the jfs-specific part of the patch.
-- 
David Kleikamp
IBM Linux Technology Center

