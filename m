Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268058AbUH1Wdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268058AbUH1Wdr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 18:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268039AbUH1Wdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 18:33:47 -0400
Received: from holomorphy.com ([207.189.100.168]:2986 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268058AbUH1Wdg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 18:33:36 -0400
Date: Sat, 28 Aug 2004 15:33:32 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2/5] consolidate bit waiting code patterns
Message-ID: <20040828223332.GA5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040828200549.GR5492@holomorphy.com> <20040828200659.GS5492@holomorphy.com> <20040828200841.GT5492@holomorphy.com> <20040828152904.4721522c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040828152904.4721522c.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> +void fastcall __wake_up_bit(wait_queue_head_t *wq, void *word, int bit)
>>  +{
>>  +	struct wait_bit_key key = __WAIT_BIT_KEY_INITIALIZER(word, bit);
>>  +	if (waitqueue_active(wq))
>>  +		__wake_up(wq, TASK_INTERRUPTIBLE|TASK_UNINTERRUPTIBLE, 1, &key);
>>  +}

On Sat, Aug 28, 2004 at 03:29:04PM -0700, Andrew Morton wrote:
> The waitqueue_active() test needs a preceding barrier.  Did it
> come from somewhere else, implicitly?

Yes, it comes from clearing the bit prior to calling this for wakeup.


-- wli
