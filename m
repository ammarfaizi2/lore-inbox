Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263023AbTEVSVq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 14:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263025AbTEVSVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 14:21:46 -0400
Received: from [81.193.98.189] ([81.193.98.189]:17285 "HELO
	puma-vgertech.no-ip.com") by vger.kernel.org with SMTP
	id S263023AbTEVSVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 14:21:44 -0400
Message-ID: <3ECD1917.4010408@vgertech.com>
Date: Thu, 22 May 2003 19:38:15 +0100
From: Nuno Silva <nuno.silva@vgertech.com>
Organization: VGER, LDA
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en-us, pt
MIME-Version: 1.0
To: Matthew Harrell 
	<mharrell-dated-1054037874.c3b3f2@bittwiddlers.com>
CC: Martin Schlemmer <azarah@gentoo.org>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Strange terminal problem with 2.5.6[8-9]
References: <20030511004349.GA1366@bittwiddlers.com> <20030522013601.GA1327@bittwiddlers.com> <1053581519.6507.22.camel@workshop.saharact.lan> <20030522121749.GA1173@bittwiddlers.com>
In-Reply-To: <20030522121749.GA1173@bittwiddlers.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Matthew Harrell wrote:
> : 2.5.68 and later have depreciated devpts support in devfs.  Thus
> : you have to enable:
> : 
> :  CONFIG_DEVPTS_FS=y
> : 
> : and mount it during boot.  Easy way is just to add to fstab:
> : 
> : ------------------
> : none	/dev/pts	devpts	defaults	0 0
> : ------------------
> 
> Sure enough that was it.  Darn it.  I must have missed that change entirely.
> I was compiling in devpts but still figured it was mutually exclusive with
> devfs (which I am using).
> 
> Thanks
> 

Now try:
# time ps auwx > /dev/null

Here it takes more than two seconds :) That's because ps is trying to 
access /dev/pts[0-9]+ first. That results in a attempt to insert a 
module for that device.

Because I was getting tired of this i made a quick hack:
     # some confusion with devfsd and devpts in 2.5. Quick hack:
     for i in `seq 0 512` ; do  ln -s /dev/pts/$i /dev/pts$i 2>&1 > 
/dev/null ; done 2>&1 > /dev/null

..in my init scripts.

Using devfs (and devfsd) and devpts.

This is "new" in 2.5.68 and 69 :)

Regards,
Nuno Silva


