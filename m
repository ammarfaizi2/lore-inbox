Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964964AbVKVPxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964964AbVKVPxl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 10:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964970AbVKVPxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 10:53:40 -0500
Received: from relais.videotron.ca ([24.201.245.36]:22310 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S964964AbVKVPxk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 10:53:40 -0500
Date: Tue, 22 Nov 2005 10:53:39 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: How can I prevent MTD to access the end of a flash device ?
In-reply-to: <cda58cb80511220658n671bc070v@mail.gmail.com>
X-X-Sender: nico@localhost.localdomain
To: Franck <vagabon.xyz@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.64.0511221042560.6022@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <cda58cb80511070248o6d7a18bex@mail.gmail.com>
 <cda58cb80511220658n671bc070v@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2005, Franck wrote:

> Hi,
> 
> I have two questions that I can't answer by my own. I tried to look at
> FAQ and documentation on MTD website but found no answer.

Please consider using the MTD mailing list next time (you certainly read 
about it on the MTD web site).

> First question is about size of flash. I have a Intel strataflash
> whose size is 32MB but because of a buggy platform hardware I can't
> access to the last 64KB of the flash. How can I make MTD module aware
> of this new size. The restricted map size is initialized by my driver
> but it doesn't seem to be used by MTD.

The easiest thing to do is to define MTD partitions, the last one being 
the excluded flash area.

> The second question is about the "cacheable" mapping field in map_info
> structure. I looked at others drivers and this field seems to be
> optional.

It is.

> Does this field, if set, improve flash access a lot ?

Yes.  It was tested on ARM only though.  Some architectures like i386 
for example might need special tricks to implement this.

> Should I set up a cacheable mapping ?

Consider the comment for the inval_cache method in 
include/linux/mtd/map.h and look at lubbock-flash.c for example.


Nicolas
