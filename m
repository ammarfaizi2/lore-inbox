Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282507AbRKZUeM>; Mon, 26 Nov 2001 15:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282490AbRKZUdM>; Mon, 26 Nov 2001 15:33:12 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:48901
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S282482AbRKZUdB>; Mon, 26 Nov 2001 15:33:01 -0500
Date: Mon, 26 Nov 2001 12:30:42 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Rob Landley <landley@trommello.org>
cc: Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org
Subject: Re: Journaling pointless with today's hard disks?
In-Reply-To: <0111261159080F.02001@localhost.localdomain>
Message-ID: <Pine.LNX.4.10.10111261229190.8817-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2001, Rob Landley wrote:

> On Sunday 25 November 2001 04:14, Chris Wedgwood wrote:
> 
> >
> > P.S. Write-caching in hard-drives is insanely dangerous for
> >      journalling filesystems and can result in all sorts of nasties.
> >      I recommend people turn this off in their init scripts (perhaps I
> >      will send a patch for the kernel to do this on boot, I just
> >      wonder if it will eat some drives).
> 
> Anybody remember back when hard drives didn't reliably park themselves when 
> they cut power?  This isn't something drive makers seem to pay much attention 
> to until customers scream at them for a while...
> 
> Having no write caching on the IDE side isn't a solution either.  The problem 
> is the largest block of data you can send to an ATA drive in a single command 
> is smaller than modern track sizes (let alone all the tracks under the heads 
> on a multi-head drive), so without any sort of cacheing in the drive at all 
> you add rotational latency between each write request for the point you left 
> off writing to come back under the head again.  This will positively KILL 
> write performance.  (I suspect the situation's more or less the same for read 
> too, but nobody's objecting to read cacheing.)
> 
> The solution isn't to avoid write cacheing altogether (performance is 100% 
> guaranteed to suck otherwise, for reasons unrelated to how well your hardware 
> works but to legacy request size limits in the ATA specification), but to 
> have a SMALL write buffer, the size of one or two tracks to allow linear ATA 
> write requests to be assembled into single whole-track writes, and to make 
> sure the disks' electronics has enough capacitance in it to flush this buffer 
> to disk.  (How much do capacitors cost?  We're talking what, an extra 20 
> miliseconds?  The buffer should be small enough you don't have to do that 
> much seeking.)
> 
> Just add an off-the-shelf capacitor to your circuit.  The firmware already 
> has to detect power failure in order to park the head sanely, so make it 
> flush the buffers along the way.  This isn't brain surgery, it just wasn't a 
> design criteria on IBM's checklist of features approved in the meeting.  
> (Maybe they ran out of donuts and adjourned the meeting early?)
> 

Rob,

Send me an outline/discription and I will present it during the Dec T13
meeting for a proposal number for inclusion into ATA-7.

Regards,

Andre Hedrick
CEO/President, LAD Storage Consulting Group
Linux ATA Development
Linux Disk Certification Project

