Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161056AbWGITHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161056AbWGITHX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 15:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161059AbWGITHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 15:07:23 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:2245
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1161056AbWGITHX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 15:07:23 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Martin Langer <martin-langer@gmx.de>
Subject: Re: [RFC][PATCH 1/2] firmware version management: add firmware_version()
Date: Sun, 9 Jul 2006 21:09:02 +0200
User-Agent: KMail/1.9.1
References: <20060708130904.GA3819@tuba> <1152457310.3255.58.camel@laptopd505.fenrus.org> <20060709152516.GB3678@tuba>
In-Reply-To: <20060709152516.GB3678@tuba>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org,
       bcm43xx-dev@lists.berlios.de, Arjan van de Ven <arjan@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200607092109.02707.mb@bu3sch.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 July 2006 17:25, you wrote:
> > yes it does. bcm43xx asks userspace to upload firmware (via
> > request_firmware() ) and a userspace app (udev most of the time) will
> > upload it. That app, eg udev, can do the md5sum and checking it against
> > a list of "known good" firmwares. Voila problem solved ;)
> 
> I see. It's an interesting way that I didn't noticed. 
> Thanks for the guidance.

Nono, stop. Not too fast. :)
Where is this "list of "known good" firmwares" actually stored?
In userspace (udev)? That would be guaranteed to be out of sync
with the driver.
As said previously, we need to tie a specific driver version to
one or more firmware versions. So the only sane place to put the
MD5 sums (or whatever) in, is the driver. Otherwise it will not
be in sync.

So, if we want to verify the checksum in userspace, we must
export a list of known good checksums to userspace.
Could be done through a sysfs file with a list of checksums.

cat /sys/foo/device/acceptable_firmwares
MD5: cbd8320a2a458d1cfad5420c6fa6a823
MD5: b812d7dd3d3b88fbc113e0bbf7e07c8d

That would also allow other hash algorithms in future
while providing backward compat.

-- 
Greetings Michael.
