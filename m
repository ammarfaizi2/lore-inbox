Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280732AbRKGBQB>; Tue, 6 Nov 2001 20:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280733AbRKGBPm>; Tue, 6 Nov 2001 20:15:42 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:16299 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S280732AbRKGBPd>;
	Tue, 6 Nov 2001 20:15:33 -0500
Date: Wed, 07 Nov 2001 01:15:29 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Kurt Roeckx <Q@ping.be>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: Riley Williams <rhw@MemAlpha.cx>, Pavel Machek <pavel@suse.cz>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: PROBLEM: Linux updates RTC secretly when clock synchronizes
Message-ID: <814537660.1005095728@[195.224.237.69]>
In-Reply-To: <20011107020137.A1887@ping.be>
In-Reply-To: <20011107020137.A1887@ping.be>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >  2. The kernel makes no internal reference to the /dev/rtc driver,
>> >     and it is left to userland tools to sync to the RTC on boot,
>> >     and at other times as required.
>>
>> I think the kernel should set the machine time to the RTC time
>> as an initializer on boot. Other than that, I agree.
>
> Which is something you do from userspace.

You have to initialize (once, on boot) this to
something. I don't really see the point of initializing
it to zero and putting the atime/mtime on a few entries
back to 1970, when we have the value there already.

We /know/ we have to use the RTC values for things
like apm suspend, for instance - I don't want my 'make'
to be broken through races with userspace time functions -
so if we are prepared to read RTC on resume, we should be
prepared to read RTC on boot.

--
Alex Bligh
