Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbTD3L6P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 07:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262146AbTD3L6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 07:58:15 -0400
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:44038 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id S262145AbTD3L6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 07:58:13 -0400
Message-Id: <200304301201.h3UC19u23911@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Bug in linux kernel when playing DVDs.
Date: Wed, 30 Apr 2003 15:08:39 +0300
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <3EABB532.5000101@superbug.demon.co.uk> <200304290538.h3T5cLu16097@Port.imtp.ilyichevsk.odessa.ua> <3EAE5DF5.1040209@superbug.demon.co.uk>
In-Reply-To: <3EAE5DF5.1040209@superbug.demon.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 April 2003 14:11, James Courtier-Dutton wrote:
> >See? Sector # is increasing... Linux retries the read several times,
> >then reports EIO to userspace and goes to next sectors.
> > Unfortunately, they are bad too, so the loop repeats. Eventually it
> > will pass by all bad sectors (if not, it's a bug) but it can take
> > longish time.
> >
> >Apart of making max retry # settable by the user, I don't see how
> >this can be made better. Pity. This is common problem on CDs...
>
> What is this EIO report. The CPU is never returned to user space
> apps, so the app never sees any error.

Are you sure that CPU never returned to the app?
(strace is your friend...)

> As for retries, for DVD playing we do not want the Linux kernel to do
> any retries, because during DVD playback, we just want a very quick
> response saying there was an error.

Kernel is not yet telepathic.

> The DVD playing application can
> then skip forward 0.5 seconds and continue. If one sector fails on a
> DVD, there is little or not point in reading the next sector. One has
> to start reading from the next VOBU. (i.e. about 0.5 seconds skip.)

You need a way to tell kernel that you want such behavior.
"skip 0.5 sec on error" requirement is rather hard
to describe to the kernel.
--
vda
