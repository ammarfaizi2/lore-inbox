Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264930AbUELCRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264930AbUELCRr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 22:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264940AbUELCRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 22:17:47 -0400
Received: from mail.tpgi.com.au ([203.12.160.58]:52158 "EHLO mail2.tpgi.com.au")
	by vger.kernel.org with ESMTP id S264930AbUELCRo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 22:17:44 -0400
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Todd Poynor <tpoynor@mvista.com>, Greg KH <greg@kroah.com>
Subject: Re: Hotplug events for system suspend/resume
Date: Wed, 12 May 2004 12:16:02 +1000
User-Agent: KMail/1.5.3
Cc: mochel@digitalimplant.org, linux-hotplug-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <20040511010015.GA21831@dhcp193.mvista.com> <20040511230001.GA26569@kroah.com> <40A17251.2000500@mvista.com>
In-Reply-To: <40A17251.2000500@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405121216.02787.ncunningham@linuxmail.org>
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Unless I'm missing something, this will break all existing implementations of 
S3 and S4 because they all freeze userspace processes prior to suspending 
drivers. They do this because they assume it is the responsibility of 
userspace to handle these actions prior to telling the kernel to suspend.

In my mind, this approach is simpler and makes more sense: userspace should 
worry about userspace actions related to suspending before calling 
kernelspace. Kernel space should then only worry about saving and restoring 
driver states and should be transparent to user space. If at resume time, 
some devices have really gone away or appeared, hot[un]plugging events can 
call userspace then.

One other point: If we have userspace calling kernelspace which calls 
userspace, won't we also have to be very careful about not setting up 
feedback loops? (Who knows what userspace will do in response to our unplug 
notification).

Regards,

Nigel

