Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291692AbSBALGn>; Fri, 1 Feb 2002 06:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291694AbSBALGc>; Fri, 1 Feb 2002 06:06:32 -0500
Received: from pc-62-31-74-110-ed.blueyonder.co.uk ([62.31.74.110]:44160 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S291692AbSBALGI>; Fri, 1 Feb 2002 06:06:08 -0500
Date: Fri, 1 Feb 2002 11:05:52 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Joe Thornber <thornber@fib011235813.fsnet.co.uk>, lvm-devel@sistina.com,
        Jim McDonald <Jim@mcdee.net>, Andreas Dilger <adilger@turbolabs.com>,
        linux-lvm@sistina.com, linux-kernel@vger.kernel.org,
        evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] Re: [ANNOUNCE] LVM reimplementation ready for beta testing
Message-ID: <20020201110552.B2149@redhat.com>
In-Reply-To: <OFBCE93B66.F7B9C14E-ON85256B52.006B8AB3@raleigh.ibm.com> <20020131125211.A8934@fib011235813.fsnet.co.uk> <20020201045518.A10893@devserv.devel.redhat.com> <20020131130913.A8997@fib011235813.fsnet.co.uk> <20020201051251.B10893@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020201051251.B10893@devserv.devel.redhat.com>; from arjanv@redhat.com on Fri, Feb 01, 2002 at 05:12:51AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Feb 01, 2002 at 05:12:51AM -0500, Arjan van de Ven wrote:
> On Thu, Jan 31, 2002 at 01:09:13PM +0000, Joe Thornber wrote:
> > 
> > Now our hero decides to PV move PV2 to PV4:
> > 
> > 1. Suspend our LV (254:3), this starts queueing all io, and flushes
> >    all pending io. 
> 
> But "flushes all pending io" is *far* from trivial. there's no current
> kernel functionality for this, so you'll have to do "weird shit" that will
> break easy and often.

I've been all through this with Joe.  He *does* track pending IO in
device_mapper, and he's got a layered device_mirror driver which can
be overlayed on top of the segments of the device that you want to
copy.  His design looks solid and the necessary infrastructure for
getting the locking right is all there.

> Also "suspending" is rather dangerous because it can deadlock the machine
> (think about the VM needing to write back dirty data on this LV in order to
>  make memory available for your move)...

There's a copy thread which preallocates a fully-populated kiobuf for
the data.  There's no VM pressure, and since it uses unbuffered IO,
there are no cache coherency problems like current LVM has.

Arjan, I *told* you they have thought this stuff through.  :-)

Cheers,
 Stephen
