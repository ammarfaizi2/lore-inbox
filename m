Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030460AbWALQ0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030460AbWALQ0p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 11:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030464AbWALQ0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 11:26:45 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:7495 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030460AbWALQ0o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 11:26:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=NkBMJszhUODJyt+TMfQn/Pdq8BoJwBZeRGdw8ZWWGULcB9i5IBhD1LN6hd3sY3k5yuTEmg9pvjJNQ7S2aAR4H1OpqLJgUfVjxfODCKVSwvrHBCbkDiCprmHkpF2d+IsX0QPkdwsgwj6DUH1/IR9mlKR4uTyGLCO9rM8aBd274ZQ=
Message-ID: <43C6833C.1000704@gmail.com>
Date: Fri, 13 Jan 2006 01:26:36 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
CC: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk: fix possible queue stall in blk_do_ordered
References: <20060112152949.GA9855@htj.dyndns.org> <43C67F20.30300@rtr.ca>
In-Reply-To: <43C67F20.30300@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Tejun Heo wrote:
> 
>> Previously, if a fs request which was being drained failed and got
>> requeued, blk_do_ordered() didn't allow it to be reissued, which
>> causes queue stall.  This patch makes blk_do_ordered() use the
>> sequence of each request to determine whether a request can be issued
>> or not.  This fixes the bug and simplifies code.
> 
> 
> What kernel(s) is this against?  The patch seems to fail on 2.6.15.
> 
> Thanks

It's against v2.6.15-mm2.  It's sort of a follow-up patch for the following.

http://marc.theaimsgroup.com/?l=linux-kernel&m=113707430626490&w=2

-- 
tejun
