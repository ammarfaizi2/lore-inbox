Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267397AbUIPDXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267397AbUIPDXM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 23:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267403AbUIPDXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 23:23:12 -0400
Received: from holomorphy.com ([207.189.100.168]:5537 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267397AbUIPDXK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 23:23:10 -0400
Date: Wed, 15 Sep 2004 20:23:01 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Albert Cahalan <albert@users.sf.net>, Jakub Jelinek <jakub@redhat.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>, ak@muc.de
Subject: Re: get_current is __pure__, maybe __const__ even
Message-ID: <20040916032301.GJ9106@holomorphy.com>
References: <1095288600.1174.5968.camel@cube> <20040915231518.GB31909@devserv.devel.redhat.com> <20040915232956.GE9106@holomorphy.com> <1095300619.2191.6392.camel@cube> <20040916023604.GH9106@holomorphy.com> <4148FED6.100@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4148FED6.100@yahoo.com.au>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 10:10:20PM -0400, Albert Cahalan wrote:
>>> I don't think even barrier() is needed. Suppose gcc were to cache
>>> the value of current over a schedule. Who cares? It'll be the same
>>> after schedule() as it was before.

William Lee Irwin III wrote:
>> Not over a call to schedule(). In the midst of schedule().

On Thu, Sep 16, 2004 at 12:47:50PM +1000, Nick Piggin wrote:
> In a way, it is. Because after context_switch, the stack
> and registers have been replaced by the new task. So if
> current was cached somewhere before that task had scheduled
> off, then it still would be correct now that it is scheduled
> back on.
> At points *within* context_switch, current won't be right,
> but AFAIKS current is never used in there.

We have a clobber in inline asm and a manual barrier() so we don't need
to change anything if current were to be properly CSE'd. It's somewhat
academic; if current were (mis)used there, it would change.


-- wli
