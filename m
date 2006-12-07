Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163995AbWLGXcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163995AbWLGXcT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 18:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163636AbWLGXcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 18:32:18 -0500
Received: from ozlabs.org ([203.10.76.45]:45150 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163995AbWLGXcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 18:32:17 -0500
From: Michael Neuling <mikey@neuling.org>
To: Haren Myneni <haren@us.ibm.com>
cc: vgoyal@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@ftp.linux.org.uk>, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] free initrds boot option 
In-reply-to: <45788A56.9010706@us.ibm.com> 
References: <4410.1165450723@neuling.org> <20061206163021.f434f09b.akpm@osdl.org> <4577624A.6010008@zytor.com> <13639.1165462578@neuling.org> <20061207164756.GA13873@in.ibm.com> <45788A56.9010706@us.ibm.com>
Comments: In-reply-to Haren Myneni <haren@us.ibm.com>
   message dated "Thu, 07 Dec 2006 13:40:38 -0800."
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 21.4.1
Date: Fri, 08 Dec 2006 10:32:15 +1100
Message-ID: <30054.1165534335@neuling.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >Is there a kexec-tools patch too? How does second kernel know about
> >the location of the first kernel's initrd to be reused?
> >  
> >
> kexec-tools has to be modified to pass the first kernel initrd. On 
> powerpc, initrd locations are exported using device-tree. At present, 
> kexec-tool ignores the first kernel initrd property values and creates 
> new initrd properties if the user passes '--initrd' option to the kexec 
> command. So, will be an issue unless first kernel device-tree is passed 
> as buffer.

We've been using the --devicetreeblob kexec-tools option available for
POWERPC.  This enables you to setup the device tree (and hence, the
initrd points) as you like.

I'm happy to put together a patch for kexec-tools.  Unfortunately this
is arch specific.  A quick look through the x86, ia64, s390 and ppc64
code shows the --initrd option for all these just reads the specified
initrd file, pushes it out to memory and uses the base and size pointers
to setup the next boot.  We'd obviously just skip to the last stage.

So what's the kexec-tools option called?  --initrd-location <base> <size>?

(BTW I'm offline soon, so I probably won't get to this for a few weeks)

> Initrd memory can be excluded like other segments such as RTAS and TCE
> on powerpc. However it is not implemented yet even on powerpc and is
> an issue on other archs.

The above should allow us to do these checks in kexec-tools.  

Mikey
