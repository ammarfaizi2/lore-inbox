Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936172AbWLAKa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936172AbWLAKa4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 05:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936135AbWLAKaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 05:30:55 -0500
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:57549 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S936172AbWLAKaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 05:30:55 -0500
Message-ID: <4570045D.40100@s5r6.in-berlin.de>
Date: Fri, 01 Dec 2006 11:30:53 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.8) Gecko/20061030 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Keith Curtis <Keith.Curtis@digeo.com>
CC: Robert Crocombe <rcrocomb@gmail.com>,
       linux1394-devel <linux1394-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: isochronous receives?
References: <DD2010E58E069B40886650EE617FCC0CBA8EC9@digeo-mail1.digeo.com>
In-Reply-To: <DD2010E58E069B40886650EE617FCC0CBA8EC9@digeo-mail1.digeo.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Curtis wrote:
> I never resolved the problem. I turned on the excessive debugging output, but it 
> didn't print out info about receiving packets or interrupts. My test 
> app claimed there were no packets received although the bus analyzer 
> showed lots of packets going by.  
> 
> If I can help out, let me know, but I'm not sure where to start at this point.
...
> -----Original Message-----
> From: Robert Crocombe [mailto:rcrocomb@gmail.com]
> Sent: Tuesday, November 28, 2006 4:59 PM
...
> Did you ultimately have any success getting this going?  Funnily
> enough, when I tested isochronous stuff in July, I just did iso
> transmit since I figured receives *must* be working since everyone has
> camcorders and whatnot.  My currently my iso xmit stuff does appear to
> be working, but iso receives are not.
> 
> I have a Firespy and no reason not to trust it, so I can see the junk
> I'm spewing out.  I've tried transmitting on channels 4 and 63 (per
> your advice), but neither works for me.  I suppose it could my
> stuff... nah.

I don't know much about the mechanisms, but I suppose there could be one
of the following causes:
 - The IR DMA context was never set up for the respective channel in the
   first place.
 - The context was set up but the interrupt event masks weren't switched
   on, i.e. IntMask as per OHCI clause 6.2 and isoRecvIntMask as per
   clause 6.3.2.
 - The context and masks were set up, but then one or both of the masks
   were switched off again, similar to the bus reset bug which Robert
   reported: http://bugzilla.kernel.org/show_bug.cgi?id=7569
-- 
Stefan Richter
-=====-=-==- ==-- ----=
http://arcgraph.de/sr/
