Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264326AbUD0UGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264326AbUD0UGa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 16:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264327AbUD0UGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 16:06:30 -0400
Received: from stingr.net ([212.193.32.15]:59594 "EHLO stingr.net")
	by vger.kernel.org with ESMTP id S264326AbUD0UFB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 16:05:01 -0400
Date: Wed, 28 Apr 2004 00:04:59 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc2-bk3 (and earlier?) mount problem (?
Message-ID: <20040427200459.GJ14129@stingr.net>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040426225620.GP17014@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0404270157160.6900@alpha.polcom.net> <20040427002323.GW17014@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0404261758230.19703@ppc970.osdl.org> <20040427010748.GY17014@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0404271106500.22815@alpha.polcom.net> <1083070293.30344.116.camel@watt.suse.com> <Pine.LNX.4.58.0404271500210.27538@alpha.polcom.net> <20040427140533.GI14129@stingr.net> <20040427183410.GZ17014@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20040427183410.GZ17014@parcelfarce.linux.theplanet.co.uk>
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to viro@parcelfarce.linux.theplanet.co.uk:
> On Tue, Apr 27, 2004 at 06:05:34PM +0400, Paul P Komkoff Jr wrote:
> > Replying to Grzegorz Kulewski:
> > > But it is strange that I need kernel patch even if I have no evms 
> > > or dm volumes in my system. Can not it be solved in mainstream kernels?
> > > Maybe there should be warning in config help temporaily? Maybe even note 
> > > after option name?
> > 
> > This defect grew up off a disagreement between bdclaim authors and
> > evms authors
> 
> Excuse me?  The damn thing had found nothing.  However, it didn't care
> to release the devices it had claimed - hadn't even closed them, as the
> matter of fact.  That's a clear and obvious bug, regardless of any
> disagreements.

As far as I can see from here, evms parsed partition table, called
dmsetup several times and created corresponding nodes in /dev/evms.

Thus we allowed to mount /dev/evms/hda1 but /dev/hda1 stopped working.
That's why it did not released hda - because it has active devmapper
on top.

> Speaking of the proposed "solutions", how about #4: figure out what,
> when and for how long do they really want to claim and take care to
> release what they don't end up using?

Logic is easy - evms trying to concentrate block device management
into its own hands, but we have in-kernel partitioning code to
consider ...

> WTF is going on there?

:(

-- 
Paul P 'Stingray' Komkoff Jr // http://stingr.net/key <- my pgp key
 This message represents the official view of the voices in my head
