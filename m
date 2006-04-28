Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751684AbWD1WJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751684AbWD1WJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 18:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751728AbWD1WJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 18:09:56 -0400
Received: from smtp-4.llnl.gov ([128.115.41.84]:985 "EHLO smtp-4.llnl.gov")
	by vger.kernel.org with ESMTP id S1751635AbWD1WJz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 18:09:55 -0400
From: Dave Peterson <dsp@llnl.gov>
To: Paul Jackson <pj@sgi.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/2 (repost)] mm: serialize OOM kill operations
Date: Fri, 28 Apr 2006 15:09:03 -0700
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, riel@surriel.com,
       nickpiggin@yahoo.com.au, ak@suse.de
References: <200604271308.10080.dsp@llnl.gov> <20060427140921.249a00b0.akpm@osdl.org> <20060427160250.a72cae11.pj@sgi.com>
In-Reply-To: <20060427160250.a72cae11.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604281509.03140.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 April 2006 16:02, Paul Jackson wrote:
> I'm still a little surprised that this per-mm 'oom_notify' bit
> was needed to implement what I thought was a single, global
> system wide oom killer serializer.

I think the title "mm: serialize OOM kill operations" was probably a
poor choice of words.  It sounds like all I want to do is make sure
tasks enter the OOM killer one-at-a-time.  My goal is actually to
prevent further OOM kill operations until the OOM kill in progress
has caused the victim task to free its address space (i.e. clean out
its mm_struct).  That way we don't shoot more processes than necessary
to resolve the OOM condition.
