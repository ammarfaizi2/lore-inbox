Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbTKIKS5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 05:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262308AbTKIKS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 05:18:57 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:43279 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S262303AbTKIKSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 05:18:55 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Greg KH <greg@kroah.com>
Subject: Re: Accessing device information in REMOVE agent
Date: Sun, 9 Nov 2003 13:06:13 +0300
User-Agent: KMail/1.5.3
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <200311081602.25978.arvidjaar@mail.ru> <20031108222529.GB7671@kroah.com>
In-Reply-To: <20031108222529.GB7671@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311091306.13580.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 November 2003 01:25, Greg KH wrote:
> On Sat, Nov 08, 2003 at 04:02:25PM +0300, Andrey Borzenkov wrote:
> > I'd like to be notified when block device goes away (e.g. USB stick
> > unplugged) basically to look if device is in use and possibly initiate
> > clean up. Block hotplug currently is passing only DEVPATH; but it alone
> > is not reliable way to identify it; device may be used under alias names
> > via symbolic links.
>
> What do you mean?  DEVPATH is unique for that point in time.  There are
> no alias's in sysfs.
>

Sorry I had to be more precise.

I'd like to (try to) replace current synchronous media change checks in 
supermount by mounting device on insert and releasing it on remove. For those 
cases when it makes sense of course, USB sticks in the first place.

But users are free to use any names or links for their device names i.e. they 
can do

ln -s sda /de/myflash
mount /dev/myflash

and on remove it is rather hard to match this name against DEVPATH. But I can 
save (major,minor) when mounting and use it to match mounted filesystem on 
remove.

>
> > Would it make sense to add device number? It seems to be natural native
> > "block device ID" :)
>
> What "device number"?  The major/minor?  Why?  It's about as unique as
> DEVPATH is for any point in time.
>

Hmm ... probably I can just as well use device name (meaning genhd->disk_name) 
you are right.

Thank you

-andrey

