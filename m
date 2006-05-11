Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbWEKXRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWEKXRI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 19:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWEKXRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 19:17:08 -0400
Received: from echo.digadd.de ([195.47.195.234]:37088 "EHLO mx2.digadd.de")
	by vger.kernel.org with ESMTP id S1750822AbWEKXRH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 19:17:07 -0400
Message-ID: <4463C5F4.6040805@digadd.de>
Date: Fri, 12 May 2006 01:17:08 +0200
From: Christian Schmidt <lkml@digadd.de>
User-Agent: Thunderbird 1.5.0.2 (X11/20060502)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: tsteinbr@igd.fraunhofer.de
Subject: Re: [dm-crypt] dm-crypt is broken and causes massive data corruption
References: <445F7DCC.2000508@igd.fraunhofer.de> <20060509190457.GL16180@agk.surrey.redhat.com> <e3vkeh$12h$1@news.cistron.nl>
In-Reply-To: <e3vkeh$12h$1@news.cistron.nl>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Slootman wrote:
> Alasdair G Kergon  <agk@redhat.com> wrote:
>> On Mon, May 08, 2006 at 07:20:12PM +0200, Tillmann Steinbrecher wrote:
>>> it's been many months that dm-crypt has been broken, and is known to 
>>> cause massive data corruption.
> 
>> So far there isn't much in the way of controlled experiments, but:
>>
>>  All the reports agree the problem is independent of filesystem.
>>
>>  One thread suggests only filesystem metadata is corrupted, not file
>>  data, and wonders if something's going wrong with (unsupported) write 
>>  barriers.
>>
>>  Another report said dm-crypt over raid5 failed while raid5 
>>  over dm-crypt worked.
> 
> A data point:
> 
> I'm running my /home on reiserfs3 over dm-crypt over lvm over raid5 for
> at least a year now, without any problems. Currently running 2.6.13.4
> (that's my "stable" work system...).

Just so you know,

I'm running dm-crypt on top of raid-5 as well. Kernels ranging from
gentoo's hardened 2.6.11 to 2.6.15.X with gentoo patchset on AMD64. The
raid is running since February 2005 with >1TB and survived a disk
failure with rebuild.
Cipher module was aes, now the asm-accelerated x86_64 version. The
filesystem is ext-3. Survived several hard lockups (damn cheap SATA
controllers hanging if a drive passes out), an LV/filesystem resize, and
feeding with GBytes of data in a row (at max ~30MByte/s to 2-3 files in
parallel).

Just re-checked the filesystem: no metadata information wrong. I
remember I checked the crc of several bigger archives when I had to
replace a drive two month ago, and couldn't find any problems then.

Best regards,
Christian
