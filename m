Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266517AbUH0QZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266517AbUH0QZp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 12:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266479AbUH0QYC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 12:24:02 -0400
Received: from holomorphy.com ([207.189.100.168]:39839 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266519AbUH0QXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 12:23:23 -0400
Date: Fri, 27 Aug 2004 09:23:08 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Roger Luethi <rl@hellgate.ch>
Cc: linux-kernel@vger.kernel.org, Albert Cahalan <albert@users.sf.net>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [0/2][ANNOUNCE] nproc: netlink access to /proc information
Message-ID: <20040827162308.GP2793@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Roger Luethi <rl@hellgate.ch>, linux-kernel@vger.kernel.org,
	Albert Cahalan <albert@users.sf.net>, Paul Jackson <pj@sgi.com>
References: <20040827122412.GA20052@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040827122412.GA20052@k3.hellgate.ch>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 02:24:12PM +0200, Roger Luethi wrote:
> Problems with /proc
> ===================
> The information in /proc comes in a number of different formats, for
> example:
> - /proc/PID/stat works for parsers. However, because it is not
>   self-documenting, it can never shrink, It contains a growing number
>   of dead fields -- legacy tools expect them to be there. To make things
>   worse, there is no N/A value, which makes a field value 0 ambiguous.
> - /proc/pid/status is self-documenting. No N/A value is necessary --
>   fields can easily be added, removed, and reordered. Too easily, maybe.
>   Tool maintainers complain about parsing overhead and unstable file
>   formats.
> - /proc/slabinfo is something of a hybrid and tries to avoid the
>   weaknesses of other formats.
> So a key problem is that it's hard to make an interface that is both
> easy for humans and parsers to read. The amount of human-readable
> information in /proc has been growing and there's no way all these
> files will be rewritten again to favor parsers.

These are many of the same issues raised in rusty's "current /proc/ of
shit" thread from a while back.


On Fri, Aug 27, 2004 at 02:24:12PM +0200, Roger Luethi wrote:
> Another problem with /proc is speed. If we put all information in a few
> large files, the kernel needs to calculate many fields even if a tool
> is only interested in one of them. OTOH, if the informations is split
> into many small files, VFS and related overhead increases if a tool
> needs to read many files just for the information on one single process.
> In summary, /proc suffers from diverging goals of its two groups of
> users (human readers and parsers), and it doesn't scale well for tools
> monitoring many fields or many processes.

There are more maintainability benefits from the interface improvement
than speed benefits. How many processes did you microbenchmark with?
I see no evidence that this will be a speedup with large numbers of
processes, as the problematic algorithms are preserved wholesale.


-- wli
