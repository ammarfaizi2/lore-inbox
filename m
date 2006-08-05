Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932476AbWHEUbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbWHEUbk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 16:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932499AbWHEUbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 16:31:40 -0400
Received: from ptb-relay02.plus.net ([212.159.14.213]:21683 "EHLO
	ptb-relay02.plus.net") by vger.kernel.org with ESMTP
	id S932476AbWHEUbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 16:31:39 -0400
Message-ID: <44D4FFF2.6040105@mauve.plus.com>
Date: Sat, 05 Aug 2006 21:30:42 +0100
From: Ian Stirling <ian.stirling@mauve.plus.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Avinash Ramanath <avinashr@gmail.com>, kernelnewbies@nl.linux.org,
       linux-kernel@vger.kernel.org
Subject: Re: Zeroing data blocks
References: <abcd72470607081856i47f15dedre9be9278ffa9bab4@mail.gmail.com>	 <1152435182.3255.39.camel@laptopd505.fenrus.org>	 <abcd72470608050055w51f2bfbcrbd26b59fc32dc494@mail.gmail.com>	 <1154790620.3054.69.camel@laptopd505.fenrus.org>	 <abcd72470608051013s42ba14e1g8c3289a3e551c7ca@mail.gmail.com> <1154799834.3054.93.camel@laptopd505.fenrus.org>
In-Reply-To: <1154799834.3054.93.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Sat, 2006-08-05 at 10:13 -0700, Avinash Ramanath wrote:
> 
>>Hi,
>>
>>I want to do this at the filesystem-level not in user-space.
>>I have a stackable-filesystem that runs as a layer on top of the
>>existing filesystem (with all the function pointers mapped to the
>>corresponding base filesystem function pointers, and other suitable
>>adjustments).
>>So yes I have access to the filesystem.
>>But the question is how can I access those particular data-blocks?
> 
> 
> I think you misunderstood: You need to do this in the filesystem layer
> that allocates and tracks the blocks. You really can't do it outside
> that...

On modern (>200 meg or so) disk drives, you can't do it at all without 
drive-specific debug tools.

The problem is that the drive, if it detects a bad sector, may well
remap the track that the sector is on to a spare track. You then
simply cannot access the old track. The drive may or may not zero
it for you.
Any standard access will simply ignore the old copy of the track.
It may or may not be possible to retrieve/erase it with disk-drive
specific tools that the vendor won't give you anyway.

If you want to do this reliably - you need to encrypt the disk
(not with loopcrypt or dm-crypt in its current state) so you can
just throw it away.
