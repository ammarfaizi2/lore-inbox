Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbUCDSga (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 13:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbUCDSga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 13:36:30 -0500
Received: from waste.org ([209.173.204.2]:59560 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261942AbUCDSg2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 13:36:28 -0500
Date: Thu, 4 Mar 2004 12:35:16 -0600
From: Matt Mackall <mpm@selenic.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] kpatchup 0.02 kernel patching script
Message-ID: <20040304183516.GN3883@waste.org>
References: <20040303022444.GA3883@waste.org> <1078420922.19701.1362.camel@nighthawk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1078420922.19701.1362.camel@nighthawk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2004 at 09:22:02AM -0800, Dave Hansen wrote:
> On Tue, 2004-03-02 at 18:24, Matt Mackall wrote:
> > This is an alpha release for people to experiment with. Feedback and
> > patches encouraged. Grab your copy today at:
> 
> First of all, very nice script.
> 
> But, it doesn't look like it properly handles empty directories.  I
> tried this command, this morning, and it blew up.  I think it's because
> this directory http://www.kernel.org/pub/linux/kernel/v2.6/snapshots/ is
> empty because of last night's 2.6.4-rc2 release.  I don't grok python
> very well but is the "return p[-1]" there just to cause a fault like
> this?  Would it be better if it just returned a "no version of that
> patch right now" message and exited nicely?

Python does a good job at falling over loudly whenever anything
unexpected happens. I hadn't noticed that the snapshot directory got
purged. Hmmm. The right thing is to make it fall back to checking old/
where the most recent -bk is to be found. Like this:

$ kpatchup -s 2.6-pre
2.6.4-rc2
$ kpatchup -s 2.6-bk
2.6.4-rc1-bk4

New version at http://selenic.com/kpatchup/kpatchup-0.03

I've added a couple other niceties for scripting purposes: a -p option
which will report the "base" version for a given version, -m which
will parse Makefile and print the version therein.

> I think your script, combined with Rusty's latest-kernel-version could
> make me a very happy person.  

I skimmed latest-kernel-version, is it doing something my -s option
doesn't do yet?

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
