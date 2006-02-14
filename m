Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422842AbWBNWEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422842AbWBNWEK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 17:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422854AbWBNWEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 17:04:10 -0500
Received: from hera.kernel.org ([140.211.167.34]:40148 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1422842AbWBNWEH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 17:04:07 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: bonding mode 1 works as designed. Or not?
Date: Tue, 14 Feb 2006 14:04:01 -0800
Organization: OSDL
Message-ID: <20060214140401.0f0a7e83@localhost.localdomain>
References: <43F24DBA.7090602@am-anger-1.de>
	<20060214214746.GK11380@w.ods.org>
	<43F25138.9090503@am-anger-1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1139954641 15450 10.8.0.54 (14 Feb 2006 22:04:01 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Tue, 14 Feb 2006 22:04:01 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.0.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2006 22:52:56 +0100
Heiko Gerstung <heiko@am-anger-1.de> wrote:

> Hi Willy,
> 
> Willy Tarreau wrote:
> >> [...]eth0 and eth1 are in a bonding group, mode=1, miimon=100 ... eth0 is the
> >> active slave and used as long as the physical link is available (checked
> >> by using MII monitoring), at the same time eth1 is totally passive,
> >> neither passing any received packets to the kernel nor sending packets,
> >> if the kernel wants it to do so. As soon as the eth0 link status changes
> >> to "down", eth1 is activated and used, and now eth0 remains silent and
> >> deaf until it becomes the active slave again.
> >>
> >> Any comments on that? Is the documentation wrong OR is there a bug in
> >> the implementation of the bonding module?
> >>     
> >
> > Neither, it's your understanding described above :-)
> > In fact, the bonding is used to select an OUTPUT device. If some trafic
> > manages to enter through the backup interface, it will reach the kernel.
> > It can be useful to implement some link health-checks for instance. However,
> > the only packets that you should receive are multicast and broadcast packets,
> > so this should be very limited anyway by design. After several years using
> > it, it has not caused me any trouble, including in environments involving
> > multicast for VRRP.
> >
> >   
> Unfortunately the ping replies come in on both interfaces, as well as 
> any other traffic (like ssh or web traffic). Everything works but the 
> load of the system caused by network traffic is nearly doubled this way 
> and may cause confusion in a number of applications. 
> 
> Would there be a way to stop the non-active slave(s) from "listening", 
> i.e. drop all traffic received by them? If yes, where could I do that?
> > Regards,
> > willy
> >
> >   

You will probably get a better answer if you ask the developers
directly.

BONDING DRIVER
P:   Chad Tindel
M:   ctindel@users.sourceforge.net
P:   Jay Vosburgh
M:   fubar@us.ibm.com
L:   bonding-devel@lists.sourceforge.net
W:   http://sourceforge.net/projects/bonding


