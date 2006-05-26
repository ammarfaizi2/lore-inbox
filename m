Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751333AbWEZHLH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbWEZHLH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 03:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWEZHLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 03:11:07 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:6558 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751333AbWEZHLG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 03:11:06 -0400
Message-ID: <4476A951.2070003@aitel.hist.no>
Date: Fri, 26 May 2006 09:08:01 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
CC: Jon Smirl <jonsmirl@gmail.com>, "D. Hazelton" <dhazelton@enter.net>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <44700ACC.8070207@gmail.com> <A78F7AE7-C3C2-43DA-9F17-D196CCA7632A@mac.com> <200605230048.14708.dhazelton@enter.net> <9e4733910605231017g146e16dfnd61eb22a72bd3f5f@mail.gmail.com> <6896241F-3389-4B20-9E42-3CCDDBFDD312@mac.com> <44740533.7040702@aitel.hist.no> <447465C6.3090501@ums.usu.ru>
In-Reply-To: <447465C6.3090501@ums.usu.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander E. Patrakov wrote:
> Helge Hafting wrote:
>> Now, a panic/oops message is sure better than a silent hang, but 
>> that's it, really.
>> Anything less than that should just go in a logfile where the admin 
>> can look
>> it up later.  The very ability to write on the console will alway be 
>> abused
>> by some application programmer or kernel driver module vendor.
>> Blindly writing on the console won't be very useful either, the user 
>> might
>> be running a game or video which overwrites the message within 1/30s 
>> anyway.
>> Well, perhaps it can be done better than that, with some thought. I.e. :
>>
>> * block all further access to /dev/fb0, processes will wait.
>> * Mark graphichs memory "not present" for any process that have it 
>> mapped,
>>   so as to pagefault anyone using it directly.  (read-only is not 
>> enough,
>>  processes should see the graphichs memory they expect, not
>>  the kernel message)
>> * Try to allocate memory for saving the screen image (assuming the
>>   machine won't hang completely, it will often keep running after an 
>> oops)
>> * Annoy the user by showing the message
>> * Provide some way of letting the user decide when to proceed, such
>>   as pressing a key
>> * Restore the saved screen memory (if that allocation was successful)
>> * Mark framebuffer memory present, releasing pagefaulted processes
>> * Unblock /dev/fb0
>
> Still too complex. 
Sure - which is why I sort of hope it won't happen.
> Can't this be simplified to:
>
>  * Don't use the kernel text output facility for anything except 
> panics, where there is no point in allowing userspace applications to 
> continue
That's an option, of course.
>  * Rely on userspace to display oopses and less important messages, 
> because doing this from the kernel leads either to the complex 
> procedure outlined above (where the policy is in the kernel, e.g., on 
> which of the two keyboards should one wait for a keypress?) or to 
> unreliable displaying of messages
"Which of the two keyboards to read, which of the three screens to use
for messages" is not a problem.  The kernel would use whatever devices
is associated with the primary console - any extra devices would be left 
alone.
The console is normally one particular keyboard (or possibly all of them),
and /dev/fb0 in case of graphical console.  Other framebuffers are
not the primary console. 

Someone with a network console or printer console should get their message
there instead - assuming the subsystems in question still works.

>  * Have a method in the framebuffer driver for clearing the screen and 
> setting a known good mode, for the Linux equivalent of a "blue screen 
> of death"
Those are there already, if you're using a framebuffer device driver 
that is.

Helge Hafting

