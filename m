Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262549AbTCMVi7>; Thu, 13 Mar 2003 16:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262555AbTCMVi7>; Thu, 13 Mar 2003 16:38:59 -0500
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:39117 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S262549AbTCMViz>; Thu, 13 Mar 2003 16:38:55 -0500
Message-ID: <20030313214908.27753.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>
To: tmolina@cox.net, akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date: Thu, 13 Mar 2003 22:49:08 +0100
Subject: Re: 2.5.64-mm6
X-Originating-Ip: 213.4.13.153
X-Originating-Server: ws5-7.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: Thomas Molina <tmolina@cox.net> 
Date: 	Thu, 13 Mar 2003 14:35:18 -0600 (CST) 
To: Andrew Morton <akpm@digeo.com> 
Subject: Re: 2.5.64-mm6 
 
> I downloaded the mm-6 patch and a pristine 2.5.64 tarball.  After applying  
> the patch I compiled with the standard configuration I've been using all  
> along.  No problems were noted during the compile cycle.  During bootup  
> the system locked up at the point where it did a modprobe uhci-hcd for the  
> USB controller.  Nothing of interest was noted in the log.  I rebooted  
> with nousb in the command line and got a good boot.  After working with  
> this kernel for awhile I don't see anything out of the ordainary except  
> that on a 2.5.64-bk kernel I get 330 Kbytes per second download speed  
> whereas with mm6 I get 280 Kbytes per second.  Several runs show this is  
> fairly consistent, with results within one or two percent. 
 
Hmmm... I have experienced some hard locks similar to what 
you describe: if I compile usb-uhci as a module, Phoebe3 
(8.0.94) locks hard at the time of doing a "modprobe 
usb-controller" (being usb-controller an alias for uhci-hcd) 
during boot (rc.sysinit script). To fix this, I have had  to compile 
usb-uhci in to the kernel and then fix rc.sysinit. I haven't tried 
using usb-uhci as a module since then. 
 
What's curious is that doing a "modprobe usb-controller" by 
hand doesn't cause hard locks. So, there must be some kind 
of timing or interaction that's causing rc.sysinit to invoke 
"modprobe uchi-hcd" and freeze the machine. Any ideas? 
 
   Felipe 
 
-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
