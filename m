Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264023AbTKJR7R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 12:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264005AbTKJR7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 12:59:17 -0500
Received: from terminus.zytor.com ([63.209.29.3]:59039 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S264023AbTKJR7N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 12:59:13 -0500
Message-ID: <3FAFD1E5.5070309@zytor.com>
Date: Mon, 10 Nov 2003 09:59:01 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030630
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Andrea Arcangeli <andrea@suse.de>, Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel.bkbits.net off the air
References: <Pine.LNX.4.44.0311100952280.2097-100000@bigblue.dev.mdolabs.com>
In-Reply-To: <Pine.LNX.4.44.0311100952280.2097-100000@bigblue.dev.mdolabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> On Mon, 10 Nov 2003, Andrea Arcangeli wrote:
> 
> 
>>the updates shows up on kernel.org, rsync can't even hang on per-file
>>locks, sure it can't be coherent as a whole.
>>
>>The best way to fix this isn't to add locking to rsync, but to add two
>>files inside or outside the tree, each one is a sequence number, so you
>>fetch file1 first, then you rsync and you fetch file2, then you compare
>>them. If they're the same, your rsync copy is coherent. It's the same
>>locking we introduced with vgettimeofday.
>>
>>Ideally rsync could learn to check the sequence numbers by itself but I
>>don't mind a bit of scripting outside of rsync.
> 
> Wouldn't a simpler  "stop-rsync -> update-root -> start-rsync" work? If 
> you'll hit an update you will get a error from your local rsync, that will 
> let you know to retry the operation.
> 

Part of the problem is that there are multiple steps in the rsync chain, 
some of which can't be stopped in this way.

The sequence number idea looks sensible to me.  Larry, would it be too 
much work to have the cvs repository generator generate these files?

	-hpa

