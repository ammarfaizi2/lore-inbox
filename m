Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbWDZBXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbWDZBXr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 21:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbWDZBXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 21:23:47 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:10415 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932192AbWDZBXq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 21:23:46 -0400
Date: Wed, 26 Apr 2006 02:23:40 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet.skynet.ie
To: Linus Torvalds <torvalds@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Matthew Reppert <arashi@sacredchao.net>, linux-kernel@vger.kernel.org,
       "Antonino A. Daplas" <adaplas@pol.net>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PCI ROM resource allocation issue with 2.6.17-rc2
In-Reply-To: <Pine.LNX.4.64.0604241025120.3701@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0604260221560.31555@skynet.skynet.ie>
References: <1145851361.3375.20.camel@minerva>  <20060423222122.498a3dd2.akpm@osdl.org>
  <Pine.LNX.4.64.0604240652380.31142@skynet.skynet.ie> 
 <Pine.LNX.4.64.0604241002460.3701@g5.osdl.org> <1145898993.3116.50.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.64.0604241025120.3701@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
> Maybe just add a DRM command to do it, so that old X versions (who don't
> know about it) will just do it by hand, and then new X versions can do
>
> 	if (drm_ioctl(fd, DRM_SETUP_THE_DAMN_RESOURCES) < 0) {
> 		/*
> 		 * I don't know what errno the drm-ioctl actually
> 		 * returns for unrecognized commands, so this is
> 		 * just an example
> 		 */
> 		if (errno == ENOTTY) {
> 			old kernel: do it by hand
> 		}
> 	}
>
> which allows us to go forward in a sane way, and finally leave the broken
> X PCI-configuration-by-hand crap behind.

It doesn't help of course, the fb drivers also pci_enable the devices, 
really X needs a kicking square, I'm trying to figure out some sort of fix 
here, but X does't some really stupid things with PCI resources...

We really need a userspace way to pci_enable_device that X can call (via 
sysfs) so for cards that don't have a DRM or fb loaded we still get 
something..

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG

