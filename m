Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266537AbTGJWjx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 18:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269635AbTGJWjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 18:39:53 -0400
Received: from oak.sktc.net ([64.71.97.14]:63622 "EHLO oak.sktc.net")
	by vger.kernel.org with ESMTP id S266537AbTGJWju (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 18:39:50 -0400
Message-ID: <3F0DEEA4.5050605@sktc.net>
Date: Thu, 10 Jul 2003 17:54:28 -0500
From: "David D. Hagood" <wowbagger@sktc.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Style question: Should one check for NULL pointers?
References: <Pine.LNX.4.44L0.0307101606060.22398-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0307101606060.22398-100000@netrider.rowland.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is an old saying in software design:

"Never check for an error condition that you do not know how to handle."

In other words: if you have identified a possible error condition (such 
as a NULL pointer), until you have identified a way to meaningfully 
handle that error condition, simply testing for it is useless.

Now, if you have some function that can return an error code, then 
testing for NULL and returning an error condition is sensible. But if 
you have no way to report the error, then what good is the test?

However, if you test for NULL, and log a report when you detect it then 
deref it anyway (to force an OOPS, in other words throw an exception), 
then at least there is some meaningful info in the log.

But just doing something like

void foo(void *ptr)
{
    if (!ptr)
      return;

    ....
}

just masks the problem.

