Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265455AbTFZIEx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 04:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265458AbTFZIEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 04:04:53 -0400
Received: from mail.convergence.de ([212.84.236.4]:54235 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S265455AbTFZIEq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 04:04:46 -0400
Message-ID: <3EFAAC69.6090709@convergence.de>
Date: Thu, 26 Jun 2003 10:18:49 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.3) Gecko/20030408
X-Accept-Language: de-at, de, en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: =?UTF-8?B?SsO2cm4gRW5nZWw=?= <joern@wohnheim.fh-wedel.de>,
       Marcus Metzler <mocm@metzlerbros.de>,
       Christoph Hellwig <hch@infradead.org>, mocm@mocm.de,
       Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Johannes Stezenbach <js@convergence.de>
Subject: Re: DVB Include files
References: <20030625181606.A29104@infradead.org>	 <16121.55873.675690.542574@sheridan.metzler>	 <20030625182409.A29252@infradead.org>	 <16121.56382.444838.485646@sheridan.metzler>	 <20030625185036.C29537@infradead.org>	 <16121.58735.59911.813354@sheridan.metzler>	 <20030625191532.A1083@infradead.org>	 <16121.60747.537424.961385@sheridan.metzler>	 <20030625194250.GF1770@wohnheim.fh-wedel.de>	 <16122.379.321217.737557@sheridan.metzler>	 <20030625202312.GG1770@wohnheim.fh-wedel.de> <1056582481.1998.20.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1056582481.1998.20.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alan and others,

>>So you don't recompile, but you still changed the magic ioctl numbers
>>from 17 to 47 and from 18 to 48.  Old binaries don't work any more,
>>even though the same semantics are still present.  That is an
>>incompatible change in my book.
>>
>>Worse if there is a new semantic for 17 or 18, in that case the old
>>binaries may break randomly, depending on kernel version.
> 
> 
> Sure but you keep old ones around once its stable. This is a completely
> pointless conversation to have before 2.6.0-test kernels. There isnt a
> stable in kernel dvb api yet because its not been shipped in a stable
> kernel.
> 
> (Although I'd note the api has been as stable if not more stable than
> some in kernel stuff 8))

Amen. That's exactly the point -- the v3 dvb api is stable and hasn't
changed for a long time.

So, to make a long story short:

In include/linux/dvb we have the headers that are shared between user
applications and the kernel driver. As I said above, these are stable and
never change for the v3 api. In an ideal world, these header files would
be included in your glibc distribution at /usr/include/linux/dvb
Currently, you must copy them by hand or create a symlink, because there
hasn't been an official kernel with the dvb driver subsystem yet.

The whole discussion was about the *in-kernel* header files in
drivers/media/dvb/dvb-core. These are used in drivers/media/dvb/frontends
for example, so we currently have one line in the Makefile that says to
have drivers/media/dvb/dvb-core in the include path.

This was the original point Sam Ravnborg was wondering about. It's safe to
move these files to inlude/dvb and get rid of the magic line in the
Makefile.

CU
Michael.

