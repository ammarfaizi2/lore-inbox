Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbTL1Xsa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 18:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbTL1Xsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 18:48:30 -0500
Received: from darkwing.uoregon.edu ([128.223.142.13]:22214 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id S262188AbTL1Xs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 18:48:27 -0500
Date: Sun, 28 Dec 2003 15:36:15 -0800 (PST)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: Johannes Ruscheinski <ruschein@mail-infomine.ucr.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Best Low-cost IDE RAID Solution For 2.6.x? (OT?)
In-Reply-To: <20031228213535.GA21459@mail-infomine.ucr.edu>
Message-ID: <Pine.LNX.4.44.0312281516060.21070-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Dec 2003, Johannes Ruscheinski wrote:

> Also sprach Joel Jaeggli:
> > well if you currently have 1tb in 8 non-redundant drives then you using 
> > 160GB disks... no?
> > 
> > the biggest p-ata disks right now are ~320GB so you can do a ~1TB software 
> > raid 5 stripe on a single 4 port ata controller such as a promise tx4000 
> > using regular software raid rather than the promise raid. that would end 
> > up being fairly inexpensive and buy you more protection.
> 
> Fisrt of all: thanks for the advice Joel!  Two questions: why not use the
> hardware raid capability of the Promise tx4000 and if we'd use software

on the low-end promise controllers (ie everything but the sx4000 and
sx6000) it's not hardware raid, it's the driver doing raid in this case
the promise fastrack driver. among other things their driver doesn't do
raid 5, just 0 1 or 0+1. so software raid does raid 5 and more.

to quote the config_blk_dev_ataraid:

 CONFIG_BLK_DEV_ATARAID:                                                 
âSay Y or M if you have an IDE Raid controller and want linux            
âto use its softwareraid feature.  You must also select an               
 appropriate for your board low-level driver below.                      

âNote, that Linux does not use the Raid implementation in BIOS, and      
âthe main purpose for this feature is to retain compatibility and        
âdata integrity with other OS-es, using the same disk array. Linux       
âhas its own Raid drivers, which you should use if you need better       
âperformance.          

I've also had two if the higher-end promise sx6000's and the suffering I 
incurred making them work with the i2o drivers particularly when promise 
revised the bioses on those cards means I can't recomend them for much.
 
> raid instead, what would be the CPU overhead?

The linux software raid layer is actually faster under most circumstances
the hardware raid controllers, doing raid5. but since the promise can't
actually do that (raid 5) anyway it's hard to compare them directly. the
3ware cards in my experience result in lower cpu utilization for i/o but
there hardware tops out at 80-145MB/s depending on model and we have
software raid subsystems that go faster than that at the expense of some 
of the rather bountiful cpu we have in those boxes.

> > 
> > linux software raid hsa been as releiable as anything else we've used over 
> > the years, the lack of reliabilitiy in your situation will come entirely 
> 
> Good to hear.
> 
> > from failing disks, lose one and your filesystem is toast.
> 
> I was aware of that, thanks!
> 
> > 
> > joelja
> > 
> > On Sun, 28 Dec 2003, Johannes Ruscheinski wrote:
> > 
> > > Hi,
> > > 
> > > We're looking for a low-cost high-reliability IDE RAID solution that works well
> > > with the 2.6.x series of kernels.  We have about 1 TB (8 disks) that we'd
> > > like to access in a non-redundant raid mode.  Yes, I know, that lack of
> > > redundancy and high reliability are contradictory.  Let's just say that
> > > currently we lack the funding to do anything else but we may be able to obtain
> > > more funding for our disk storage needs in the near future.
> > > 
> > 
> > -- 
> > -------------------------------------------------------------------------- 
> > Joel Jaeggli  	       Unix Consulting 	       joelja@darkwing.uoregon.edu    
> > GPG Key Fingerprint:     5C6E 0104 BAF0 40B0 5BD3 C38B F000 35AB B67F 56B2
> > 
> 
> 

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli  	       Unix Consulting 	       joelja@darkwing.uoregon.edu    
GPG Key Fingerprint:     5C6E 0104 BAF0 40B0 5BD3 C38B F000 35AB B67F 56B2


