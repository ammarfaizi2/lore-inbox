Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261433AbVBGOaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbVBGOaJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 09:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbVBGO3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 09:29:00 -0500
Received: from zeus.bragatel.pt ([217.70.64.253]:61358 "HELO mail.bragatel.pt")
	by vger.kernel.org with SMTP id S261426AbVBGO15 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 09:27:57 -0500
Date: Mon, 7 Feb 2005 14:27:49 +0000
From: Nuno Monteiro <nuno@itsari.org>
To: =?iso-8859-1?Q?Pozs=E1r_Bal=E1zs?= <pozsy@uhulinux.hu>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: msdos/vfat defaults are annoying
Message-ID: <20050207142749.GA29741@hobbes.itsari.int>
References: <4205AC37.3030301@comcast.net> <20050206070659.GA28596@infradead.org> <20050206232108.GA31813@ojjektum.uhulinux.hu> <20050207003610.GP8859@parcelfarce.linux.theplanet.co.uk> <20050207004218.GA12541@ojjektum.uhulinux.hu> <20050207024800.GA18010@hobbes.itsari.int> <20050207084709.GA30680@ojjektum.uhulinux.hu>
Mime-Version: 1.0
Content-Type: text/plain; Format=Flowed; DelSp=Yes; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050207084709.GA30680@ojjektum.uhulinux.hu> (from pozsy@uhulinux.hu on Mon, Feb 07, 2005 at 08:47:09 +0000)
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2005.02.07 08:47, Pozsár Balázs wrote:
> On Mon, Feb 07, 2005 at 02:48:00AM +0000, Nuno Monteiro wrote:
> >
> 
> But the contents of /proc/filesystems comes from the kernel. And the
> order of filesystems comes from the link order.
>

Yes, but /proc/filesystems is only processed after two other checks have  
failed first: specifying a filesystem type (-t), and reading /etc/ 
filesystems. Relying on mount to do the guesswork is asking for trouble  
if you realy value your data. And /etc/filesystems is the mechanism mount 
(8) has in place to change the probe order, in case you really want that.  
This is entirely a userspace problem, the kernel shouldn't have anything  
to do with it.

But, anyway, for the sake of argument let's suppose link order is  
effectively changed. You just effectively broke people's working setups,  
because like you want to rely on fs/ link order to mount your vfats as  
vfat and not as msdos, there's people out there relying on that (broken)  
assumption to have their msdos filesystems mounted as msdos. Now, with  
the new link order, they'll be mounted as vfat, and pop-goes-the-weasel.  
Tomorrow, someone unhappy that their msdos fs is now mounted as vfat will  
send a patch changing it back, thus breaking vfats. Rinse, repeat. ;-)

See? This is just wrong. This is why mount(8) has a mechanism to change  
the probe order. Everybody's happy that way, and no one has to rely on  
the broken assumption that the kernel knows how you want your filesystems  
mounted.

So, to sum things up: this is entirely an userspace problem. Yours just  
appears to be in need of fixing or tuning.



Regards,

		Nuno
