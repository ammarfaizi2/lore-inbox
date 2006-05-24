Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932749AbWEXNzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932749AbWEXNzK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 09:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932750AbWEXNzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 09:55:10 -0400
Received: from relay4.usu.ru ([194.226.235.39]:8120 "EHLO relay4.usu.ru")
	by vger.kernel.org with ESMTP id S932749AbWEXNzI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 09:55:08 -0400
Message-ID: <447465C6.3090501@ums.usu.ru>
Date: Wed, 24 May 2006 19:55:18 +0600
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.8.0.2) Gecko/20060405 SeaMonkey/1.0.1
MIME-Version: 1.0
Newsgroups: gmane.linux.kernel
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: Jon Smirl <jonsmirl@gmail.com>, "D. Hazelton" <dhazelton@enter.net>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <44700ACC.8070207@gmail.com> <A78F7AE7-C3C2-43DA-9F17-D196CCA7632A@mac.com> <200605230048.14708.dhazelton@enter.net> <9e4733910605231017g146e16dfnd61eb22a72bd3f5f@mail.gmail.com> <6896241F-3389-4B20-9E42-3CCDDBFDD312@mac.com> <44740533.7040702@aitel.hist.no>
In-Reply-To: <44740533.7040702@aitel.hist.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.15; AVE: 6.34.1.32; VDF: 6.34.1.137; host: usu2.usu.ru)
X-AV-Checked: ClamAV using ClamSMTP@relay4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> Now, a panic/oops message is sure better than a silent hang, but that's 
> it, really.
> Anything less than that should just go in a logfile where the admin can 
> look
> it up later.  The very ability to write on the console will alway be abused
> by some application programmer or kernel driver module vendor.
> Blindly writing on the console won't be very useful either, the user might
> be running a game or video which overwrites the message within 1/30s 
> anyway.
> Well, perhaps it can be done better than that, with some thought. I.e. :
> 
> * block all further access to /dev/fb0, processes will wait.
> * Mark graphichs memory "not present" for any process that have it mapped,
>   so as to pagefault anyone using it directly.  (read-only is not enough,
>  processes should see the graphichs memory they expect, not
>  the kernel message)
> * Try to allocate memory for saving the screen image (assuming the
>   machine won't hang completely, it will often keep running after an oops)
> * Annoy the user by showing the message
> * Provide some way of letting the user decide when to proceed, such
>   as pressing a key
> * Restore the saved screen memory (if that allocation was successful)
> * Mark framebuffer memory present, releasing pagefaulted processes
> * Unblock /dev/fb0

Still too complex. Can't this be simplified to:

  * Don't use the kernel text output facility for anything except panics, where 
there is no point in allowing userspace applications to continue
  * Rely on userspace to display oopses and less important messages, because 
doing this from the kernel leads either to the complex procedure outlined above 
(where the policy is in the kernel, e.g., on which of the two keyboards should 
one wait for a keypress?) or to unreliable displaying of messages
  * Have a method in the framebuffer driver for clearing the screen and setting 
a known good mode, for the Linux equivalent of a "blue screen of death"

-- 
Alexander E. Patrakov
