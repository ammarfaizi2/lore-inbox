Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278275AbRKNW0P>; Wed, 14 Nov 2001 17:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278358AbRKNW0F>; Wed, 14 Nov 2001 17:26:05 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:11025 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S278275AbRKNWZt>;
	Wed, 14 Nov 2001 17:25:49 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Thomas Dodd <ted@cypress.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Modutils can't handle long kernel names 
In-Reply-To: Your message of "Wed, 14 Nov 2001 16:04:38 MDT."
             <3BF2EA76.6010702@cypress.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 15 Nov 2001 09:25:39 +1100
Message-ID: <28111.1005776739@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Nov 2001 16:04:38 -0600, 
Thomas Dodd <ted@cypress.com> wrote:
>Keith Owens wrote:
>> +uts_len		:= 64
>> +uts_truncate	:= sed -e 's/\(.\{1,$(uts_len)\}\).*/\1/'
>
>Should this be a fixed length of 64?
>Or should it be grabbed form a header somewhere?
>So when/if SYS_NMLN/_UTSNAME_LENGTH is changed
>longer strings can be used? I check and Solaris 8
>defines SYS_NMLN as 257.
>
>Would this break cross-comiling badly?
>Are other libc headers needed in the build?

This is the kernel's idea of uts length, not glibc, it is independent
of where you are compiling.  It could be extracted from the kernel
header,
  uts_len := $(shell sed -ne 's/#define __NEW_UTS_LEN //p' include/linux/utsname.h)
but why bother?  The value has been fixed at 64 since at least 2.0 and
is embedded in glibc so it is unlikely to change.  Even if it does
change, it must be upwards so the worst case is fail safe.

