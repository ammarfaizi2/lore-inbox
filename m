Return-Path: <linux-kernel-owner+w=401wt.eu-S1751587AbWLMB4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbWLMB4A (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 20:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751595AbWLMB4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 20:56:00 -0500
Received: from koto.vergenet.net ([210.128.90.7]:33309 "EHLO koto.vergenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751382AbWLMBz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 20:55:59 -0500
X-Greylist: delayed 1248 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Dec 2006 20:55:59 EST
Date: Wed, 13 Dec 2006 10:35:08 +0900
From: Horms <horms@verge.net.au>
To: Michael Neuling <mikey@neuling.org>
Cc: Haren Myneni <haren@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       "H. Peter Anvin" <hpa@zytor.com>, Al Viro <viro@ftp.linux.org.uk>,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [PATCH] free initrds boot option
Message-ID: <20061213013506.GB22902@verge.net.au>
References: <4410.1165450723@neuling.org> <20061206163021.f434f09b.akpm@osdl.org> <4577624A.6010008@zytor.com> <13639.1165462578@neuling.org> <20061207164756.GA13873@in.ibm.com> <45788A56.9010706@us.ibm.com> <30054.1165534335@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30054.1165534335@neuling.org>
User-Agent: mutt-ng/devel-r804 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2006 at 10:32:15AM +1100, Michael Neuling wrote:
> > >Is there a kexec-tools patch too? How does second kernel know about
> > >the location of the first kernel's initrd to be reused?
> > >  
> > >
> > kexec-tools has to be modified to pass the first kernel initrd. On 
> > powerpc, initrd locations are exported using device-tree. At present, 
> > kexec-tool ignores the first kernel initrd property values and creates 
> > new initrd properties if the user passes '--initrd' option to the kexec 
> > command. So, will be an issue unless first kernel device-tree is passed 
> > as buffer.
> 
> We've been using the --devicetreeblob kexec-tools option available for
> POWERPC.  This enables you to setup the device tree (and hence, the
> initrd points) as you like.
> 
> I'm happy to put together a patch for kexec-tools. 

Please do. And please cc me on a copy that applies against kexec-tools-testing.

> Unfortunately this
> is arch specific.  A quick look through the x86, ia64, s390 and ppc64
> code shows the --initrd option for all these just reads the specified
> initrd file, pushes it out to memory and uses the base and size pointers
> to setup the next boot.  We'd obviously just skip to the last stage.
> 
> So what's the kexec-tools option called?  --initrd-location <base> <size>?

That sounds fine to me. I think its ok to make it arch specific for
starters and then move it out to generic code later. That said, if
you're feeling particularly entergetic, feel free to do the generic
stuff now and just add null stubs for the other architectures (does
that makes sense?).

-- 
Horms
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/

