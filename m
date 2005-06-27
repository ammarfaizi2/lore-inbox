Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262015AbVF0Xq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbVF0Xq7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 19:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbVF0Xq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 19:46:59 -0400
Received: from aeimail.aei.ca ([206.123.6.84]:35825 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S262015AbVF0Xqp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 19:46:45 -0400
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Rik Van Riel <riel@redhat.com>
Subject: Re: [PATCH] 0/2 swap token tuning
Date: Mon, 27 Jun 2005 19:46:32 -0400
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Song Jiang <sjiang@lanl.gov>
References: <Pine.LNX.4.61.0506261827500.18834@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.61.0506261827500.18834@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506271946.33083.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 June 2005 18:34, Rik Van Riel wrote:
> A while ago the swap token (aka token based thrashing control)
> mechanism was introduced into Linux.  This code improves performance
> under heavy VM loads, but can reduce performance under very light
> VM loads.
> 
> The cause turns out to be me overlooking something in the original
> token based thrashing control paper: the swap token is only supposed
> to be enforced while the task holding the swap token is paging data
> in, not while the task is running (and referencing its working set).
> 
> The temporary solution in Linux was to disable the swap token code
> and have users turn it on again via /proc.  The following patch
> instead approximates the "only enforce the swap token if the task
> holding it is swapping something in" idea.  This should make sure
> the swap token is effectively disabled when the VM load is low.
> 
> I have not benchmarked these patches yet; instead, I'm posting
> them before the weekend is over, hoping to catch a bit of test
> time from others while my own tests are being run ;)

Rik,

What are the suggested  values to put into /proc/sys/vm/swap_token_timeout ?
The docs are not at all clear about this (proc/filesystems.txt).

TIA,
Ed Tomlinson
