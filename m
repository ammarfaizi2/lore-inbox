Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269243AbUISN5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269243AbUISN5Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 09:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269242AbUISN5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 09:57:24 -0400
Received: from mail2.bluewin.ch ([195.186.4.73]:47746 "EHLO mail2.bluewin.ch")
	by vger.kernel.org with ESMTP id S269243AbUISN5Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 09:57:16 -0400
Date: Sun, 19 Sep 2004 15:57:05 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: nproc: So?
Message-ID: <20040919135705.GC10030@k3.hellgate.ch>
Mail-Followup-To: Albert Cahalan <albert@users.sf.net>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <1095440131.3874.4626.camel@cube> <20040917175130.GA7050@k3.hellgate.ch> <1095511212.4973.8.camel@cube> <20040919103951.GA17132@k3.hellgate.ch> <1095596996.4974.27.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095596996.4974.27.camel@cube>
X-Operating-System: Linux 2.6.9-rc2-bk1-nproc on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Sep 2004 08:29:57 -0400, Albert Cahalan wrote:
> > Do you mean "return cookies for all existing processes"? Or "return
> > cookies for all processes created since X" (if so, what's X?) ?
> 
> First, queue cookies for all existing processes.
> Then, as process data changes, queue cookies for
> processes that need to be examined again. Suppress
> queueing of cookies for processes that are already
> in the queue so things don't get too backed up.
> If memory usage exceeds some adjustable limit, then
> switch to supplying all processes until the backlog
> is gone.

How is the kernel to know which changes of process data require
re-examination? In all likelihood, any tool is only going to be
interested in certain changes, not in others.

> I realize that the implementation may prove difficult.

It seems reasonable (and useful) to notify tools if new processes get
created. It is certainly possible to have additional events (like field
changes) trigger notifications, but this would probably become rather
intrusive and expensive.

> > With nproc as-is you can send a request that matches your desired struct
> > and cast the result to a pointer to your struct.
> 
> Either that's marketing, or I missed something. :-)
> 
> Can I force specific data sizes? Can I force a string to
> be NUL-terminated or a NUL-padded fixed-length buffer?
> Can I request padding bytes to be skipped over?

No, your data types have to match what the kernel offers. What I was
referring to was your request for "info in groups that match what /proc
provides today". What you _can_ do with nproc is, say, ask it to return
a pointer to something like this:

struct statm_extended {
	__u32 pid;	/*
	__u32 namelen;	 * My simple cookie
	char name[16];	 */

	__u32 resident;	/*
	__u32 shared;	 *
	__u32 trs;	 * /proc/PID/statm content
	__u32 lrs;	 *
	__u32 drs;	 *
	__u32 dt;	 */
};

Roger
