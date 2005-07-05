Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261879AbVGEP5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbVGEP5E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 11:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbVGEP5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 11:57:03 -0400
Received: from smtp102.rog.mail.re2.yahoo.com ([206.190.36.80]:31340 "HELO
	smtp102.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261879AbVGEPkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 11:40:39 -0400
Date: Tue, 5 Jul 2005 11:48:39 -0400
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Daniel Drake <dsd@gentoo.org>, David G?mez <david@pleyades.net>,
       Robert Love <rml@novell.com>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with inotify
Message-ID: <20050705154837.GA16512@tentacle.dhs.org>
References: <42C65A8B.9060705@gentoo.org> <Pine.LNX.4.60.0507022253080.30401@hermes-1.csi.cam.ac.uk> <42C72563.7040103@gentoo.org> <Pine.LNX.4.60.0507030053040.15398@hermes-1.csi.cam.ac.uk> <42C7BF37.9010005@gentoo.org> <1120487242.11399.5.camel@imp.csi.cam.ac.uk> <42C9788F.50205@gentoo.org> <Pine.LNX.4.60.0507042008310.7572@hermes-1.csi.cam.ac.uk> <1120527203.18268.2.camel@vertex> <Pine.LNX.4.60.0507050855410.27724@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0507050855410.27724@hermes-1.csi.cam.ac.uk>
User-Agent: Mutt/1.5.9i
From: John McCutchan <ttb@tentacle.dhs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2005 at 08:56:15AM +0100, Anton Altaparmakov wrote:
> On Mon, 4 Jul 2005, John McCutchan wrote:
> > On Mon, 2005-07-04 at 20:09 +0100, Anton Altaparmakov wrote:
> > > On Mon, 4 Jul 2005, Daniel Drake wrote:
> > > > Anton Altaparmakov wrote:
> > > > > )-:  I have addressed the only things I can think off that could cause
> > > > > the oops and below is the resulting patch.  Could you please test it?
> > > > 
> > > > Yeah!! After removing I_WILL_FREE stuff, that fixed both the oops *and* the
> > > > hang. Everything works nicely now.
> > > 
> > > Great!  Thanks a lot for testing!  I will send a patch to Robert and 
> > > Andrew in a minute with more comments added.
> > 
> > Nice work, I am going to have a closer look at the patch soon. Could you
> > post the final patch at http://bugzilla.kernel.org/show_bug.cgi?id=4796
> 
> Thanks.  Now done.  But I am not sure about the white space.  I can't get 
> anything sensible out of IE on Mac OS 9 which I am on at the moment.
> 

Originally inotify had 2 functions that handled this. One that would
build up a list of inodes to call remove_watch on, the other function
would do the actual calling of remove_watch. This mirrored the other
unmount paths. I'm wondering if it wouldn't be cleaner to revert back to
that way?

John
