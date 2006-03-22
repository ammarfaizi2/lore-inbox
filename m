Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWCVLxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWCVLxv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 06:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWCVLxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 06:53:51 -0500
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:14467 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750784AbWCVLxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 06:53:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=O8y2YjeXNUHF98mHT1TCfUAJINzKx0klmrvVwiTWWHrRdQlOer+LMhGBHuS4b4TCBNIlWfUkaIScOP9zCV944CMhSD/Nh7BP99RT44UOAMhF1aSwTeD50Hkt5PFo53rN1crN7WCw7tVYg80QELhVNpoqVIEcbHM/kms3FFzdT28=  ;
Message-ID: <4421307F.8020300@yahoo.com.au>
Date: Wed, 22 Mar 2006 22:09:51 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
CC: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, mingo@elte.hu,
       akpm@osdl.org
Subject: Re: [PATCH] possible scheduler deadlock in 2.6.16
References: <20060322104143.GC30422@krispykreme>
In-Reply-To: <20060322104143.GC30422@krispykreme>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard wrote:

> One way to solve this is to always take runqueues in cpu id order. To do
> this we add a cpu variable to the runqueue and check it in the
> double runqueue locking functions.
> 
> Thoughts?
> 

You're right. I can't think of a better fix, although we've been trying
to avoid adding cpu to the runqueue structure.

I was going to suggest moving more work into wake_sleeping_dependent
instead, but cores with 4 and more threads now make that less desirable
I suppose.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
