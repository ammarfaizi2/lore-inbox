Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265825AbUGMUdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265825AbUGMUdc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 16:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265828AbUGMUdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 16:33:32 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:59301 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S265825AbUGMUd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 16:33:29 -0400
Date: Tue, 13 Jul 2004 13:32:46 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Anton Ertl <anton@mips.complang.tuwien.ac.at>
Cc: linux-kernel@vger.kernel.org, Jan Knutar <jk-lkml@sci.fi>,
       L A Walsh <lkml@tlinx.org>
Subject: Re: XFS: how to NOT null files on fsck?
Message-ID: <20040713203246.GB6614@taniwha.stupidest.org>
References: <20040713095300.GA2986@taniwha.stupidest.org> <E1BkNPP-0002cI-Tl@a4.complang.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1BkNPP-0002cI-Tl@a4.complang.tuwien.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2004 at 03:33:23PM +0200, Anton Ertl wrote:

> If the owner of the file is not the former owner of the block, the FS
> certainly should not put the block in the file.

sorry, i dont understand that

> How do you test?

running the code and pressing reset or similar

> We are balancing three things: making the file system nicer; working
> around non-nice file-systems in the applications; and losing data
> (even if it's just annoying rather than life-threatening).  IMO losing
> data is the worst of these alternatives, and making file system nicer
> is the best one.

all these things have trade-offs, plenty of people are happy with the
current balance

for those that are not you can use something else

> Right, but that's not sufficient.  I am not an expert on ext3, but
> from the description I have read that's all it guarantees.  If an
> application does a meta-data update, and then a data update, the
> disk state on crash might be that the data update was done and the
> meta-data update was not, which is not any of the states that ever
> existed logically.

i don't see how for ordered updates that can occur,  otherwise they
wouldn't be ordered

> Applications can be tested against that relatively easily by killing
> the application and seeing if the files are ok.

i've seen both KDE emacs loose data by crashing, does the fix for that
belong in the fs too?

> I am talking about ways that data can be lost because the file
> system does not have the nice semantics of a fully synchronous one.

mount -o sync

> The in-order guarantee is something that can be implemented
> relatively efficiently

let's see a patch, please give details of performance differences

i don't think the current situation is all bad or even undesirable,
yes, it is a balance and i think it's fine as-is

what you want a much more high-level semantics in the filesystem which
possibly will have large performance implications.  im not sure such
semantics are *required* to be in the fs or should be there

also, this is fixing the relatively rare case where the system
crashes, which to be quite honest is a bigger concern, why no seek
solutinos that deal with more common failure modes like applications
crashing or bahaving badly?

