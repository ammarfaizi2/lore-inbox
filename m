Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261397AbVGQUsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbVGQUsq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 16:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbVGQUsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 16:48:45 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:62952 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261397AbVGQUry
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 16:47:54 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17114.50164.95627.703402@tut.ibm.com>
Date: Sun, 17 Jul 2005 15:47:48 -0500
To: bert hubert <bert.hubert@netherlabs.nl>
Cc: Tom Zanussi <zanussi@us.ibm.com>, linux-kernel@vger.kernel.org,
       karim@opersys.com, varap@us.ibm.com, richardj_moore@uk.ibm.com,
       relayfs-devel@lists.sourceforge.net
Subject: Re: [PATCH] Re: relayfs documentation sucks?
In-Reply-To: <20050717194558.GC27353@outpost.ds9a.nl>
References: <17107.6290.734560.231978@tut.ibm.com>
	<20050716210759.GA1850@outpost.ds9a.nl>
	<17113.38067.551471.862551@tut.ibm.com>
	<20050717090137.GB5161@outpost.ds9a.nl>
	<17114.31916.451621.501383@tut.ibm.com>
	<20050717194558.GC27353@outpost.ds9a.nl>
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert writes:
 > On Sun, Jul 17, 2005 at 10:43:40AM -0500, Tom Zanussi wrote:
 > 
 > > It is racey - in this mode, there's nothing to keep the kernel from
 > > writing as much as it wants before the user side has a chance to read
 > > any of it.  The only way this can be used safely is to make sure the
 > > kernel side isn't writing anything when the client is reading.  This
 > > would be typical of a flight-recording usage i.e. kernel writes a
 > > bunch of data continuously, then stops and allows the client to read
 > > whatever's in there.
 > 
 > Or by numbering entries written out, when in flight-recording mode you
 > wouldn't want to block the kernel.
 > 
 > >  > In fact, it appears this might even happen in non-overwrite mode.
 > > 
 > > It shouldn't ever be able to happen in non-overwrite mode - if it
 > > did, it would be a bug.  Can you be more specific as to how you see
 > > this happening in this mode?
 > 
 > Yeah - you're right. The misunderstanding is because in both cases
 > (overwrite and non-overwrite) data is lost, except that in one case you lose
 > old data, and in the other new data.

Just to clarify - in either mode, if you don't have a consumer or the
consumer can't keep up with the amount of data being written by the
kernel, you will of course lose data at some point.  Normally you
wouldn't want to lose data; by using non-overwrite mode you're
implicitly letting relayfs know this i.e. if at any point all the
sub-buffers remain unread and the kernel is still trying to write into
them, let the client know (via the buffer-full callback) that this has
happened.  Presumably you would then increase the buffer size or have
the kernel write less etc.

 > 
 > It might be a good idea to document this as well.
 > 

Yes, I'll make it more explicit in the documentation.

 > Btw, I've already uncovered interesting things using relayfs, but I still
 > don't see the case for having it merged :-)

Glad to hear it.  Can you say what if anything would convince you it
should be merged?

 > 
 > Thanks for your answers, I think I get it all now.

No problem, and thanks for patch and other suggestions.

Tom


