Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261511AbVGLPxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbVGLPxs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 11:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbVGLPxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 11:53:48 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:15591 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261489AbVGLPxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 11:53:46 -0400
Subject: Re: Merging relayfs?
From: Steven Rostedt <rostedt@goodmis.org>
To: Jason Baron <jbaron@redhat.com>
Cc: richardj_moore@uk.ibm.com, varap@us.ibm.com, karim@opersys.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       Tom Zanussi <zanussi@us.ibm.com>
In-Reply-To: <Pine.LNX.4.61.0507121050390.25408@dhcp83-105.boston.redhat.com>
References: <17107.6290.734560.231978@tut.ibm.com>
	 <Pine.LNX.4.61.0507121050390.25408@dhcp83-105.boston.redhat.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 12 Jul 2005 11:53:27 -0400
Message-Id: <1121183607.6917.47.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-12 at 10:58 -0400, Jason Baron wrote:
> On Mon, 11 Jul 2005, Tom Zanussi wrote:

> One concern I had regarding relayfs, which was raised previously, was 
> regarding its use of vmap, 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=110755199913216&w=2 On x86, 
> the vmap space is at a premium, and this space is reserved over the entire 
> lifetime of a 'channel'. Is the use of vmap really critical for 
> performance?

I believe that (Tom correct me if I'm wrong) the use of vmap was to
allocate a large buffer without risking failing to allocate. Since the
buffer does not need to be in continuous pages. If this is a problem,
maybe Tom can use my buffer method to make a buffer :-)

See http://www.kihontech.com/logdev where my logdev debugging tool that
allocates separate pages and uses an accounting system instead of the
more efficient vmalloc to keep the data in the pages together. I'm
currently working with Tom to get this to use relayfs as the back end.
But here you can take a look at how the buffering works and it doesn't
waste up vmalloc.

-- Steve


