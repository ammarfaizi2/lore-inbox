Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbWKDBg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbWKDBg2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 20:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753557AbWKDBg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 20:36:28 -0500
Received: from ns.suse.de ([195.135.220.2]:37577 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1753519AbWKDBg1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 20:36:27 -0500
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [rfc patch] i386: don't save eflags on task switch
Date: Sat, 4 Nov 2006 02:36:20 +0100
User-Agent: KMail/1.9.5
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Zachary Amsden <zach@vmware.com>
References: <200611031902_MC3-1-D042-CA1F@compuserve.com> <Pine.LNX.4.64.0611031645141.25218@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611031645141.25218@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611040236.20478.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 04 November 2006 01:46, Linus Torvalds wrote:
> 
> On Fri, 3 Nov 2006, Chuck Ebbert wrote:
> >
> > There is no real need to save eflags in switch_to().  Instead,
> > we can keep a constant value in the and always
> > restore that.
> 
> I don't really see the point. The "pushfl" isn't the expensive part, and 
> it gives sane and expected semantics.
> 
> The "popfl" is the expensive part, and that's the thing that can't really 
> even be removed.

Well it could -- i made an attempt at it recently. But it would add 
a little code to the SYSENTER entry code (basically a test / conditional
jump after the pushfl there) to clear any rogue flags on entry.
Not sure it is worth it. That is why i didn't put this patch in.

-Andi
