Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264561AbRFMHFT>; Wed, 13 Jun 2001 03:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264562AbRFMHFK>; Wed, 13 Jun 2001 03:05:10 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:38329 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S264561AbRFMHFA>; Wed, 13 Jun 2001 03:05:00 -0400
From: Christoph Rohland <cr@sap.com>
To: Pavel Roskin <proski@gnu.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: DoS using tmpfs
In-Reply-To: <Pine.LNX.4.33.0106081755220.1324-100000@vesta.nine.com>
Organisation: SAP LinuxLab
Date: 13 Jun 2001 09:04:51 +0200
In-Reply-To: Pavel Roskin's message of "Fri, 8 Jun 2001 18:42:40 -0400 (EDT)"
Message-ID: <m3vgm06ess.fsf@linux.local>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Fri, 8 Jun 2001, Pavel Roskin wrote:
> Hello!
> 
> It appears that a system with tmpfs mounted with the default (!!!)
> parameters can be used by ordinary users to make the system
> non-functional.

...

> 1) tmpfs, as opposed to ramfs doesn't limit the usage by
>    default. It's not a good default for a filesystem designed for
>    temporary files.

Yes, use the size parameter. And no, ramfs has no resource limits in
the stock kernel at all. In -ac it limits to half the size of the
physical RAM unconditionally. But that's not useful for tmpfs simce
this uses swap also. So it is the admins task to add a size
parameter. I would love to add a size paramater in percent of virtual
memory but this would need some changes in the swapon/off coding.

> 2) Not delivering SIGINT to processes is probably not the best
>    behavior if the memory if low. However, one could argue that some
>    processes would use even more resources if they get control with
>    SIGINT.
> 
> 3) All swap in the system was exhausted and yet tmpfs didn't return
>    ENOSPC to "dd".

That the kernel locks up is IMHO a mm fault. tmpfs allocates its pages
with GFP_USER and will return an error if this fails. Apparently it
never fails but locks up.

Greetings
		Christoph


