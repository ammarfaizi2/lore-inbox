Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262481AbSKEWHG>; Tue, 5 Nov 2002 17:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262776AbSKEWHF>; Tue, 5 Nov 2002 17:07:05 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:53414 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262481AbSKEWHE> convert rfc822-to-8bit; Tue, 5 Nov 2002 17:07:04 -0500
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: Andrew Morton <akpm@digeo.com>
Subject: Re: Kswapd madness in 2.4 kernels
Date: Tue, 5 Nov 2002 14:13:00 -0800
User-Agent: KMail/1.4.1
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       Rik van Riel <riel@conectiva.com.br>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
References: <200210242026.13071.jamesclv@us.ibm.com> <3DB8C941.DEF1C069@digeo.com>
In-Reply-To: <3DB8C941.DEF1C069@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211051413.00661.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Status report:

Due to dependencies, I didn't try the two recommended patches alone.  I ran 
Andrea's 2.4.20-pre10aa1 kernel on the test load for one week.  Low memory 
was conserved and kswapd never went out of control.  Presumably, 
05_vm_16_active_free_zone_bhs-1 did the job for buffers, and the inode patch 
continued to work.

Are there any plans on getting these into 2.4.21?


On Thursday 24 October 2002 09:32 pm, Andrew Morton wrote:
> James Cleverdon wrote:
> >    Andrea_Archangeli-inode_highmem_imbalance.patch    Type: text/x-diff
>
> That's in -aa kernels, is correct and is needed.
>
> >    Andrew_Morton-2.4_VM_sucks._Again.patch    Type: text/x-diff
>
> hmm.  Someone seems to have renamed my nuke-buffers patch ;)
>
> My main concern is that this was a real quickie; it does a very
> aggressive takedown of buffer_heads.  Andrea's kernels contain a
> patch which takes a very different approach.  See
> http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.20pre
>8aa2/05_vm_16_active_free_zone_bhs-1
>
> I don't think anyone has tried that patch in isolation though...
>
> If nuke-buffers passes testing and doesn't impact performance then
> fine.  A more cautious approach would be to use the active_free_zone_bhs
> patch.  If that proves inadequate then add in the "read" part of
> nuke-buffers. That means dropping the fs/buffer.c part.
> -


On Friday 25 October 2002 09:57 am, Rik van Riel wrote:
> On Thu, 24 Oct 2002, James Cleverdon wrote:
> > We have some customers with some fairly beefy servers.  They can get the
> > system into an unusable state that has been reported on lkml before.
> >
> > The two attached patches applied to 2.4.19 fix the problem on our test
> > boxes.
> >
> > Are these patches still considered a good idea for 2.4?  Is there
> > something better I should be using?
>
> Yes, these patches are a good idea.  I'm curious why they
> haven't been submitted to Marcelo yet ;)
>
> Rik


-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com

