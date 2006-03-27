Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWC0Ikm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWC0Ikm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 03:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWC0Ikm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 03:40:42 -0500
Received: from mx1.suse.de ([195.135.220.2]:13804 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750742AbWC0Ikl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 03:40:41 -0500
Message-ID: <4427A590.5000201@suse.de>
Date: Mon, 27 Mar 2006 10:42:56 +0200
From: Gerd Hoffmann <kraxel@suse.de>
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>
Subject: Re: [RFC PATCH 35/35] Add Xen virtual block device driver.
References: <20060322063040.960068000@sorel.sous-sol.org> <20060322063809.005748000@sorel.sous-sol.org> <44217DBD.8030201@us.ibm.com>
In-Reply-To: <44217DBD.8030201@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

>> +static struct xlbd_type_info xlbd_ide_type = {
>> +static struct xlbd_type_info xlbd_scsi_type = {
>> +static struct xlbd_type_info xlbd_vbd_type = {

> This is another thing that has always put me off.  The virtual block
> device driver has the ability to masquerade as other types of block
> devices.  It actually claims to be an IDE or SCSI device allocating the
> appropriate major/minor numbers.

It's useful sometimes.  Debian/sarge for example doesn't work with xvd
block devices.  At least not out-of-the-box, it needs some manual
tweaks.  Probably it also is handy when moving real machines into an
virtual environment.  I don't think it should be dropped.

Most modern udev-based distros work just fine with xvd though.

> This seems to be pretty evil and creating interesting failure conditions
> for users who load IDE or SCSI modules.  I've seen it trip up a number
> of people in the past.  I think we should only ever use the major number
> that was actually allocated to us.

Print a big fat warning?  And also change the example config files in
the xen source tree to use xvda not hda to advertize them more than we
do right now.  I think lots of users don't even know about the xvd
devices ...

cheers,

  Gerd

-- 
Gerd 'just married' Hoffmann <kraxel@suse.de>
I'm the hacker formerly known as Gerd Knorr.
http://www.suse.de/~kraxel/just-married.jpeg
