Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313670AbSDHPSS>; Mon, 8 Apr 2002 11:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313671AbSDHPSR>; Mon, 8 Apr 2002 11:18:17 -0400
Received: from gw.wmich.edu ([141.218.1.100]:38596 "EHLO gw.wmich.edu")
	by vger.kernel.org with ESMTP id <S313670AbSDHPSQ>;
	Mon, 8 Apr 2002 11:18:16 -0400
Subject: Re: Make swsusp actually work
From: Ed Sweetman <ed.sweetman@wmich.edu>
To: Pavel Machek <pavel@suse.cz>
Cc: alan@redhat.com, kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020408150005.GC29960@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 08 Apr 2002 11:18:07 -0400
Message-Id: <1018279092.10463.155.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-04-08 at 11:00, Pavel Machek wrote:
> Hi!
> 
> > the documentation suggests that you do not need to specify resume= .  Is
> > this only true if you have the sysvinit patch in use?  Is swapon -a
> 
> Then docs is wrong.
> 								Pavel
Then you need to change this from your previous "all in one" patch.

from the swsusp.txt in "Using the code" 3rd paragraph
<
Either way it saves the state of the machine into active swaps and then
reboots. By the next booting the kernel's resuming function is either
triggered by swapon -a (which is ought to be in the very early stage of
booting) or you may explicitly specify the swap partition/file to resume
from with ``resume='' kernel option. 
>
This seems to suggest that you have a choice. Which last time i checked,
you dont.  


from the swsusp.txt in "How the code works" 2nd paragraph
Same thing as before basically.  swapon -a does not trigger a resume

under warnings! 
Ext3 fs seems to show no more of a risk than a non-journalling fs.
perhaps that problem is reiserfs only?


Also, mention of the swap files being described in fstab is made in
"Using the code" but no mention is made to how they must be loaded and
must be actual raw partitions.  Files of course would not work as viable
swaps for resume because the fs would have to be mounted to load them.

and one more thing.  What happens when you have multiple swap files all
of equal priority (normal swap conditions have a striping effect (like
raid))  Will swsusp choose one ?   How do we know which one it chose? Is
it just the first one in /proc/swaps all the time?  That kind of
behavior would be nice to document in swsusp.txt.  

Thanks for the patches.  it seems to work on my non X box (p4)  just
fine.  I'll have to risk disaster and try it out on a dri X session soon
since that's where the convenience would come into play. 

