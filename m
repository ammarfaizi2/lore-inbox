Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbVIMTmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbVIMTmt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 15:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932656AbVIMTmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 15:42:49 -0400
Received: from terminus.zytor.com ([209.128.68.124]:56210 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932454AbVIMTms
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 15:42:48 -0400
Message-ID: <43272B9D.1030301@zytor.com>
Date: Tue, 13 Sep 2005 12:42:21 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Frank Sorenson <frank@tuxrocks.com>
CC: pascal.bellard@ads-lu.com, Riley@Williams.Name,
       Linux-Kernel@vger.kernel.org
Subject: Re: [i386 BOOT CODE] kernel bootable again
References: <33542.85.68.36.53.1126619176.squirrel@212.11.36.192> <432722A1.8030302@tuxrocks.com>
In-Reply-To: <432722A1.8030302@tuxrocks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Sorenson wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Pascal Bellard wrote:
> 
>>Hello,
>>
>>Please find attached a patch to build i386/x86_64 kernel directly
>>bootable. It may be usefull for rescue floppies and installation
>>floppies.
> 
> 
> Pascal,
> 
> In commit f8eeaaf4180334a8e5c3582fe62a5f8176a8c124, build.c has already
> changed, and I don't believe it's very compatible with this change.
> 
> See
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=f8eeaaf4180334a8e5c3582fe62a5f8176a8c124
> 
> Also, we'll need to see comments from H. Peter Anvin on this patch.
> CC'ing him.
> 

Geometry detection by looking for error returns is fundamentally broken. 
  Way too many non-traditional floppies (USB, IDE...) do not handle this 
at all, they will return successfully, with the data being the data from 
a sector from another track, and thus you end up with aliasing and a 
corrupt boot.  You can do it with fingerprinting, but that's complex and 
error-prone.

In short, this made sense in 1991, but it hasn't made sense for a very 
long time now.  Resurrecting bootsect.S is *NOT* a good idea.

	-hpa
