Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262745AbVBDIPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262745AbVBDIPn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 03:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbVBDIJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 03:09:27 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:53008 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S263302AbVBDIIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 03:08:13 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Shane Hathaway <shane@hathawaymix.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Configure MTU via kernel DHCP
Date: Fri, 4 Feb 2005 10:06:49 +0200
User-Agent: KMail/1.5.4
References: <200502022148.00045.shane@hathawaymix.org>
In-Reply-To: <200502022148.00045.shane@hathawaymix.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502041006.49912.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 February 2005 06:47, Shane Hathaway wrote:
> The attached patch enhances the kernel's DHCP client support (in 
> net/ipv4/ipconfig.c) to set the interface MTU if provided by the DHCP server.  
> Without this patch, it's difficult to netboot on a network that uses jumbo 
> frames.  The patch is based on 2.6.10, but I'll update it to the latest 
> testing kernel if that would expedite its inclusion in the kernel.
> 
> More background: it's currently difficult to netboot on a jumbo frame network 
> because when clients try to mount the root partition, they are still 
> configured with a small MTU and therefore reject packets sent by the 
> jumbo-frame-enabled NFS server.  Linux needs to set the client MTU before 
> mounting any NFS shares.  Fortunately, the DHCP protocol already supports 
> setting the MTU; this patch just integrates that feature into the kernel.
> 
> Incidentally, ipconfig.c doesn't appear to do enough bounds checking on byte 1 
> of DHCP/BOOTP extension fields (the length field).  It looks like a malicious 
> DHCP server could mess with kernel memory that way.  I could try to fix the 
> hole, but maybe someone more experienced with this code would like to verify 
> there's a problem first.

Long term solution is to use approptiately configured initramfs or initrd image
and do above mentioned stuff in userspace.
--
vda

