Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751406AbWCSFJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbWCSFJn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 00:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbWCSFJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 00:09:43 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:6100 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751406AbWCSFJm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 00:09:42 -0500
Date: Sun, 19 Mar 2006 13:09:56 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/23] Adaptive read-ahead V11
Message-ID: <20060319050956.GA4313@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Jon Smirl <jonsmirl@gmail.com>, linux-kernel@vger.kernel.org
References: <20060319023413.305977000@localhost.localdomain> <9e4733910603181910p21117f3anc107673e31f6352b@mail.gmail.com> <20060319034750.GA8732@mail.ustc.edu.cn> <9e4733910603182010p394c3233p81825b093fb693c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910603182010p394c3233p81825b093fb693c@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18, 2006 at 11:10:33PM -0500, Jon Smirl wrote:
> > Maybe the user space solution does the trick by using a larger window size?
> >
> > IMHO, the stock read-ahead is not designed with extremely high concurrency in
> > mind. However, 100 streams should not be a problem at all.
> 
> Has anyone checked to see if the readahead logic is working as
> expected from sendfile? IO from sendfile is a different type of
> context than IO from user space, there could be sendfile specific

AFAIK, sendfile() and read() use the same readahead logic, which
handles them equally good.  And there is another readaround logic
which handles unhinted mmapped reads.

> problems. If window size is the trick, shouldn't sendfile
> automatically adapt it's window size? I don't think you can control
> the sendfile window size from user space.

For whole file readings, the stock readahead logic by default uses a fixed
window size of VM_MAX_READAHEAD=128KB, the adaptive readahead logic
uses an adaptive window size with a high limit of VM_MAX_READAHEAD=1024KB.

The VM_MAX_READAHEAD in the kernel is used to init the .ra_pages
attribute of block devices, which can later be altered in _runtime_.
To set a 512KB window size limit for hda, one can do it in two ways:
1) blockdev --setra 1024 /dev/hda
2) echo 512 > /sys/block/had/queue/read_ahead_kb

Cheers,
Wu
