Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262659AbTCPLu2>; Sun, 16 Mar 2003 06:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262660AbTCPLu2>; Sun, 16 Mar 2003 06:50:28 -0500
Received: from holomorphy.com ([66.224.33.161]:53205 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262659AbTCPLu1>;
	Sun, 16 Mar 2003 06:50:27 -0500
Date: Sun, 16 Mar 2003 04:00:57 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cpu-2.5.64-1
Message-ID: <20030316120057.GI20188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
References: <20030316113254.GH20188@holomorphy.com> <17605.1047815599@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17605.1047815599@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Mar 2003 03:32:54 -0800, William Lee Irwin III wrote:
>> Another thought I had was wrapping things in structures for both small
>> and large, even UP systems so proper typechecking is enforced at all
>> times. That would probably need a great deal of arch sweeping to do,
>> especially as a number of arches are UP-only (non-SMP case's motive #2).

On Sun, Mar 16, 2003 at 10:53:19PM +1100, Keith Owens wrote:
> Keep the optimized model, where cpu_online_map is #defined to 1 for UP.
> Changing it to an ADT just to get type checking on architectures that
> only support UP looks like a bad tradeoff.

It shouldn't hurt UP:

typedef { unsigned long mask; } cpumask_t;

#define cpu_online_map ({ 1UL })

or some such nonsense with all the usual special cases. The arch code
impact OTOH can't really be gotten around with such tricks, if it's
significant. More food for thought...


-- wli
