Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269110AbUHXXNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269110AbUHXXNV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 19:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269108AbUHXXNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 19:13:21 -0400
Received: from holomorphy.com ([207.189.100.168]:65158 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269100AbUHXXMs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 19:12:48 -0400
Date: Tue, 24 Aug 2004 16:12:36 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: fix text reporting in O(1) proc_pid_statm()
Message-ID: <20040824231236.GG2793@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Albert Cahalan <albert@users.sf.net>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <1093388816.434.355.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093388816.434.355.camel@cube>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> - *text = mm->exec_vm - ((mm->end_code - mm->start_code) >> PAGE_SHIFT);
>> - *data = mm->total_vm - mm->shared_vm;
>> + *text = (mm->end_code - mm->start_code) >> PAGE_SHIFT;
>> + *data = mm->total_vm - mm->shared_vm - *text;

On Tue, Aug 24, 2004 at 07:06:56PM -0400, Albert Cahalan wrote:
> It's actually still wrong. This has been broken for
> a very long time. It you can fix it, great. Otherwise
> this is a useless value, since /proc/*/stat provides
> start_code and end_code already.
> The statm file is supposed to contain a field known
> as "trs" or "trss". This is like rss, but text-only.
> Likewise, statm also contains "drs" or "drss" for data.
> When you subtract start_code from end_code, you're
> generating a value known as "tsiz" (the text size).
> The statm file is supposed to supply trs, not tsiz.

The current 2.6 semantics are purely virtual, so this merely
reimplements those semantics more efficiently. The scheme you
describe would require accounting at the time of pte modification
to implement in a like fashion, which has been rejected.


On Tue, Aug 24, 2004 at 07:06:56PM -0400, Albert Cahalan wrote:
> Back in the days of a.out, statm also contained lrs
> for libraries. ELF broke this.
> The statm VM size is supposed to count IO mappings.
> So if your X server maps 64 MB of video RAM, then
> the statm file should have a value 64 MB larger than
> the status file has.

This would not be difficult to perform additional accounting for.
I'll follow up with that shortly.


-- wli
