Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262596AbVDGXhZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262596AbVDGXhZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 19:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbVDGXhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 19:37:25 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:29606 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262596AbVDGXhK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 19:37:10 -0400
Subject: Re: ext3 allocate-with-reservation latencies
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1112879303.2859.78.camel@sisko.sctweedie.blueyonder.co.uk>
References: <1112673094.14322.10.camel@mindpipe>
	 <20050405041359.GA17265@elte.hu>
	 <1112765751.3874.14.camel@localhost.localdomain>
	 <20050407081434.GA28008@elte.hu>
	 <1112879303.2859.78.camel@sisko.sctweedie.blueyonder.co.uk>
Content-Type: text/plain
Organization: IBM LTC
Date: Thu, 07 Apr 2005 16:37:02 -0700
Message-Id: <1112917023.3787.75.camel@dyn318043bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-07 at 14:08 +0100, Stephen C. Tweedie wrote:
> Hi,
> 
> On Thu, 2005-04-07 at 09:14, Ingo Molnar wrote:
> 
> > doesnt the first option also allow searches to be in parallel?
> 
> In terms of CPU usage, yes.  But either we use large windows, in which
> case we *can't* search remotely near areas of the disk in parallel; or
> we use small windows, in which case failure to find a free bit becomes
> disproportionately expensive (we have to do an rbtree link and unlink
> for each window we search.)

Actually, we do not have to do an rbtree link and unlink for every
window we search.  If the reserved window(old) has no free bit and the
new reservable window's is right after the old one, no need to unlink
the old window from the rbtree and then link the new window, just update
the start and end of the old one. That's in the current designed
already, to reduce the cost of rbtree link and unlink.

Mingming


