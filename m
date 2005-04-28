Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262245AbVD1T6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262245AbVD1T6K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 15:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbVD1T6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 15:58:10 -0400
Received: from alog0137.analogic.com ([208.224.220.152]:5256 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262245AbVD1T6D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 15:58:03 -0400
Date: Thu, 28 Apr 2005 15:56:46 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: dtor_core@ameritech.net
cc: Chris Wright <chrisw@osdl.org>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, Jean Delvare <khali@linux-fr.org>
Subject: Re: [RFC/PATCH 0/5] read/write on attribute w/o show/store should
 return -ENOSYS
In-Reply-To: <d120d500050428105153ab13b1@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0504281551420.29750@chaos.analogic.com>
References: <200504280030.10214.dtor_core@ameritech.net> <20050428172659.GA18859@kroah.com>
 <20050428173744.GO23013@shell0.pdx.osdl.net> <d120d500050428105153ab13b1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Apr 2005, Dmitry Torokhov wrote:

> On 4/28/05, Chris Wright <chrisw@osdl.org> wrote:
>> * Greg KH (gregkh@suse.de) wrote:
>>> On Thu, Apr 28, 2005 at 12:30:09AM -0500, Dmitry Torokhov wrote:
>>>> Hi,
>>>>
>>>> Jean Delvare has noticed that if a driver happens to declare its
>>>> attribute as RW but doesn't provide store() method attempt to write
>>>> into such attribute will cause spinning process as most of the
>>>> attribute implementations return 0 in case of missing store causing
>>>> endless retries. In some cases missing show/store will return -EPERM,
>>>> -EACCESS or -EINVAL.
>>>>
>>>> I think we should unify implementations and have them all return -ENOSYS
>>>> (function not implemented) when corresponding method (show/store) is
>>>> missing.
>>>
>>> What is the POSIX standard for this?  ENOSYS or EACCESS?
>>
>> SuSv3 suggests EBADF, however we already do EINVAL at VFS for no write
>> op.  Although, returning 0 (i.e. wrote zero bytes) is still meaningful
>> too.
>>
>
> Returning 0 causes caller to immediately repeat operation causing the
> loop and 100% CPU utiluization as was reported. If ENOSYS is not
> acceptable (after all the problem is sysfs-specific, other fs-es
> either support write or they don't for entire volume) I'd say (looking
> at the descripptions) we should use ENXIO instead of EBADF:
>
> [ENXIO]
> A request was made of a nonexistent device, or the request was outside
> the capabilities of the device.
>
> [EBADF]
> The fildes argument is not a valid file descriptor open for writing.
>
> We have a valid FD and it was opened for wrinting, so EBADF is not
> really applicable. But then I may be talking complete gibberish...
>
> -- 
> Dmitry
> -

Perhaps...
ENOSPC, i.e., the device is full. This is the usual return value
for a CD/ROM and `df` always shows it's full even if it has
one small file.

The only thing that really makes sense is EPERM but it is usually
associated with permissions rather than if an operation is permitted.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
