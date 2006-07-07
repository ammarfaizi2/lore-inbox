Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbWGGIl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWGGIl6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 04:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073AbWGGIl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 04:41:58 -0400
Received: from 220-130-178-143.HINET-IP.hinet.net ([220.130.178.143]:44529
	"EHLO areca.com.tw") by vger.kernel.org with ESMTP id S932068AbWGGIl5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 04:41:57 -0400
Message-ID: <001601c6a1a1$34a17180$0132a8c0@erich2003>
From: "erich" <erich@areca.com.tw>
To: "Andrew Morton" <akpm@osdl.org>
Cc: "\"James Bottomley\"" <James.Bottomley@SteelEye.com>,
       <rdunlap@xenotime.net>, <hch@infradead.org>, <brong@fastmail.fm>,
       <dax@gurulabs.com>, <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>, <robm@fastmail.fm>
References: <09be01c695b3$2ed8c2c0$c100a8c0@robm><20060621222826.ff080422.akpm@osdl.org><1151333338.2673.4.camel@mulgrave.il.steeleye.com> <20060626080122.894de905.akpm@osdl.org>
Subject: Re: Areca driver recap + status
Date: Fri, 7 Jul 2006 16:41:53 +0800
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_000F_01C6A1E4.409E7620"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.3790.2663
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.2663
X-OriginalArrivalTime: 07 Jul 2006 08:35:07.0734 (UTC) FILETIME=[409A6F60:01C6A1A0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_000F_01C6A1E4.409E7620
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit

From: Erich Chen <erich@areca.com.tw>

  1- fix sysfs has more than one value per file
  2- PAE issues (cast of dma_addr_t to unsigned long)
  3- unblock SYNCHRONIZE_CACHE

Signed-off-by: Erich Chen <erich@areca.com.tw>

Areca had tested its arcmsr linux raid driver on ppc machines G5 and it 
worked fine.

Best Regards
Erich Chen
----- Original Message ----- 
From: "Andrew Morton" <akpm@osdl.org>
To: "James Bottomley" <James.Bottomley@SteelEye.com>
Cc: <rdunlap@xenotime.net>; <hch@infradead.org>; <erich@areca.com.tw>; 
<brong@fastmail.fm>; <dax@gurulabs.com>; <linux-kernel@vger.kernel.org>; 
<linux-scsi@vger.kernel.org>; <robm@fastmail.fm>
Sent: Monday, June 26, 2006 11:01 PM
Subject: Re: Areca driver recap + status


> On Mon, 26 Jun 2006 09:48:58 -0500
> James Bottomley <James.Bottomley@SteelEye.com> wrote:
>
>> On Wed, 2006-06-21 at 22:28 -0700, Andrew Morton wrote:
>> > On Thu, 22 Jun 2006 14:18:23 +1000
>> > "Robert Mueller" <robm@fastmail.fm> wrote:
>> >
>> > > The driver went into 2.6.11-rc3-mm1 here:
>> > > http://marc.theaimsgroup.com/?l=linux-kernel&m=110754432622498&w=2
>> >
>> > One and a half years.
>> >
>> > Would the world end if we just merged the dang thing?
>>
>> Not the world perhaps, but I'm unwilling to concede that if a driver
>> author is given a list of major issues and does nothing, then the driver
>> should go in after everyone gets impatient.
>>
>> The rules for inclusion are elastic and include broad leeway for good
>> behaviour, but this would stretch the elasticity way beyond breaking
>> point.
>>
>> The list of issues is here:
>>
>> http://marc.theaimsgroup.com/?l=linux-scsi&m=114556263632510
>
> I'm under the impression that Erich is under the impression that they've 
> all
> been addressed.
>
>> Most of the serious stuff is fixed with the exception of:
>>
>> - sysfs has more than one value per file
>> - BE platform support
>> - PAE (cast of dma_addr_t to unsigned long) issues.
>> - SYNCHRONIZE_CACHE is ignored.  This is wrong.  The sync cache in the
>> shutdown notifier isn't sufficient.
>
> So this is progress.
>
> Erich, can you please fix these things up and then re-review the issues
> list which I'm maintaining in
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm2/broken-out/areca-raid-linux-scsi-driver.patch,
> make sure that everything has been addressed?
>
> If there are some things in those lists which you cannot/will not address
> then please identify them and give us the reasoning behind your decision.
> 

------=_NextPart_000_000F_01C6A1E4.409E7620
Content-Type: application/x-compressed;
	name="areca-raid-linux-scsi-driver-update7.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="areca-raid-linux-scsi-driver-update7.patch.gz"

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

------=_NextPart_000_000F_01C6A1E4.409E7620--

