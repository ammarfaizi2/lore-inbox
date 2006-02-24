Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932450AbWBXWCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbWBXWCW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 17:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbWBXWCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 17:02:22 -0500
Received: from jenny.ondioline.org ([66.220.1.122]:39437 "EHLO
	jenny.ondioline.org") by vger.kernel.org with ESMTP id S932450AbWBXWCW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 17:02:22 -0500
From: Paul Collins <paul@briny.ondioline.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kjournald keeps reference to namespace
References: <20060218013547.GA32706@MAIL.13thfloor.at>
	<20060217175428.7ce7b26f.akpm@osdl.org>
	<20060218033031.GB32706@MAIL.13thfloor.at>
	<873bi88n0s.fsf@briny.internal.ondioline.org>
	<20060224133605.7a8e86ca.akpm@osdl.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Date: Fri, 24 Feb 2006 22:01:40 +0000
In-Reply-To: <20060224133605.7a8e86ca.akpm@osdl.org> (Andrew Morton's message
	of "Fri, 24 Feb 2006 13:36:05 -0800")
Message-ID: <87y80076wr.fsf@briny.internal.ondioline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Paul Collins <paul@briny.ondioline.org> wrote:
>>
>>  Herbert Poetzl <herbert@13thfloor.at> writes:
>> 
>>  > On Fri, Feb 17, 2006 at 05:54:28PM -0800, Andrew Morton wrote:
>>  >> I think it'd be better to convert ext3 to use the kthread API which
>>  >> appears to accidentally not have this problem, because such threads
>>  >> are parented by keventd, which were parented by init.
>>  >
>>  > sounds like a plan!
>> 
>>  Here's my attempt at such a conversion.  Since jbd doesn't seem to
>>  want to collect an exit status, I didn't bother with kthread_stop().
>
> Ah.  I already did something similar. 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc4/2.6.16-rc4-mm2/broken-out/jbd-convert-kjournald-to-kthread-api.patch

Sweet, I managed to get it right at least.

>>  I got overexcited and also embedded the journal device in the process
>>  name, but that's probably useless churn.  Looks nice in pstree though:
>> 
>>       |         `-kjournald/254:1
>
> We only have 15 chars for that string - the final one you have there is on
> the raggedy edge.

Oh well, it's not that useful anyway.  I can count the number of times
I've needed to kill a particular kjournald on the fingers of one head.

-- 
Dag vijandelijk luchtschip de huismeester is dood
