Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275381AbRJBQQk>; Tue, 2 Oct 2001 12:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275576AbRJBQQa>; Tue, 2 Oct 2001 12:16:30 -0400
Received: from gap.cco.caltech.edu ([131.215.139.43]:7618 "EHLO
	gap.cco.caltech.edu") by vger.kernel.org with ESMTP
	id <S275389AbRJBQQV>; Tue, 2 Oct 2001 12:16:21 -0400
Date: Tue, 2 Oct 2001 11:49:20 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Dinesh Gandhewar <dinesh_gandhewar@rediffmail.com>
cc: mlist-linux-kernel@NNTP-SERVER.CALTECH.EDU
Subject: Re: your mail
In-Reply-To: <20011002152945.15180.qmail@mailweb16.rediffmail.com>
Message-ID: <Pine.LNX.3.95.1011002113741.8413A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 Oct 2001, Dinesh  Gandhewar wrote:

> 
> Hello,
> I have written a linux kernel module. The linux version is 2.2.14. 
> In this module I have declared an array of size 2048. If I use this
> array, the execution of this module function causes kernel to reboot.
> If I kmalloc() this array then execution of this module function
> doesnot cause any problem.
> Can you explain this behaviour?
> Thnaks,
> Dinesh 

I would check that you are not accidentally exceeding the bounds of
your array. Actual allocation occurs in page-size chunks. You may
be exceeding your 2048 byte-limit without exceeding the 4096-byte
page-size (of ix86).

However, a global array, or an array on the stack, has very strict
limits. You can blow things up on the stack by exceeding an array
boundary by one byte. And you can overwrite important memory objects
by exceeding the bounds of a global memory object.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


