Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263241AbTH0Jot (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 05:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263251AbTH0Jos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 05:44:48 -0400
Received: from holomorphy.com ([66.224.33.161]:8374 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263241AbTH0JoH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 05:44:07 -0400
Date: Wed, 27 Aug 2003 02:45:12 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Takao Indoh <indou.takao@soft.fujitsu.com>
Cc: Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
Subject: Re: cache limit
Message-ID: <20030827094512.GZ1715@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Takao Indoh <indou.takao@soft.fujitsu.com>,
	Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
References: <20030826094634.GP4306@holomorphy.com> <19C36C7EA5D3E5indou.takao@soft.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19C36C7EA5D3E5indou.takao@soft.fujitsu.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 27, 2003 at 06:36:10PM +0900, Takao Indoh wrote:
> This problem happened a few month ago and the detailed data does not
> remain. Therefore it is difficult to know what is essential cause for
> this problem, but, I guessed that pagecache used as I/O cache grew
> gradually during system running, and finally it oppressed memory.

But this doesn't make any sense; the only memory you could "oppress"
is pagecache.


On Wed, Aug 27, 2003 at 06:36:10PM +0900, Takao Indoh wrote:
> Besides this problem, there are many cases where increase of pagecache
> causes trouble, I think.
> For example, DBMS.
> DBMS caches index of DB in their process space.
> This index cache conflicts with the pagecache used by other applications,
> and index cache may be paged out. It cause uneven response of DBMS.
> In this case, limiting pagecache is effective.

Why is it effective? You're describing pagecache vs. pagecache
competition and the DBMS outcompeting the cooperating applications for
memory to the detriment of the workload; this is a very different
scenario from what "limiting pagecache" sounds like.

How do you know it would be effective? Have you written a patch to
limit it in some way and tried running it?


On Tue, 26 Aug 2003 02:46:34 -0700, William Lee Irwin III wrote:
>> One thing I thought of after the post was whether they actually had in
>> mind tunable hard limits on _unmapped_ pagecache, which is, in fact,
>> useful. OTOH that's largely speculation and we really need them to
>> articulate the true nature of their problem.

On Wed, Aug 27, 2003 at 06:36:10PM +0900, Takao Indoh wrote:
> I also think that is effective. Empirically, in the case where pagecache
> causes memory shortage, most of pagecache is unmapped page. Of course
> real problem may not be pagecashe, as you or Mike said.

How do you know most of it is unmapped?

At any rate, the above assigns a meaningful definition to the words you
used; it does not necessarily have anything to do with the issue you're
trying to describe. If you could start from the very basics, reproduce
the problem, instrument the workload with top(1) and vmstat(1), and find
some way to describe how the performance is inadequate (e.g. performance
metrics for your running DBMS/whatever in MB/s or transactions/s etc.),
it would be much more helpful than proposing a solution up front.
Without any evidence, we can't know it is a solution at all, or that
it's the right solution.


-- wli
