Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbVLHPhq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbVLHPhq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 10:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbVLHPhq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 10:37:46 -0500
Received: from nproxy.gmail.com ([64.233.182.195]:6242 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932170AbVLHPhp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 10:37:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=HCFnmgqZFBMPwaNs+3P/XvFtDDWcouplwd12wo6V+dpPEI/Ut1MRW4rAJvpQEfChfLt9+hCdkOTRVnrLKLzpfh7Wg1nhIFJhUcAou25SByR82ZjuObk4K23A1wpLrVf4l2d8NeBbK6AEKSiGu0cDUo+YSktli32WMmxx3scRf90=
Message-ID: <6278d2220512080737t30a83011k11e88e85c0974a11@mail.gmail.com>
Date: Thu, 8 Dec 2005 15:37:43 +0000
From: Daniel J Blueman <daniel.blueman@gmail.com>
To: tripperda@nvidia.com
Subject: Re: PAT status?
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, ak@suse.de, jgarzik@pobox.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terence Ripperda wrote:
> Hi Jeff,
>
> I unfortunately haven't had much time to look at the status of the PAT
> code I had been working on. there are really 2 steps to the code:
>
> the first is enabling and configuring the PAT registers. this then
> allows a page table entry define that can be passed to traditional
> interfaces, such as remap_page_range or change_page_attr. this is
> pretty simple and we've been using a similar interface in our driver
> for some time now.
>
> the second part was to make sure we didn't create any cache aliasing
> via duplicate mappings. this part is a bit more involved and what was
> holding everything back. I've been meaning to get back to looking at
> this, but really haven't had the time.

If you mean aliasing by the way of having MTRR entries conflicting
with PAT page flags, then is this better dealt with by in-kernel
drivers being changed to use PAT rather than the MTRR interface? One
day, the kernel MTRR interface will be deprecated and unusable
(modules could still program the MTRRs as PAT is done today in a
number of drivers).

> I don't know if you still want to limit the additional of the first
> step, based on completion of the second step. I can try to set time
> aside over the next month to try and sync up and take a look at where
> we stand w/ the cachemap portion of the code. I think there where
> still issues with gathering/passing in the correct attributes.
>
> Thanks,
> Terence

Presumably, the aliasing will only bite where eg the X server sets up
MTRRs and PAT is used for the region also. For x86_64 and IA32, the
Intel IA32 system guides tell us that strong store ordering (ie
write-through) takes precendence over weaker store ordering (eg
write-combining), so we should be safe. For processors with known
errata with PAT etc, we can disable PAT support.

Would it be useful to get a rough patch covering point #1 onto LKML
for discussion?
___
Daniel J Blueman
