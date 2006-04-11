Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbWDLFqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbWDLFqa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 01:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750883AbWDLFqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 01:46:30 -0400
Received: from mail.kroah.org ([69.55.234.183]:35740 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750871AbWDLFq3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 01:46:29 -0400
Date: Tue, 11 Apr 2006 13:42:03 -0700
From: Greg KH <greg@kroah.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Binary sysfs blobs
Message-ID: <20060411204203.GA6177@kroah.com>
References: <20060411110841.71390306.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060411110841.71390306.zaitcev@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2006 at 11:08:41AM -0700, Pete Zaitcev wrote:
> Hi, Greg:
> 
> I was reviewing some patches here and noticed (yes, only now noticed) that
> we have operations on binary blobs in fs/sysfs/bin.c. I thought it wasn't
> part of the deal for sysfs, with one value per file and so on. I suppose
> it's too late to debate now, but I have a couple of questions:
> 
>  - Do you know of any conventions which allow to determine which file
>    is binary? Maybe the name starting with an underscore or something?

Hm, no, no convention right now, sorry.

>  - Is there a standing policy that reading from a sysfs file is not
>    altering a state of the corresponding hardware? This is not related
>    to blobs directly, but with people passing structs now, it's tempting
>    to implement some extended protocols. I am concerned of stealing
>    network packets by accident or something.

No.  Binary sysfs files are for "pass-through" mode only.  You are ONLY
allowed to use them if you want to read from, or write to, some bit of
hardware and not manipulate the data at all.  Examples of this is the
raw PCI config space, firmware binary blobs and BIOS upgrades.

You should NEVER pass a raw structure through sysfs by using a binary
file.  If anyone sees anywhere in the current kernel that does this,
please let me know and I'll go hit them with a big stick...

And yes, I know the documentation on the conventions for this is
seriously lacking.  Fixing that is slowly moving up my TODO list...

Hope this helps,

greg k-h
