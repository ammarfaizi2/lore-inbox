Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269838AbUJHL2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269838AbUJHL2l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 07:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269839AbUJHL02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 07:26:28 -0400
Received: from holomorphy.com ([207.189.100.168]:11734 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269838AbUJHLZK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 07:25:10 -0400
Date: Fri, 8 Oct 2004 04:24:55 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jaakko Hyv?tti <jaakko@hyvatti.iki.fi>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm2
Message-ID: <20041008112455.GH9106@holomorphy.com>
References: <20040922131210.6c08b94c.akpm@osdl.org> <Pine.LNX.4.58.0410021038060.25679@gyre.weather.fi> <20041002004938.175203ba.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041002004938.175203ba.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jaakko Hyv?tti <jaakko@hyvatti.iki.fi> wrote:
>> Forgive me for asking a question that probably enough research would
>> answer, but which exact patch of those listed does fix this problem?  I
>> cannot find the right one myself, and I would like to just address this
>> problem that has haunted me at least since 2.6.6, I guess.  Or is the fix
>> too interdependent with other changes?

On Sat, Oct 02, 2004 at 12:49:38AM -0700, Andrew Morton wrote:
> It was wait_on_bit-must-loop.patch.
> But that simply fixes a bug which was introduced into an earlier
> 2.6.9-rcX-mmY kernel.  The bug is certainly not present in any Linus
> kernel, nor in any 2.6.6/7/8 kernel.
> So you're seeing something different.  Please send a full report.

Well, for the record, it's that otherwise one would have to honor the
invariant of no spurious wakeups, which e.g. jbd does not. There
actually was API forethought put into timeouts, but jbd uses a timer
and wake_up_process() instead of schedule_timeout(), and is nontrivial
to convert. It was also anticipated that e.g. other users may trip up.


-- wli
