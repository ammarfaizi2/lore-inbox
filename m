Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbWCXTAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbWCXTAs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 14:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964775AbWCXTAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 14:00:48 -0500
Received: from zipcon.net ([209.221.136.5]:8159 "HELO zipcon.net")
	by vger.kernel.org with SMTP id S964778AbWCXTAr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 14:00:47 -0500
Message-ID: <442441D9.6000507@beezmo.com>
Date: Fri, 24 Mar 2006 11:00:41 -0800
From: William D Waddington <william.waddington@beezmo.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFCLUE2] 64 bit driver 32 bit app ioctl
References: <4422B95D.9070900@beezmo.com> <17442.53257.711022.424119@alkaid.it.uu.se>
In-Reply-To: <17442.53257.711022.424119@alkaid.it.uu.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mikael Pettersson wrote:
> William D Waddington writes:
>  > Apologies for dashing this off without the proper homework.  My
>  > customer is out of country doing an installation, and didn't test
>  > this configuration first :(
>  > 
>  > Customer is running RHEL3 on a 64 bit PC.  Running the 64 bit kernel
>  > and my 64 bit driver.  They are calling the driver from their 32 bit
>  > app.  The driver supports a whole mess of ioctls.
>  > 
>  > It seems that the kernel is trapping the 32-bit ioctl call and returning
>  > an error to the app w/out calling the driver.  It looks like
>  > register_ioctl32_conversion() can convice the kernel that the driver can
>  > handle 32-bit calls, but it has to be called for each ioctl cmd (??)
> 
> In these old pre-compat_ioctl kernels you have to register each
> ioctl command individually. Yes that sucks. Live with it.
> 
>  > Putting aside (please) discussion of whether the kernel should presume
>  > to hijack private ioctls, and whether I should be using the ioctl
>  > interface at all (compatibility with app interface going back to 2.0
>  > and SunOS) is there some way to make _one_ register call to indicate
>  > that all my cmds are safe, or maybe an alternate ioctl entry point
>  > that the  kernel won't trap?
> 
> Not as long as you're stuck with old 2.4 kernels. 2.6 kernels since
> 2.6.11-rc2 allow you to set up a single ->compat_ioctl() method,
> but not even RHEL4 has that yet.

Thanks,

It's working OK in my test cases: FC1/64 and the customer's RHEL3.  I
just #include <asm/ioctl32.h> and register all my ioctls.  Ugh.

The location of ioctl32.h seems to move from 2.4 kernel to kernel (and
distro to distro??).  Any suggestion how to include in a universal way
and how to detect all the appropriate 64 bit configs for conditional
inclusion w/a 2.4 kernel?  I detest #ifdef'd code but I guess I have to
do that too, or just keep one version around for this specific case :(

Thanks again,
Bill
--------------------------------------------
William D Waddington
Bainbridge Island, WA, USA
william.waddington@beezmo.com
--------------------------------------------
"Even bugs...are unexpected signposts on
the long road of creativity..." - Ken Burtch

