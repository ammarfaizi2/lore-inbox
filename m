Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129078AbRCEIvm>; Mon, 5 Mar 2001 03:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129111AbRCEIvc>; Mon, 5 Mar 2001 03:51:32 -0500
Received: from smtpde03.sap-ag.de ([194.39.131.54]:18344 "EHLO
	smtpde03.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129078AbRCEIvP>; Mon, 5 Mar 2001 03:51:15 -0500
From: Christoph Rohland <cr@sap.com>
To: Matt_Domsch@Dell.com
Cc: linux-kernel@vger.kernel.org, R.E.Wolff@BitWizard.nl, fluffy@snurgle.org
Subject: Re: 2.4 and 2GB swap partition limit
In-Reply-To: <CDF99E351003D311A8B0009027457F1403BF9E09@ausxmrr501.us.dell.com>
Organisation: SAP LinuxLab
Date: 05 Mar 2001 09:58:00 +0100
In-Reply-To: <CDF99E351003D311A8B0009027457F1403BF9E09@ausxmrr501.us.dell.com>
Message-ID: <m3n1b0h9t3.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

On Sun, 4 Mar 2001, Matt Domsch wrote:
> My concern is that if there continues to be a 2GB swap
> partition/file size limitation, and you can have (as currently
> #defined) 8 swap partitions, you're limited to 16GB swap, which then
> follows a max of 8GB RAM.  We'd like to sell servers with 32GB or
> 64GB RAM to customers who request such for their applications.  Such
> customers generally have no problem purchasing additional disks to
> be used for swap, likely on a hardware RAID controller.

I did think about that too and I also think the 2GB limit is not
appropriate for the big servers. But I do not beleive that you need so
much swap on these machines. If you drive a 32 GB machine so heavily
into swap it is more busy finding the pages to swap than doing
anything really interesting. (At least that's my experience)

BTW often these big servers run databases and application servers
which have most of their memory in shared memory. Shared memory does
free the swap entries on swapin. (I thought about changing that but as
long as we have no garbage collection for idle swap entries I will not
do it)

On any loaded server you have to check the swap space requirements
regularly and adjust to your needs. But to setup more than let's
say 8GB swap is a waste of resource IMHO.

> We've also seen (anecdotal evidence here) cases where a kernel
> panics, which we believe may have to do with having 0 < swap < 2x
> RAM.  We're investigating further.

That would be a kernel bug which should be fixed. The kernel should
handle oom/oos.

>> Actually the deal is: either use enough swap (about 2x RAM) or use
>> none at all. 
> 
> If swap space isn't required in all cases, great!  We'll encourage
> the use of swap files as needed, rather than swap partitions.  But,
> if instead you *require* swap = 2x RAM, then the 2GB swap size
> limitation must go.

No it is not strictly required.

But still the 2GB limit is annoying and together with the
arch-independent maximum number of swap partitions/files it is pretty
dumb. 

So I would propose to first make a small patch to make MAX_SWAPFILES
arch-dependent and bigger. (x86 would allow a muc higher
MAX_SWAPFILES)

For 2.5 we could perhaps think about a new swapfile layout which
allows bigger partitions.

Greetings
		Christoph


