Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbUCIHh2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 02:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbUCIHh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 02:37:28 -0500
Received: from holomorphy.com ([207.189.100.168]:55815 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261605AbUCIHh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 02:37:26 -0500
Date: Mon, 8 Mar 2004 23:37:20 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Mike Fedyk <mfedyk@matchmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH 4/4] vm-mapped-x-active-lists
Message-ID: <20040309073720.GJ655@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Nick Piggin <piggin@cyberone.com.au>,
	Mike Fedyk <mfedyk@matchmail.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Linux Memory Management <linux-mm@kvack.org>
References: <404D56D8.2000008@cyberone.com.au> <404D5784.9080004@cyberone.com.au> <404D5A6F.4070300@matchmail.com> <404D5EED.80105@cyberone.com.au> <20040309070246.GI655@holomorphy.com> <404D7109.10902@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <404D7109.10902@cyberone.com.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> Current efforts are now a background/spare time affair centering around
>> non-i386 architectures and driver audits.

On Tue, Mar 09, 2004 at 06:23:53PM +1100, Nick Piggin wrote:
> OK. I had just noticed that the people complaining about rmap most
> are the ones using 4K page size (x86-64 uses 4K, doesn't it?). Not
> that this fact means it is OK to ignore them problem, but I thought
> maybe pgcl might solve it in a more general way.
> I wonder how much you gain with objrmap / anobjrmap on say a 64K page
> architecture?

pgcl doesn't reduce userspace's mapping granularity. The current
implementation has the same pte_chain overhead as mainline for the same
virtualspace mapped. It's unclear how feasible it is to reduce this
overhead, though various proposals have gone around. I've ignored the
potential pte_chain reduction issue entirely in favor of concentrating
on more basic correctness and functionality. The removal of the 1:1 pte
page : struct page assumption is the vastly more important aspect of
anobjrmap in relation to pgcl, since removing that assumption would
remove a significant piece of complexity.

-- wli
