Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264717AbUFSVej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264717AbUFSVej (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 17:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264723AbUFSVej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 17:34:39 -0400
Received: from holomorphy.com ([207.189.100.168]:45711 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264717AbUFSVeh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 17:34:37 -0400
Date: Sat, 19 Jun 2004 14:34:33 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] flexible-mmap-2.6.7-D5
Message-ID: <20040619213433.GT1863@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
References: <20040618213814.GA589@elte.hu> <20040618231631.GO1863@holomorphy.com> <20040619074612.GB12020@elte.hu> <20040619083446.GP1863@holomorphy.com> <20040619113836.GA16197@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040619113836.GA16197@elte.hu>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* William Lee Irwin III <wli@holomorphy.com> wrote:
>> Also, I suspect some more graceful fallback would make sense
>> particularly for the case of RLIM_INFINITY, which would leave users
>> that run with, say, all rlimits at RLIM_INFINITY in the interest of
>> having full access to system resources with a mere 512MB of
>> virtualspace for the heap, which IIRC glibc is intelligent enough to
>> circumvent for malloc(), but not for mmap(NULL, ...). [...]

On Sat, Jun 19, 2004 at 01:38:36PM +0200, Ingo Molnar wrote:
> well, the 5/6=stack 1/6=malloc rule in the RLIM_INFINITY can be changed. 
> What would make the most sense - 1/2 for both?

I had in mind fallback as opposed to a changed base, but a particular
choice of the base may cover enough cases. The bugreport below seems to
say there's no need for a change.


* William Lee Irwin III <wli@holomorphy.com> wrote:
>> If it's been in production that long, I find it hard to believe that's
>> never been tripped over. [...]

On Sat, Jun 19, 2004 at 01:38:36PM +0200, Ingo Molnar wrote:
> it's been tripped over and the 5/6 rule was a fix for such a bugreport. 
> What happens more in practice frequently is that someone needs a big
> stack and sets the stack ulimit to RLIM_INFINITY.

This sounds like nothing is needed, then.


* William Lee Irwin III <wli@holomorphy.com> wrote:
>> [...] (also, that 128MB is currently wasted); [...]

On Sat, Jun 19, 2004 at 01:38:36PM +0200, Ingo Molnar wrote:
> the 128MB is 'wasted' to give some flexibility to the stack rlimits
> changing runtime. But in practice it's far more important to have the
> mmap()/malloc() space maximized and flexible than to give the stack
> automatic flexibility.

Fishing around down there to utilize it for mmap() placement should
happen anyway if things fall back far enough in the top-down scheme.

Answers like "I've thought about it" or "I've seen this and dealt with
it" are good enough for me. There isn't much of a normative aspect to
user virtualspace layout.

Thanks.


-- wli
