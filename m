Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965263AbWADSm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965263AbWADSm2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 13:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965264AbWADSm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 13:42:28 -0500
Received: from terminus.zytor.com ([192.83.249.54]:45533 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S965263AbWADSm1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 13:42:27 -0500
Message-ID: <43BC16EF.50107@zytor.com>
Date: Wed, 04 Jan 2006 10:41:51 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ulrich Drepper <drepper@redhat.com>
CC: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>,
       "Viro, Al" <viro@ftp.linux.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Limit sendfile() to 2^31-PAGE_CACHE_SIZE bytes without
 error
References: <43BB348F.3070108@zytor.com> <200601040451.20411.ak@suse.de> <Pine.LNX.4.64.0601032051300.3668@g5.osdl.org> <43BB5646.2040504@zytor.com> <43BB5E22.2010306@zytor.com> <Pine.LNX.4.64.0601040900311.3668@g5.osdl.org> <43BC030A.1060208@redhat.com>
In-Reply-To: <43BC030A.1060208@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> Linus Torvalds wrote:
> 
>>Ok, this patch looks ok, if it's confirmed to unbreak apache.
> 
> Yes, sounds reasonable.  But I don't think that, as Peter suggested in
> another mail, that glibc should automatically wrap the syscall to
> provide support for  larger sizes.  The caller probably should know when
> a transfer was cut short.
> 

Agreed; that's exactly what a short return in supposed to do.  Since a 
short return is compatible with the defined API, that's not a problem.

However, this patch only addresses sendfile(), and this is apparently a 
much more pervasive problem.  We need something similar for all the I/O 
system calls that are affected by this particular issue.

	-hpa
