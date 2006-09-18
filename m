Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751630AbWIRJyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630AbWIRJyb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 05:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751640AbWIRJyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 05:54:31 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:3399 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751629AbWIRJya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 05:54:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=a83mYxE+LfTS3RjzlZRcftylFrHMoCKwywQHbJkO1G5nEJwAAfFoRGV9sQpiG4UZa0fgiI7MONk2G2gpW9tlezFq2/7KJEM7PS/wzSFCS1uh71FYilm9hluCcXtUeEW0Jvbu2X3iO/IoCy9LyPPjZgEGQIa6oUBGpXcKQENIq+k=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: Raid 0 Swap?
Date: Mon, 18 Sep 2006 11:50:22 +0200
User-Agent: KMail/1.8.2
Cc: Michael Tokarev <mjt@tls.msk.ru>,
       Helge Hafting <helge.hafting@aitel.hist.no>,
       Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
References: <44FB5AAD.7020307@perkel.com> <44FBFFFC.90309@tls.msk.ru> <Pine.LNX.4.61.0609041242350.17115@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0609041242350.17115@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609181150.23091.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 September 2006 12:46, Jan Engelhardt wrote:
> >> I thought kernel data weren't swapped at all?
> 
> If the swap code was swapped, who would swap it in again?
> 
> >Well, it's not that simple.  Kernel uses both swappable and
> >non-swappable memory internally.  For some things, it's
> >unswappable, for some, it's swappable.  In general, it's
> >impossible to say which parts of kernel will break (and
> >in wich ways) if swap goes havoc.
> 
> In general, everything you type in as C code (.bss, .data, .text) should be 
> unswappable. kmalloc()ed areas are resident too, and kmalloc has a 
> parameter which defines whether the allocation can/cannot push userspace 
> pages into the swap (GFP_ATOMIC/GFP_IO). So if there is some 
> kernel-allocation swapped out, it is most likely to be marked as 
> 'userspace' so that the same algorithms can be used for swapin and -out.

What are you guys talking about? IIRC kernel doesn't use
swap for its vital data structures. I recall only one
kernel thing which goes into swap: tmpfs data. Caching network
filesystems may also use swappable data, but currently grep
catches only cifs.

IOW swap is for dirtied userspace data. Please correct me
if I am wrong here.
--
vda
