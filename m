Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbVJSSft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbVJSSft (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 14:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbVJSSft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 14:35:49 -0400
Received: from zctfs063.nortelnetworks.com ([47.164.128.120]:36995 "EHLO
	zctfs063.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S1751211AbVJSSfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 14:35:48 -0400
Message-ID: <435691EF.8070406@nortel.com>
Date: Wed, 19 Oct 2005 12:35:27 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: Rick Niles <fniles@mitre.org>, linux-kernel@vger.kernel.org
Subject: Re: 26 ways to set a device driver variable from userland
References: <1129741246.25383.23.camel@gnupooh.mitre.org> <4C7CA605-435C-4B16-A3A1-44EF247BF5B0@mac.com>
In-Reply-To: <4C7CA605-435C-4B16-A3A1-44EF247BF5B0@mac.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Oct 2005 18:35:32.0415 (UTC) FILETIME=[E32BC4F0:01C5D4DB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:

>> (4) sysfs

> This is ideal for almost all device driver purposes.

The one thing that I have yet to see a good solution for is 
transaction-based operations, where userspace passes in something (could 
be a command, a new value, a query, etc.) and expects some data in return.

The ioctl() method is ideal for this, passing down a binary struct with 
a command/query member, and the driver fills in the rest of the struct 
based on the commnd.

How do you do this cleanly via sysfs?  It seems like you either double 
the number of syscalls (write to one file, read from another) or else 
you need to have sysfs files for every possible query/command, so that 
the input becomes implicitly encoded in the file that you are reading. 
This could end up creating a large number of files depending on the 
range of inputs.

Are there any other standard ways to do this?

Chris
