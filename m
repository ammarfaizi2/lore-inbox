Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132801AbRDIRPO>; Mon, 9 Apr 2001 13:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132802AbRDIROz>; Mon, 9 Apr 2001 13:14:55 -0400
Received: from staffnet.com ([207.226.80.14]:20752 "EHLO staffnet.com")
	by vger.kernel.org with ESMTP id <S132801AbRDIROq>;
	Mon, 9 Apr 2001 13:14:46 -0400
Message-ID: <3AD1EDFF.69BAB528@staffnet.com>
Date: Mon, 09 Apr 2001 13:14:39 -0400
From: Wade Hampton <whampton@staffnet.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.3, VMWare, 2 VMs
In-Reply-To: <47CA75C62D7@vcnet.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:
> 
> On  9 Apr 01 at 12:03, Wade Hampton wrote:
> 
> > Is anyone having problems with running more than
> As I already answered on VMware newsgroups:
Thanks.  I didn't see the post on the VMware newsgroup....

> VMware's 2.0.3 vmmon module uses save_flags() + cli()
> in poll() fops, and after this cli() it calls
> spin_lock() :-( It is not safest thing to do.
> But it should not cause reboot. You should get
> 
> /dev/vmmon: 11 wait for global VM lock XX
I had over 2000 of those in /var/log/messages
(not counting the "repeated" lines in /var/log/messages).
Yep, that's the problem....
> 
> and now dead machine with disabled interrupts...
Yes, basically a dead machine with NO response to 
anything....
> 
> As all other callers of HostIF_GlobalVMLock() hold
> big kernel lock, easiest thing to do is to add
> lock_kernel()/unlock_kernel() around LinuxDriver_Poll()
> body.
> 
> Removing whole save_flags/cli is for sure much better,
> but it is still in my queue (if you are looking into vmmon
> driver, then whole poll mess is there to get wakeup on
> next jiffy, and not on next + one...).
No, I can wait for the a release that fixes this.  If
you have a patch or test version, send it to me and I'll
test it on my development machine....

For now, I'll just not use 2 VMs until it is fixed.

Cheers,
-- 
W. Wade, Hampton  <whampton@staffnet.com>
