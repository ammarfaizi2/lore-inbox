Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287359AbSBMQcZ>; Wed, 13 Feb 2002 11:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287658AbSBMQcP>; Wed, 13 Feb 2002 11:32:15 -0500
Received: from [195.63.194.11] ([195.63.194.11]:43529 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S287359AbSBMQcH>; Wed, 13 Feb 2002 11:32:07 -0500
Message-ID: <3C6A94EF.9050904@evision-ventures.com>
Date: Wed, 13 Feb 2002 17:31:43 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolabs.com>
CC: Vojtech Pavlik <vojtech@suse.cz>, Pavel Machek <pavel@suse.cz>,
        Jens Axboe <axboe@suse.de>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: another IDE cleanup: kill duplicated code
In-Reply-To: <20020212132846.A7966@suse.cz> <3C690E56.3070606@evision-ventures.com> <20020212135701.A16420@suse.cz> <3C6915FC.2020707@evision-ventures.com> <20020212144300.A18431@suse.cz> <3C691F9C.10303@evision-ventures.com> <20020212154251.A25201@suse.cz> <3C693357.8000204@evision-ventures.com> <20020212112803.P9826@lynx.turbolabs.com> <3C6A5D99.1040102@evision-ventures.com> <20020213092435.C25535@lynx.turbolabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:

>Well, then you have no idea about how the current LVM code works.  The
>way it does everything is to read the data from disk, convert endianness
>and such, and then pass it to the kernel via IOCTL.  I have no comment
>on whether this is a good or bad way to do it.  The point is that the
>struct marked "core" which you are deleting this unused field from is
>filled in from user-space, so you can't just change it when you want.
>
>Rather than spending a lot of time breaking the kernel/user interface
>and forcing everyone using LVM to update their user tools, just leave
>this field in the struct.  Feel free to remove the actual code that
>does the read-ahead if you want, but leave the lv_read_ahead field
>
Please note that there is *no* code doing any read-ahead there, which 
could be removed.
There is just setting and passing around of the lv_read_ahead field, 
without actually any
*results*. OK?

>in this struct alone.  The entire LVM code is going to be replaced
>by either LVM2 (just entered beta) or EVMS (in beta for a while now).
>

Thank you for explaining this issue. It appears then that the comments 
there are a bit missguiding.
I didn't look into the lvm user land code indeed. And the isn't even 
#ifdef __KERNEL__  stuff
in lvm.h. Of course you are right, that one just should remove the code 
and leave the layout
of the structure alone.


