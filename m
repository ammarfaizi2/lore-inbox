Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269212AbUISKkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269212AbUISKkV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 06:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269214AbUISKkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 06:40:21 -0400
Received: from mail4.bluewin.ch ([195.186.4.74]:32940 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id S269212AbUISKkN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 06:40:13 -0400
Date: Sun, 19 Sep 2004 12:39:51 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: nproc: So?
Message-ID: <20040919103951.GA17132@k3.hellgate.ch>
Mail-Followup-To: Albert Cahalan <albert@users.sf.net>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <1095440131.3874.4626.camel@cube> <20040917175130.GA7050@k3.hellgate.ch> <1095511212.4973.8.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095511212.4973.8.camel@cube>
X-Operating-System: Linux 2.6.9-rc2-bk1-nproc on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Sep 2004 08:40:12 -0400, Albert Cahalan wrote:
> To me, this looks like the killer feature. You could even
> skip the regular process info. Simply return process identification
> cookies that could be passed into a separate syscall to get
> the information.

Do you mean "return cookies for all existing processes"? Or "return
cookies for all processes created since X" (if so, what's X?) ?

> > True if you consider a static set of fields that never changes. Problematic
> > otherwise, because as soon as you start grouping fields together, you need
> > an agreement between kernel and user-space on the contents of these groups.
> 
> I suppose this is small potatoes compared to the overhead
> of dealing with ASCII, but individual field handling would
> be a bit slower.

Correct.

> For initial libproc support, I'd start by requesting info
> in groups that match what /proc provides today.

Makes perfect sense. You can pre-assemble an array of field IDs, hand
them over to the kernel, and get the requested fields in the requested
order.

> The stat() call simply fills in a struct. Given a per-process
> cookie (or a PID if you tolerate the race conditions), a syscall
> similar to stat() could fill in a struct.

With nproc as-is you can send a request that matches your desired struct
and cast the result to a pointer to your struct.

An application can build its own cookie simply by always requesting a set
of fields that _together_ can be used to identify a process. I reckon that
PID + process creation timestamp would be a good combination (except that
the latter is not currently available). The creation of the complete reply
to a request is atomic per process, the race is gone. What is not possible
right now is selecting processes based on a cookie -- the only selectors
so far are "all of them" and "select by PID".

Roger
