Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269284AbUJFPK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269284AbUJFPK1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 11:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269288AbUJFPK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 11:10:27 -0400
Received: from chaos.analogic.com ([204.178.40.224]:5760 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S269284AbUJFPKT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 11:10:19 -0400
Date: Wed, 6 Oct 2004 11:09:50 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Joris van Rantwijk <joris@eljakim.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
In-Reply-To: <Pine.LNX.4.58.0410061616420.22221@eljakim.netsystem.nl>
Message-ID: <Pine.LNX.4.61.0410061059310.6661@chaos.analogic.com>
References: <Pine.LNX.4.58.0410061616420.22221@eljakim.netsystem.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Oct 2004, Joris van Rantwijk wrote:

> Hello,
>
> I have a problem where the sequence of events is as follows:
> - application does select() on a UDP socket descriptor
> - select returns success with descriptor ready for reading
> - application does recvfrom() on this descriptor and this recvfrom()
>   blocks forever
>
> My understanding of POSIX is limited, but it seems to me that a read call
> must never block after select just said that it's ok to read from the
> descriptor. So any such behaviour would be a kernel bug.
>

Can you check to see if you have an exception at the same time?
Also, please make sure that the first parameter to select() is
the file-descriptor value + 1.  There are things like out-of-band
data that could show up ( MSG_OOB ) under select(). Also, recvfom()
takes a lot of parameters that need to be correct. There is a buffer
length plus a pointer to a socklen_t variable. I've seen people
mess these up and have everything "work" except sometimes...

Cheers,
Dick Johnson
Penguin : Linux version 2.6.5-1.358-noreg on an i686 machine (5537.79 BogoMips).
             Note 96.31% of all statistics are fiction.

