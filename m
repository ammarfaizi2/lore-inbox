Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261761AbVAHB4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbVAHB4Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 20:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261771AbVAHB4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 20:56:24 -0500
Received: from imf23aec.mail.bellsouth.net ([205.152.59.71]:8168 "EHLO
	imf23aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S261761AbVAHB4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 20:56:17 -0500
Date: Fri, 7 Jan 2005 20:49:17 -0500
From: David Meybohm <dmeybohmlkml@bellsouth.net>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: where to put kernel code to run on exec?
Message-ID: <20050108014917.GA2629@localhost>
Mail-Followup-To: Chris Friesen <cfriesen@nortelnetworks.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <41DEAFE2.1030001@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41DEAFE2.1030001@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 09:50:58AM -0600, Chris Friesen wrote:
> 
> I've added a field to the task struct to keep track of whether or not 
> the process wants to be notified of various events.  On exec() I'd like 
> to clear this field.
> 
> I'm having problems finding a nice clean place to put the code to clear 
> it.  The obvious choice would be in the last bit of the success path in 
> do_execve(), but there's nothing similar there already, so I'm probably 
> missing something.
> 
> Is there some standard place to put code to run on a successful call to 
> exec()?

What about in flush_old_exec()?  Any place after exec_mmap() looks good.
If the exec fails after that point, the process has to be killed,
because all the old memory space is gone.  In that case you don't have
to worry about clearing the field because the process is gone.

Dave
