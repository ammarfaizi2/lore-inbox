Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273912AbRJTSWx>; Sat, 20 Oct 2001 14:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273904AbRJTSWn>; Sat, 20 Oct 2001 14:22:43 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:61120 "EHLO
	mailout05.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S273888AbRJTSWl>; Sat, 20 Oct 2001 14:22:41 -0400
Date: 20 Oct 2001 15:52:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8BEQdKdHw-B@khms.westfalen.de>
In-Reply-To: <20011019122101.G2467@mikef-linux.matchmail.com>
Subject: Re: [RFC] New Driver Model for 2.5
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <15uerh-0NbBEeC@fmrl04.sul.t-online.com> <Pine.LNX.4.33.0110191108590.17647-100000@osdlab.pdx.osdl.net> <15uerh-0NbBEeC@fmrl04.sul.t-online.com> <20011019122101.G2467@mikef-linux.matchmail.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mfedyk@matchmail.com (Mike Fedyk)  wrote on 19.10.01 in <20011019122101.G2467@mikef-linux.matchmail.com>:

> On Fri, Oct 19, 2001 at 09:02:09PM +0200, Tim Jansen wrote:
> > On Friday 19 October 2001 20:26, Patrick Mochel wrote:
> > > There are equivalents in USB. But, neither of them are globally unique
> > > identifiers for the device. That doesn't necessarily mean that one
> > > couldn't be ascertained from the device; ethernet cards do have MAC
> > > addresses. But, I don't think that many will have a ID/serial number.
> > > [...]
> > > Which leads me to the question: what real benefit does this have? Why
> > > would you ever want to do a global search in kernel space for a
> > > particular device?
> >
> > For example for harddisks. You usually want them to be mounted in the same
> > directory.
>
> When is /etc/fstab going to support this?

Know your tools.

/etc/fstab:
UUID=eba05cbf-55ff-44d7-846a-7846c6010843 /usr ext2 defaults,nocheck 0 2

I have this mounted right now, on 2.2.19:

/dev/sdb7              3936400   3597588    138852  97% /usr

That's an ext2 partition ID, so even if repartitioning renumbers the  
partition, mount will still find it - only mkfs forces me to use a new ID.  
Changing the controller and SCSI id obviously makes no difference  
whatsoever. I could use labels, too, but they tend to be less unique.

/proc/partitions is necessary to know what partitions to look at, of  
course.

> >Or for ethernet adapters:
> > because each is connected to a different network, so you need to assign
> > different IP addresses to them.
> >
>
> I haven't seen anything assign ethX assign a certain order, except for
> ordered module loading, and then if there are multiple devices with the same
> driver, the order is chosen by bus scanning order, or module option.

Exactly. So you can't use the order if there's any possibility of this, so  
you need to use the MAC address.

MfG Kai
