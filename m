Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263640AbUEGP0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263640AbUEGP0l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 11:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263615AbUEGP0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 11:26:41 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:2786 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263640AbUEGP0i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 11:26:38 -0400
Date: Fri, 07 May 2004 08:26:10 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>, Paul Jakma <paul@clubi.ie>
cc: arjanv@redhat.com, Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK)
Message-ID: <535920000.1083943568@[10.10.2.4]>
In-Reply-To: <20040506205838.6948a018.akpm@osdl.org>
References: <20040505013135.7689e38d.akpm@osdl.org><200405051312.30626.dominik.karall@gmx.net><200405051822.i45IM2uT018573@turing-police.cc.vt.edu><20040505215136.GA8070@wohnheim.fh-wedel.de><200405061518.i46FIAY2016476@turing-police.cc.vt.edu><1083858033.3844.6.camel@laptop.fenrus.com><Pine.LNX.4.58.0405070136010.1979@fogarty.jakma.org><20040506195002.520b0793.akpm@osdl.org><Pine.LNX.4.58.0405070433170.1979@fogarty.jakma.org> <20040506205838.6948a018.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Andrew Morton <akpm@osdl.org> wrote (on Thursday, May 06, 2004 20:58:38 -0700):

> Paul Jakma <paul@clubi.ie> wrote:
>> 
>> Fair enough but have a look at the other fault from that bug though:
>> 
>>  	https://bugzilla.redhat.com/bugzilla/attachment.cgi?id=99855&action=view 
>> 
>>  That one did not recurse for some reason.
> 
> OK.
> 
> So we're 50 to 60 levels deep in function calls there and simply ran out
> of 4k stack.
> 
> Based on this and upon the few other feedbackings I've had on this issue it
> seems that the 4k stack experiment will come back saying "no"

There's two problems with that stack .... 

1. it seems to have the IRQ on it as well as normal traffic instead of 
using the separate irqstacks ... why isn't that working?

2 nfs_writepage_sync is a known stack-abuser ;-) 1632 bytes on PPC64 at least
(from Anton's data). Maybe it's that struct nfs_write_data ?

M.

