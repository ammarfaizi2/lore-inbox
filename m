Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261537AbVGLQLa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbVGLQLa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 12:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbVGLQI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 12:08:59 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:21202 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261550AbVGLQIV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 12:08:21 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17107.60140.948145.153144@tut.ibm.com>
Date: Tue, 12 Jul 2005 11:08:12 -0500
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jason Baron <jbaron@redhat.com>, richardj_moore@uk.ibm.com,
       varap@us.ibm.com, karim@opersys.com, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Tom Zanussi <zanussi@us.ibm.com>
Subject: Re: Merging relayfs?
In-Reply-To: <1121183607.6917.47.camel@localhost.localdomain>
References: <17107.6290.734560.231978@tut.ibm.com>
	<Pine.LNX.4.61.0507121050390.25408@dhcp83-105.boston.redhat.com>
	<1121183607.6917.47.camel@localhost.localdomain>
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt writes:
 > On Tue, 2005-07-12 at 10:58 -0400, Jason Baron wrote:
 > > On Mon, 11 Jul 2005, Tom Zanussi wrote:
 > 
 > > One concern I had regarding relayfs, which was raised previously, was 
 > > regarding its use of vmap, 
 > > http://marc.theaimsgroup.com/?l=linux-kernel&m=110755199913216&w=2 On x86, 
 > > the vmap space is at a premium, and this space is reserved over the entire 
 > > lifetime of a 'channel'. Is the use of vmap really critical for 
 > > performance?
 > 
 > I believe that (Tom correct me if I'm wrong) the use of vmap was to
 > allocate a large buffer without risking failing to allocate. Since the
 > buffer does not need to be in continuous pages. If this is a problem,
 > maybe Tom can use my buffer method to make a buffer :-)
 > 

The main reason we use vmap is so that from the kernel side we have a
nice contiguous address range to log to even though the the pages
aren't actually contiguous.

 > See http://www.kihontech.com/logdev where my logdev debugging tool that
 > allocates separate pages and uses an accounting system instead of the
 > more efficient vmalloc to keep the data in the pages together. I'm
 > currently working with Tom to get this to use relayfs as the back end.
 > But here you can take a look at how the buffering works and it doesn't
 > waste up vmalloc.

It might be worthwhile to try out different alternatives and compare
them, but I'm pretty sure we won't be able to beat what's already in
relayfs.  The question is I guess, how much slower would be
acceptable?

Tom


