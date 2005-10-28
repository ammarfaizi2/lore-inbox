Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965026AbVJ1AsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965026AbVJ1AsP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 20:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965027AbVJ1AsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 20:48:15 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:11462 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S965026AbVJ1AsO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 20:48:14 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: sekharan@us.ibm.com
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Notifier chains are unsafe 
In-reply-to: Your message of "Thu, 27 Oct 2005 16:02:08 MST."
             <1130454128.3586.268.camel@linuxchandra> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 28 Oct 2005 10:48:00 +1000
Message-ID: <6933.1130460480@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Oct 2005 16:02:08 -0700, 
Chandra Seetharaman <sekharan@us.ibm.com> wrote:
>On Thu, 2005-10-27 at 17:21 -0400, Alan Stern wrote:
>> The other problem is that you violated Keith's statement that 
>> notifier_call_chain shouldn't take any locks.  On the other hand, if we
>
>I would interpret Keith's comment like this: callout should not be
>called with any locks held (because that would limit the callouts from
>blocking). 

We should be able to call notifier_call_chain() from any context.  That
includes oops, panic, NMI and other unmaskable machine check events.
If you can call notifier_call_chain() from an unmaskable context then
it follows that the callbacks cannot take any locks.  Locks are not
safe in NMI context.

