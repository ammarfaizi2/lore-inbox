Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129777AbRAEXYl>; Fri, 5 Jan 2001 18:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131035AbRAEXYb>; Fri, 5 Jan 2001 18:24:31 -0500
Received: from monza.monza.org ([209.102.105.34]:53776 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S129777AbRAEXYN>;
	Fri, 5 Jan 2001 18:24:13 -0500
Date: Fri, 5 Jan 2001 15:23:45 -0800
From: Tim Wright <timw@splhi.com>
To: Igmar Palsenberg <maillist@chello.nl>
Cc: Torrey Hoffman <torrey.hoffman@myrio.com>, Sven Koch <haegar@cut.de>,
        Kernel devel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.18 and Maxtor 96147H6 (61 GB)
Message-ID: <20010105152345.A2100@scutter.sequent.com>
Reply-To: timw@splhi.com
Mail-Followup-To: Igmar Palsenberg <maillist@chello.nl>,
	Torrey Hoffman <torrey.hoffman@myrio.com>,
	Sven Koch <haegar@cut.de>,
	Kernel devel list <linux-kernel@vger.kernel.org>
In-Reply-To: <4461B4112BDB2A4FB5635DE1995874320223BC@mail0.myrio.com> <Pine.LNX.4.21.0101050019530.4273-100000@server.serve.me.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0101050019530.4273-100000@server.serve.me.nl>; from maillist@chello.nl on Fri, Jan 05, 2001 at 12:25:09AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2001 at 12:25:09AM +0100, Igmar Palsenberg wrote:
> On Thu, 4 Jan 2001, Torrey Hoffman wrote:
> 
> > I had exactly this problem with the Maxtor 61 GB drive on my 
> > Pentium based server.  Theoretically a BIOS upgrade could fix it,
> > but ASUS quit making BIOS upgrades for my motherboard two years
> > ago.
> 
> Ah well, join the club in my case :)
> 

I had a similar situation except I was more interested in the performance
difference. Went from ~4MB/s with the 430HX controller to ~12.5MB/s with
the promise. This on an old Pentium system.

> > I solved the problem by getting a Promise Ultra 100 controller
> > and putting the drive on that. Works perfectly under Linux 
> > Mandrake 2.2.17-mdk-21 - it shows up as /dev/hde.  They are
> > cheap controllers if you don't get the RAID version.
> 
> Thanx.. Will try that. New machine costs more.
>  

Vanilla 2.2 kernels don't have this support (at least not as on 2.2.18).
If you're not running Mandrake, grab Andre Hedrick's excellent ide patch.

One thing you may like to know. If you want the drives attached to the new
controller to be /dev/hda..., then edit lilo.conf and add
	append="pci=reverse"
to your patched kernel entry. Oh, and if you ever need to bootstrap one of
these puppies with a kernel that doesn't have the drivers, you can use
	append="ide0=0xe000,0xd802 ide1=0xd400,0xd002"
to be able to access the drive attached to the Promise controller using the
standard ide driver.

Hope this helps.

Tim

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
