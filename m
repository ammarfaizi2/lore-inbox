Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264541AbUFNWXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264541AbUFNWXg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 18:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264551AbUFNWXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 18:23:35 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:64251 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S264541AbUFNWXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 18:23:34 -0400
Message-ID: <40CE2538.4060603@nortelnetworks.com>
Date: Mon, 14 Jun 2004 18:22:48 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bernd Petrovitsch <bernd@firmix.at>
CC: Oliver Neukum <oliver@neukum.org>, Steve French <smfltc@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: upcalls from kernel code to user space daemons
References: <1087250925.8828.3.camel@gimli.at.home>
In-Reply-To: <1087250925.8828.3.camel@gimli.at.home>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Petrovitsch wrote:
> On Mon, 2004-06-14 at 23:57, Chris Friesen wrote:
>  > Oliver Neukum wrote:
>  >
>  > >  > userspace daemon loops on ioctl()
>  > >  > kernel portion of ioctl call goes to sleep until something to do
>  > >  > when needed, fill in data and return to userspace
>  > >  > userspace does stuff, then passes data back down via ioctl()
>  > >  > ioctl() puts userspace back to sleep and continues on with other 
> work
>  > >
>  > > You could just as well implement an ordinary read()
>  >
>  > Not quite.  The userspace is passing data down as well.  I don't know 
> how you'd
>  > do that with read().
> 
> For this you use write().

And you eat another syscall per userspace call.  For the ioctl() case, you only 
need to issue a single call to ioctl().  You pass the result of the previous 
request down, and then when it returns you get the data for the next request.

Although I have to admit it's not pretty, and the performance improvements may 
not be worth the obfuscation of the code.

Chris
