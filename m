Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269811AbUIDAA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269811AbUIDAA5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 20:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269991AbUIDAA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 20:00:57 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:12718 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269811AbUIDAAy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 20:00:54 -0400
Subject: Re: [patch] kernel sysfs events layer
From: Daniel Stekloff <dsteklof@us.ibm.com>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Robert Love <rml@ximian.com>, Greg KH <greg@kroah.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1094163351.26430.107.camel@localhost.localdomain>
References: <1093988576.4815.43.camel@betsy.boston.ximian.com>
	 <1094004324.1916.63.camel@localhost.localdomain>
	 <20040901100750.GA23337@vrfy.org>
	 <1094157902.1316.83.camel@DYN319498.beaverton.ibm.com>
	 <1094163351.26430.107.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1094255991.1315.34.camel@DYN319498.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 03 Sep 2004 16:59:51 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-02 at 15:15, Kay Sievers wrote:
[snip]
> Maybe we just need to rename "kevent" to "kobject_notify" to make the
> focus more clear :)


Thanks, Kay, for answering my questions. 

I'm wondering if you've narrowed the interface too much in respect to
possible events. I'm interested in error event notification. My goal is
to work on creating common, consistent, and meaningful error messages or
notifications that can be easily understood or used to trigger events.
Possible responses to error messages - in User Space - could be to spit
out a more detailed error message to the console that includes possible
causes, possible actions, and the erroring device information (gathered
from HAL and/or sysfs) or to automatically launch a diagnostic. 

While I'm currently more interested in the actual error events, I
thought I could take advantage of the proposed kevent interface because
parsing /var/log/messages is cumbersome. But now I'm not so sure.

I was thinking the send_kevent form that included the payload could be
put into dev_err() macros, so we didn't have to add yet another
interface to drivers. We could just patch dev_err(). I even thought we
could add a dev_event() for using specific events. 

Now I'm wondering if this interface would be useful for error events.
Most error events don't require data at event time, but there are some
that do. 

If you curious about the error events, I've started a list of actionable
error events that includes the current message string, possible causes,
and possible actions (it's a work in progress):

http://linux-diag.sourceforge.net/first_failure/FirstFailure.html

Thanks,
Dan

