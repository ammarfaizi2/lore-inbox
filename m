Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275243AbTHMPey (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 11:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275245AbTHMPey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 11:34:54 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:15576 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S275243AbTHMPeY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 11:34:24 -0400
Message-ID: <F341E03C8ED6D311805E00902761278C0C35E6E4@xfc04.fc.hp.com>
From: "HABBINGA,ERIK (HP-Loveland,ex1)" <erik.habbinga@hp.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'kens1835@shaw.ca'" <kens1835@shaw.ca>
Subject: Re: High CPU load with kswapd and heavy disk I/O
Date: Wed, 13 Aug 2003 11:34:17 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I regularly run the 2.4.21 kernel with 2GB of ram, and I've had to apply
Andrew Morton's patch from a year ago that "hunts down buffer heads and
kills them":

http://marc.theaimsgroup.com/?l=lse-tech&m=102083525007877&w=2

With this patch, kswapd never goes crazy for me anymore.  BTW, if you're
using NFS (you don't mention it), I've also had great luck improving NFS
performance by using Andrea's address space reconfiguration patch:

http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.22pre7
aa1/00_3.5G-address-space-5

and selecting the CONFIG_2GB option.  This configuration along with 2GB of
ram gives me excellent NFS performance.  Increasing the system RAM to 4GB
with any memory address configuration hurts my performance.  The combination
of CONFIG_2GB and 2GB of ram has given me the best performance.  Note that
changing the address space configuration like I've mentioned violates the
ABI (http://stage.caldera.com/developer/devspecs/abi386-4.pdf   page 47), so
your applications might not work as expected.  I've also needed to use Neil
Brown's "remove the BKL from NFSD" patches, which can be found at:

http://cgi.cse.unsw.edu.au/~neilb/patches/linux-stable/?detail=2003-01-06:00

(patches 005 thru 011)

Erik

On Tue August 12 2003 16:49, Nuno Silva wrote: 


> My guess is that this is the cause. LOWMEM pressure because of very 
> large directories... Relating to this, linux-2.6.0-test3-mm1 has Ingo's 
> 4G/4G memory split. Can you try this kernel, enable 4G/4G feature, and 
> report back? 


Something about the 2.6 (and the rmap patched 2.4) kernels causes 
lockouts on the server -- for reasons OTHER than kswapd. The server 
running the delete-old-files process runs hundreds of other CPU and disk 
I/O intensive processes/threads, and it doesn't look like 2.6 is yet able 
to handle the load. Unfortunately, the server is a production environment 
machine at a remote site, so lockouts/reboots/kernel panics are baaaad :( 


I've seen other mentions of kswapd/kupdated problems in 2.4.xx, but 
few mentions of solutions. Have people just learned to avoid the 
situations that trigger the mad thrashes? 


Ken 


