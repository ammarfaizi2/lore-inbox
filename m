Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262688AbVG2SIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262688AbVG2SIT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 14:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262689AbVG2SIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 14:08:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30615 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262688AbVG2SHf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 14:07:35 -0400
Date: Fri, 29 Jul 2005 11:06:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Drab <drab@kepler.fjfi.cvut.cz>
Cc: linux-kernel@vger.kernel.org, mark_salyzyn@adaptec.com, markh@osdl.org
Subject: Re: AACRAID failure with 2.6.13-rc1
Message-Id: <20050729110631.189fcc3b.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.60.0507291343350.19795@kepler.fjfi.cvut.cz>
References: <Pine.LNX.4.60.0507052356230.1410@kepler.fjfi.cvut.cz>
	<20050728232312.063bcc14.akpm@osdl.org>
	<Pine.LNX.4.60.0507291343350.19795@kepler.fjfi.cvut.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Drab <drab@kepler.fjfi.cvut.cz> wrote:
>
>  > > [  278.732829] scsi0 (0:0): rejecting I/O to offline device
>  > > [  278.735954] Buffer I/O error on device sda2, logical block 491840
>  > > [  278.739147] lost page write due to I/O error on sda2
>  > > [  278.742389] scsi0 (0:0): rejecting I/O to offline device
>  > > [  278.745618] Buffer I/O error on device sda2, logical block 950284
>  > > [  278.748911] lost page write due to I/O error on sda2
>  > > [  278.752238] Buffer I/O error on device sda2, logical block 950285
>  > > [  278.755614] lost page write due to I/O error on sda2
>  > > [  278.759009] scsi0 (0:0): rejecting I/O to offline device
>  > > [  278.762408] Buffer I/O error on device sda2, logical block 950287
>  > > [  278.765855] lost page write due to I/O error on sda2
>  > > [  278.769318] scsi0 (0:0): rejecting I/O to offline device
>  > > ... last message repeats about 45-times ...
>  > > [  347.564676] EXT3-fs error (device sda2): ext3_find_entry: reading directory #544057 offset 0
>  > > ... here the log ends, nothing else happens then, since nothing is working when / is inaccessible ... :(
>  > 
>  > Martin, is this problem still present in 2.6.13-rc4?
>  > 
>  > If so, please cc linux-kernel on the reply, thanks.
>  > 
>  > It would also be useful if you could try reverting that aacraid patch, see
>  > if that helps.
> 
>  Hi, Andrew!
> 
>  The thing is still not fixed in 2.6.13-rc4. I had a long discussion about 
>  this with Mark Salyczyn and Mark Haverkamp. We came out with a temporary 
>  workaround, which was to set the AAC_MAX_32BIT_SGBCOUNT in aacraid.h to 
>  512 instead of 8192. The patch for this was presented 8.7.2005 on 
>  linux-scsi list by Mark Haverkamp. However this constant solution may (?) 
>  have some performance impact on the configurations which are capable of 
>  delivering a better performance (with respect to this constant at hand).
> 
>  IMHO the real solution to this problem is the new Adaptec variant of 
>  aacraid driver which uses the 'new comm' technology to negotiate all these 
>  essential parameters directly with the hardware instead of relying on some 
>  preset constants. Mark Salyzyn has the patches prepared in his patch 
>  queue, and I vote for pushing it into the mainline ASAP.

ah, thanks.

A temporary workaround which might affct performance sounds better than a
dead box though.

Mark, do you think that many systems are likely to be affected this way? 
Do you think we should do something temporary for 2.6.13?

