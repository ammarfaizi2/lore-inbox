Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264547AbTI2TXq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 15:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264548AbTI2TXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 15:23:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:13270 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264547AbTI2TXn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 15:23:43 -0400
Date: Mon, 29 Sep 2003 12:23:33 -0700
From: Chris Wright <chrisw@osdl.org>
To: Bradley Chapman <kakadu_croc@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Defunct event/0 processes under 2.6.0-test6-mm1
Message-ID: <20030929122333.C6871@osdlab.pdx.osdl.net>
References: <20030929120910.A6895@osdlab.pdx.osdl.net> <20030929191352.10470.qmail@web40902.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030929191352.10470.qmail@web40902.mail.yahoo.com>; from kakadu_croc@yahoo.com on Mon, Sep 29, 2003 at 12:13:52PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Bradley Chapman (kakadu_croc@yahoo.com) wrote:
> He is right. I reverted call_usermodehelper-retval-fix-2.patch and everything
> works again. Why would that break the source of events/0 and hotplug?

That patch changes the SIGCHLD handler for kernel threads that are
started via wait_for_helper().  These threads are cloned from keventd
(hence events/0 as the process name), and they call hotplug.  The child
is not being reaped properly.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
