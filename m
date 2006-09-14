Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751304AbWINEGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbWINEGI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 00:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWINEGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 00:06:08 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:35859 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751304AbWINEGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 00:06:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=uh4ALHvL1O423FwxSh4lwzRpRliNN7eW/kgcJCKsFFtG3HY9Gy8uDBosfFtI9Ul31tPOg6Rqs32KaCkLxielQLWFHm4iqk/Cubcgv9zVVabt6qxB9slI5EHAdcakMrinMRFOk3kFpHaWfGQN1cbYCJoGni2vMyFfuuqByO3qovI=
Message-ID: <787b0d920609132106p492cc990na471484d7dee8afb@mail.gmail.com>
Date: Thu, 14 Sep 2006 00:06:04 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: torvalds@osdl.org, jeremy@goop.org, mingo@elte.hu, ak@suse.de,
       ebiederm@xmission.com, arjan@infradead.org, zach@vmware.com,
       linux-kernel@vger.kernel.org
Subject: Re: Assignment of GDT entries
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge writes:
> Zachary Amsden wrote:

>> I believe 9,10,11 are reserved for future users like yourself or
>> expanded TLS segments.  I think a bank of 3 TLS segments in the
>> GDT is working fine now (does NPTL even use more than one?).
>
> Nope.  And there's a comment that wine uses one more.  I think
> the third is completely unused.

I use the third. The sucky thing is that I need to determine if
the kernel is 64-bit to know what I must load into the segment
register. Fortunately this code is not yet out in the wild, so
you can still fix the ABI situation for me at least.

>>> Otherwise line 1 would be ideal for putting 3 TLS, kernel+user
>>> code+data and PDA into, thereby making 99.999% of GDT descriptor
>>> uses come from one cache line.
>>
>> That change is visible to userspace, unfortunately.
>
> Don't think it matters much.  32-bit processes on x86-64 seem
> perfectly happy with the TLS being in a different place.

Heh. I wish. Well, OK, but only because I detect the kernel!

> I think the ABI is defined in terms of "use the selector for
> the entry that set_thread_area/clone returns", and so is not
> a constant.  But I agree it would be better not to.
>
> Hm, moving user cs/ds would be pretty visible too... Hm, and
> it would have a greater chance of breaking stuff if they changed,
> compared to moving the TLS...

I think that would be a lower chance, not a greater chance.
Reasons why an app might care:

a. identify a 64-bit kernel
b. far jumps between 32-bit and 64-bit code
c. reload of ds/es after a string operation on thread-private data

Perhaps i386 should change to match x86_64.
