Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261620AbVCNQ7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbVCNQ7z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 11:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbVCNQ7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 11:59:55 -0500
Received: from alog0162.analogic.com ([208.224.220.177]:62373 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261620AbVCNQ7x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 11:59:53 -0500
Date: Mon, 14 Mar 2005 11:57:40 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Evgeniy <shubin_evgeniy@mail.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: bug in kernel
In-Reply-To: <200503141748.05661.shubin_evgeniy@mail.ru>
Message-ID: <Pine.LNX.4.61.0503141150300.19270@chaos.analogic.com>
References: <200503141748.05661.shubin_evgeniy@mail.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2005, Evgeniy wrote:

> Here is a simple program.
>
> #include <stdio.h>
> #include <errno.h>
> main(){
>  int err;
>  err=read(0,NULL,6);
>  printf("%d %d\n",err,errno);
> }
>
> I think that it should be an error : Null pointer assignment, like in windows.
> But in practise it is not so.

It is an error. It will wait <forever> until you enter the [Enter]
key (it's reading from STDIN_FILENO). Then it will return -1 which
means there was an error, the error code in errno is 14 (EFAULT)
or "bad address".

You can configure user-mode code to "seg-fault" upon receiving
such an error. It can print a nasty message and leave a worthless
core file in your directory.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
