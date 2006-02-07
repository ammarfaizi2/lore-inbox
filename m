Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932469AbWBGQre@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbWBGQre (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 11:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbWBGQrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 11:47:33 -0500
Received: from percy.comedia.it ([212.97.59.71]:63715 "EHLO percy.comedia.it")
	by vger.kernel.org with ESMTP id S932455AbWBGQrc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 11:47:32 -0500
Date: Tue, 7 Feb 2006 17:47:30 +0100
From: Luca Berra <bluca@comedia.it>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Neil Brown <neilb@suse.de>, linux-raid@vger.kernel.org,
       klibc list <klibc@zytor.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [klibc] Re: Exporting which partitions to md-configure
Message-ID: <20060207164730.GA12480@percy.comedia.it>
Mail-Followup-To: "H. Peter Anvin" <hpa@zytor.com>,
	Neil Brown <neilb@suse.de>, linux-raid@vger.kernel.org,
	klibc list <klibc@zytor.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <43DEB4B8.5040607@zytor.com> <17374.47368.715991.422607@cse.unsw.edu.au> <43DEC095.2090507@zytor.com> <17374.50399.1898.458649@cse.unsw.edu.au> <43DEC5DC.1030709@zytor.com> <17382.43646.567406.987585@cse.unsw.edu.au> <43E80A5A.5040002@zytor.com> <20060207104311.GD22221@percy.comedia.it> <43E8C0F3.5080205@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <43E8C0F3.5080205@zytor.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2006 at 07:46:59AM -0800, H. Peter Anvin wrote:
>Luca Berra wrote:
>>
>>I don't like using partition type as a qualifier, there is people who do
>>not wish to partition their drives, there are systems not supporting
>>msdos like partitions, heck even m$ is migrating away from those.
>>
>
>That's why we're talking about non-msdos partitioning schemes.

this still leaves whole disks

>>If the user wants to reutilize a device that was previously a member of
>>an md array he/she should use mdadm --zero-superblock to remove the
>>superblock.
>>I see no point in having a system that tries to compensate for users not
>>following correct procedures. sorry.
>
>You don't?  That surprises me... making it harder for the user to have 
>accidental data loss sounds like a very good thing to me.

making it harder for the user is a good thing, but please not at the
expense of usability

the only way i see a user can have data loss is if
- a md array is stopped
- two different filesystems are created on the component devices
- these filesystems are filled with data, but not to the point of
  damaging the superblock
- then the array is started again.

if only one device is removed using mdadm the event counter would
prevent the array from being assembled again.

there are a lot of easier ways for shooting yourself in the feet :)

if we really want to be paranoid we should modify mkXXXfs to refuse
creating a filesystem if the device has an md superblock on it. (lvm2
tools are already able to ignore devices with md superblocks on them,
no clue about EVMS)

L.
-- 
Luca Berra -- bluca@comedia.it
        Communication Media & Services S.r.l.
 /"\
 \ /     ASCII RIBBON CAMPAIGN
  X        AGAINST HTML MAIL
 / \
