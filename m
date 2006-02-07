Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965139AbWBGPrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965139AbWBGPrS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 10:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965140AbWBGPrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 10:47:17 -0500
Received: from terminus.zytor.com ([192.83.249.54]:56282 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S965137AbWBGPrQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 10:47:16 -0500
Message-ID: <43E8C0F3.5080205@zytor.com>
Date: Tue, 07 Feb 2006 07:46:59 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Luca Berra <bluca@comedia.it>
CC: Neil Brown <neilb@suse.de>, linux-raid@vger.kernel.org,
       klibc list <klibc@zytor.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [klibc] Re: Exporting which partitions to md-configure
References: <43DEB4B8.5040607@zytor.com> <17374.47368.715991.422607@cse.unsw.edu.au> <43DEC095.2090507@zytor.com> <17374.50399.1898.458649@cse.unsw.edu.au> <43DEC5DC.1030709@zytor.com> <17382.43646.567406.987585@cse.unsw.edu.au> <43E80A5A.5040002@zytor.com> <20060207104311.GD22221@percy.comedia.it>
In-Reply-To: <20060207104311.GD22221@percy.comedia.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luca Berra wrote:
> 
>> This, in fact is *EXACTLY* what we're talking about; it does require 
>> autoassemble.  Why do we care about the partition types at all?  The 
>> reason is that since the md superblock is at the end, it doesn't get 
>> automatically wiped if the partition is used as a raw filesystem, and 
>> so it's important that there is a qualifier for it.
> 
> I don't like using partition type as a qualifier, there is people who do
> not wish to partition their drives, there are systems not supporting
> msdos like partitions, heck even m$ is migrating away from those.
> 

That's why we're talking about non-msdos partitioning schemes.

> In any case if that has to be done it should be done into mdadm, not
> in a different scrip that is going to call mdadm (behaviour should be
> consistent between mdadm invoked by initramfs and mdadm invoked on a
> running system).

Agreed.  mdadm is the best place for it.

> If the user wants to reutilize a device that was previously a member of
> an md array he/she should use mdadm --zero-superblock to remove the
> superblock.
> I see no point in having a system that tries to compensate for users not
> following correct procedures. sorry.

You don't?  That surprises me... making it harder for the user to have 
accidental data loss sounds like a very good thing to me.
	
	-hpa
