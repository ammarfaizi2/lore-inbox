Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265130AbSKVRsp>; Fri, 22 Nov 2002 12:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265132AbSKVRsp>; Fri, 22 Nov 2002 12:48:45 -0500
Received: from host194.steeleye.com ([66.206.164.34]:20241 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S265130AbSKVRsp>; Fri, 22 Nov 2002 12:48:45 -0500
Message-Id: <200211221755.gAMHtn703551@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
       Sam Ravnborg <sam@ravnborg.org>, john stultz <johnstul@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] subarch cleanup 
In-Reply-To: Message from "Martin J. Bligh" <mbligh@aracnet.com> 
   of "Fri, 22 Nov 2002 09:20:36 PST." <1053855634.1037956835@[10.10.2.3]> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 22 Nov 2002 11:55:49 -0600
From: "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mbligh@aracnet.com said:
> Duplicating all the code sections into all the subarches is an
> impractical maintainance nightmare. Yet that's how it seems to be set
> up at the moment (kind of OK if you only have 1 subarch apart from
> generic, but not in general). 

well, the way it works was modelled on the asm-arch to asm-generic setup (and 
we have currently twenty of those).

But still, I agree that a default fallback is a better way of doing it.

> If you have a different suggestion for fixing subarch support, please
> outline it .... 

Well, I think what Alan does in -ac6 is the correct approach (with 
mach-default fallback, not mach-generic, which is really PC specific).  The 
only difference between Alan and John's patches (apart from mach-default) is 
the _H _C split and the location of the header files.

I've no real objection to the _H _C split, other than it seems a bit 
contorted.  The intent I originally had was that all subarchs would have a 
small setup.c file (copied and modified from mach-generic), so I didn't 
envisage having a subarch which wanted to use the generic setup.c and a 
different _H directory.  Doing a _H _C split reduces simplicity.

As far as the location of _H.  All I'm really fishing for is a better reason 
than "because they're header files" basically because I believe interface 
containment has value.

James


