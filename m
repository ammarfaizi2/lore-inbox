Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262634AbUDLEOZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 00:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262673AbUDLEOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 00:14:25 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:20908 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S262634AbUDLEOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 00:14:24 -0400
Message-ID: <407A1787.5060508@myrealbox.com>
Date: Sun, 11 Apr 2004 21:13:59 -0700
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@hp.com>
CC: Matthew Wilcox <willy@debian.org>, John Belmonte <john@neggie.net>,
       acpi-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] Re: [PATCH] filling in ACPI method access via sysfs  
 namespace
References: <fa.n5srcao.1k1orra@ifi.uio.no> <fa.e0sva3e.u5k09i@ifi.uio.no>
In-Reply-To: <fa.e0sva3e.u5k09i@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Williamson wrote:

> On Sun, 2004-04-11 at 16:29, Matthew Wilcox wrote:
> 
>>It seems unintuitive that you have to read the file for the method to
>>take effect.  How about having the write function invoke the method and
>>(if there is a result) store it for later read-back via the read function?
>>It should be discarded on close, of course.  A read() on a file with
>>no stored result should invoke the ACPI method (on the assumption this
>>is a parameter-less method) and return the result directly.  Closing a
>>file should discard any result from the method.
> 
> 
>    How's this?  It behaves the way you described, but might be doing
> some questionable things with the buffer to get there.  Is there a
> better place to store the return data than back into the buf passed to
> write() (aka file->private_data)?  Without adding callbacks to
> open/close, I'm not sure how else we can dispose of the results on
> close.  Thanks,

Is there any reason this shouldn't be an ioctl?

--Andy

