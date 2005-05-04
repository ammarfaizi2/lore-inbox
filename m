Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261826AbVEDNtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbVEDNtx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 09:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261833AbVEDNtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 09:49:53 -0400
Received: from alog0497.analogic.com ([208.224.223.34]:22241 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261826AbVEDNtt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 09:49:49 -0400
Date: Wed, 4 May 2005 09:49:37 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Jakub Jelinek <jakub@redhat.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: System call v.s. errno
In-Reply-To: <20050504134224.GE17420@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.61.0505040948450.8903@chaos.analogic.com>
References: <Pine.LNX.4.61.0505040849150.8743@chaos.analogic.com>
 <20050504134224.GE17420@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 May 2005, Jakub Jelinek wrote:

> On Wed, May 04, 2005 at 09:22:09AM -0400, Richard B. Johnson wrote:
>> Does anybody know for sure if global 'errno' is supposed to
>> be altered after a successful system call? I'm trying to
>> track down a problem where system calls return with EINTR
>> even though all signal handlers are set with SA_RESTART in
>> the flags. It appears as though there may be a race somewhere
>> because if I directly set errno to 0x1234, within a few
>> hundred system calls, it gets set to EINTR even though all
>> system calls seemed to return 'good'. This makes it
>> hard to trace down the real problem.
>
> http://www.opengroup.org/onlinepubs/009695399/functions/errno.html
> is very clear on this.  Unless indicated that errno is valid after a call
> (for many syscalls it is valid when the syscall returns -1), errno has
> unspecified value.
>
> 	Jakub
> -

Okay, thanks. That means that it's okay for it to get trashed
NotGood(tm) for debugging.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
