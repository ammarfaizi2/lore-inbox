Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263292AbTJQCsV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 22:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263293AbTJQCsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 22:48:21 -0400
Received: from holomorphy.com ([66.224.33.161]:27014 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263292AbTJQCsU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 22:48:20 -0400
Date: Thu, 16 Oct 2003 19:51:28 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: /proc reliability & performance
Message-ID: <20031017025128.GA25291@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Albert Cahalan <albert@users.sf.net>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <1066356438.15931.125.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1066356438.15931.125.camel@cube>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 16, 2003 at 10:07:18PM -0400, Albert Cahalan wrote:
> Tie directory readers to a task_struct (or to
> some of the PID tracking structs), so that
> a directory reader is on a list. When a task
> exits, move the list of directory readers on
> to a neighboring task.
> That is O(1) on task exit, and generally O(n)
> for the whole /proc or /proc/42/task read.
> It's O(1) per step of the read, excepting
> where multiple directory readers wind up at
> the same location.
> Another benefit is that it is reliable as
> long as tasks don't move around on the lists.
> Each task will appear at most once, and will
> appear exactly once if it doesn't start or
> exit during the directory scan.

Several other things have been tried.
(a) something mingo wrote I forgot the nature of
(b) a thing manfred wrote that recovers positions in hashtable
	collision chains by sorting them, with O(chain length)
	insertion
(c) a thing I wrote that turns the tasklist and pid_chains into
	rbtrees and uses the last-seen pid to seek in O(lg(n))
	time, and uses a routine to seek and fill buffers as a
	drop-in replacement for get_tgid_list()/get_tid_list().

I have a current implementation of (c), as well as a patch to
restore 2.4 semantics to proc_pid_statm() in O(1) time.


-- wli
