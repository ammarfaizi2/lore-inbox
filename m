Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316674AbSGHAE5>; Sun, 7 Jul 2002 20:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316675AbSGHAE4>; Sun, 7 Jul 2002 20:04:56 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:22717 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S316674AbSGHAEz>; Sun, 7 Jul 2002 20:04:55 -0400
Message-ID: <3D28D7A9.5010409@us.ibm.com>
Date: Sun, 07 Jul 2002 17:07:05 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Thunder from the hill <thunder@ngforever.de>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: BKL removal
References: <Pine.LNX.4.44.0207071551180.10105-100000@hawkeye.luckynet.adm> <3D28C3F0.7010506@us.ibm.com> <20020707235114.GE18298@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Sun, Jul 07, 2002 at 03:42:56PM -0700, Dave Hansen wrote:
> 
>>BKL use isn't right or wrong -- it isn't a case of creating a deadlock 
>>or a race.  I'm picking a relatively random function from "grep -r 
>>lock_kernel * | grep /usb/".  I'll show what I think isn't optimal 
>>about it.
>>
>>"up" is a local variable.  There is no point in protecting its 
>>allocation.  If the goal is to protect data inside "up", there should 
>>probably be a subsystem-level lock for all "struct uhci_hcd"s or a 
>>lock contained inside of the structure itself.  Is this the kind of 
>>example you're looking for?
> 
> 
> Nice example, it proves my previous points:
> 	- you didn't send this to the author of the code, who is very
> 	  responsive when you do.
> 	- you didn't send this to the linux-usb-devel list, which is a
> 	  very responsive list.
> 	- this is in the file drivers/usb/host/uhci-debug.c, which by
> 	  its very nature leads you to believe that this is not critical
> 	  code at all.  This is true if you look at the code.
> 	- it looks like you could just remove the BKL entirely from this
> 	  call, and not just move it around the kmalloc() call.  But
> 	  since I don't understand all of the different locking rules
> 	  inside the uhci-hcd.c driver, I'm not going to do this.  I'll
> 	  let the author of the driver do that, incase it really matters
> 	  (and yes, the locking in the uhci-hcd driver is tricky, but
> 	  nicely documented.)
> 	- this file is about to be radically rewritten, to use driverfs
> 	  instead of procfs, as the recent messages on linux-usb-devel
> 	  state.  So any patch you might make will probably be moot in
> 	  about 3 days :)  Again, contacting the author/maintainer is
> 	  the proper thing to do.

You are taking this example way too seriously.  Thunder wanted an 
example and I grabbed the first one that I saw (I created it in the 
last hour).  I showed you how I arrived at it, just a quick grepping. 
  It wan't a real patch, only a quick little example snippet.

> 	- even if you remove the BKL from this code, what have you
> 	  achieved?  A faster kernel?  A very tiny bit smaller kernel,
> 	  yes, but not any faster overall.  This is not on _any_
> 	  critical path.

How many times do I have to say it?  We're going around in circles 
here.  I _know_ that it isn't on a critical path, or saving a large 
quantity of program text.  I just think that it is better than it was 
before.

-- 
Dave Hansen
haveblue@us.ibm.com

