Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267255AbRGKJLr>; Wed, 11 Jul 2001 05:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267254AbRGKJLh>; Wed, 11 Jul 2001 05:11:37 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:4624 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S267250AbRGKJLU>; Wed, 11 Jul 2001 05:11:20 -0400
Message-ID: <3B4C180E.D3AE1960@idb.hist.no>
Date: Wed, 11 Jul 2001 11:10:38 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7-pre5 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: "C. Slater" <cslater@wcnet.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Switching Kernels without Rebooting?
In-Reply-To: <NOEJJDACGOHCKNCOGFOMOEKECGAA.davids@webmaster.com> <001501c10980$f42035a0$fe00000a@cslater>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"C. Slater" wrote:

> I don't think that it would be possible to switch kernels when one was not
> properly set up to do it, if thats what you mean. You could only switch
> between kernels that have been compiled to support live switching.
> 
Sure.  
> I do see you'r point with the datastructures changeing. We would need to use
> some format that all properly setup kernels could understand, 

That seems completely out of question.  The structures a 2.4.7 
kernel understands might be insufficient to express the setup 
a future 2.6.9 kernel is using to do its stuff better.  (And vice
versa, if future kernels drop a 2.4.7 feature deemed obsolete.
But what if that feature is in use when you decide to upgrade?) 
You can easily deal with simple stuff like struct
rearrangement and type conversions, but what to do when whole data
structures
change completely?  

Example: something changes from two linked lists representation to a
single tree or 4 hashtables.  You'll have a very hard time inventing
a generic data format to deal with that kind of changes.  It might
happen.  Look at differences in 2.2 and 2.4 VM with the big pagecache
change in early 2.3.  And the dentry cache that suddenly appeared.

And of course the rules change too, from time to time.  
Many releases have a list of "active pages".  what kind exactly is that?
The rules may change, what to do if the new kernel don't allow
one particular kind of page on that list, but the old running kernel
have a bunch?

This was jsut some made-up examples, I guess you'll run into a ton
of such issues.  New releases aren't simply fixes and tweaks, there
are frequent design changes.

> Are you saying that swaping the kernels out altogether would be a massive
> task, or that saveing/restoring the datastructures would be a massive task.

All you need to swap kernel images is memory.  Swapping structures
can't be done in a generic way, you'll need code that convert the
structures of one particular kernel release to those of a
particular other kernel.  And I don't think you'll have the usual
kernel developers do that.

A "long-term uptime" distro might do this kind of work for a few
selected kernels, but I cannot imagine it happen for the regular
ones.

Helge Hafting
