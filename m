Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262702AbUCJQxV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 11:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262698AbUCJQxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 11:53:20 -0500
Received: from knight-linux.rlknight.com ([64.165.88.6]:35332 "EHLO
	knight-linux.rlknight.com") by vger.kernel.org with ESMTP
	id S262706AbUCJQxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 11:53:17 -0500
Message-ID: <404F4805.4060108@rlknight.com>
Date: Wed, 10 Mar 2004 08:53:25 -0800
From: Rick Knight <rick@rlknight.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Dummy network device
References: <20040309162552.0d7f1ca0.rddunlap@osdl.org> <20040309212221.766479dc.rddunlap@osdl.org>
In-Reply-To: <20040309212221.766479dc.rddunlap@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:

>| From: Rick Knight
>| 
>| David S. Miller wrote:
>| 
>| >On Tue, 09 Mar 2004 15:11:48 -0800
>| >Rick Knight <rick@rlknight.com> wrote:
>| >
>| >  
>| >
>| >>I found the answer. From the archive. Decided to look at dummy.c and 
>| >>numdummies=1, changed it to numdummies=3 and rebuilt that module. Works 
>| >>like a charm.
>| >>
>| >>Question/Suggestion, couldn't this be made an option at configuration? 
>| >>Kind of like number_of_ptys=256.
>| >>    
>| >>
>| >
>| >Specify "numdummies=3" on the module load command line.
>| >  
>| >
>| >It's supposed to be changeable at module load time, without
>| >rebuilding it.  Try this e.g.:
>| >
>| >modprobe dummy numdummies=4
>| >
>| >--
>| >~Randy
>| >  
>| >
>| Randy, David,
>| 
>| Thanks for the replies.
>| 
>| I did try 'modprobe dummy numdummies=3', however, I didn't quote 
>| numdummies=3. Are the quote required? Is there a modprobe.conf option? 
>| Probably "options dummy "numdummies=3".
>
>No, the quotes are not required.  This works for me:
>modprobe dummy numdummies=3
>
>Using /etc/modprobe.conf also works, as you suggested, but without
>the quotation marks:
>options dummy numdummies=3
>
>Either way shows this in /proc/net/dev:
>
>dummy0:       0       0    0    0    0     0          0         0        0
> 0    0    0    0     0       0          0
>dummy1:       0       0    0    0    0     0          0         0        0
> 0    0    0    0     0       0          0
>dummy2:       0       0    0    0    0     0          0         0        0
> 0    0    0    0     0       0          0
>
>
>HTH.
>--
>~Randy
>  
>
Randy,

I did try 'modprobe dummy numdummies=3' and I didn't work. I got an 
error and the following showed up in /var/log/messages...

Mar  9 14:42:33 l43w2k021 modprobe: FATAL: Error inserting dummy 
(/lib/modules/2.6.3/kernel/drivers/net/dummy.ko): Unknown symbol in 
module, or unknown parameter (see dmesg)

Now it works and I get no error message. I tried numdummies= on another 
similarly configured machine and it worked first time. So maybe the 
error message above was caused by a typo when I tried it the first time

Anyway, numdummies= does work as you said.

Thanks,
Rick Knight
(rick@rlknight.com)

