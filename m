Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751035AbWDXRb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbWDXRb7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 13:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbWDXRb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 13:31:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32215 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751035AbWDXRb6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 13:31:58 -0400
Date: Mon, 24 Apr 2006 10:28:25 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
cc: Dave Airlie <airlied@linux.ie>, Andrew Morton <akpm@osdl.org>,
       Matthew Reppert <arashi@sacredchao.net>, linux-kernel@vger.kernel.org,
       "Antonino A. Daplas" <adaplas@pol.net>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PCI ROM resource allocation issue with 2.6.17-rc2
In-Reply-To: <1145898993.3116.50.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.64.0604241025120.3701@g5.osdl.org>
References: <1145851361.3375.20.camel@minerva>  <20060423222122.498a3dd2.akpm@osdl.org>
  <Pine.LNX.4.64.0604240652380.31142@skynet.skynet.ie> 
 <Pine.LNX.4.64.0604241002460.3701@g5.osdl.org> <1145898993.3116.50.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 24 Apr 2006, Arjan van de Ven wrote:
> 
> you haven't spent enough time reading the X pci code then ;)
> (or rather, you've done the same thing but hey who's counting)
> 
> X does all that *itself* based on what X thinks is best.

Yeah, I knew that used to be true, but I was hoping the new interfaces 
would have made it obsolete. Especially as the DRM layer _does_ now enable 
the device on demand.

Maybe just add a DRM command to do it, so that old X versions (who don't 
know about it) will just do it by hand, and then new X versions can do

	if (drm_ioctl(fd, DRM_SETUP_THE_DAMN_RESOURCES) < 0) {
		/*
		 * I don't know what errno the drm-ioctl actually
		 * returns for unrecognized commands, so this is
		 * just an example
		 */
		if (errno == ENOTTY) {
			old kernel: do it by hand
		}
	}

which allows us to go forward in a sane way, and finally leave the broken 
X PCI-configuration-by-hand crap behind.

Please?

			Linus
