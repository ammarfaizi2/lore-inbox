Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262530AbTE2TZk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 15:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbTE2TZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 15:25:40 -0400
Received: from holomorphy.com ([66.224.33.161]:51081 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262530AbTE2TZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 15:25:39 -0400
Date: Thu, 29 May 2003 12:38:49 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Morten Helgesen <morten.helgesen@nextframe.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: list_head debugging patch
Message-ID: <20030529193849.GB8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Morten Helgesen <morten.helgesen@nextframe.net>,
	linux-kernel@vger.kernel.org
References: <20030529130807.GH19818@holomorphy.com> <200305292122.44041.morten.helgesen@nextframe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305292122.44041.morten.helgesen@nextframe.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 May 2003 15:08, William Lee Irwin III wrote:
>> This appears to get the kernel to crap its pants in very, very
>> short order. Given the number of things going wrong, I almost
>> wonder if I did something wrong. Things get real ugly, really,
>> really fast.

On Thu, May 29, 2003 at 09:22:43PM +0200, Morten Helgesen wrote:
> [snip]
> I gave this a go - booted without problems. I did some 
> untaring/copying/deleting and didn`t see anything unusual, but a 
> 'dbench 8' died right away. 
[...]
> EIP is at clear_queue_congested+0x78/0xb0

clear_queue_congested() is doing an opportunistic check for list_empty()
without taking a lock. The patch basically changes list_empty() to look
at elements of the list instead of just pieces of the head. As opposed
to auditing for this, could you remove the __list_head_check() from
list_empty() and try again?

Thanks.

-- wli
