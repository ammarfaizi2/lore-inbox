Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277371AbRJVAew>; Sun, 21 Oct 2001 20:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277366AbRJVAen>; Sun, 21 Oct 2001 20:34:43 -0400
Received: from mailout00.sul.t-online.com ([194.25.134.16]:41411 "EHLO
	mailout00.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S277373AbRJVAe2>; Sun, 21 Oct 2001 20:34:28 -0400
Content-Type: text/plain; charset=US-ASCII
From: Tim Jansen <tim@tjansen.de>
To: jesse@cats-chateau.net
Subject: Re: The new X-Kernel !
Date: Mon, 22 Oct 2001 02:37:38 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.LNX.4.10.10110211025130.13079-100000@transvirtual.com> <15vO3W-0DSqTwC@fmrl00.sul.t-online.com> <01102119103200.19723@tabby>
In-Reply-To: <01102119103200.19723@tabby>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <15vT3P-28eRloC@fmrl04.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 October 2001 02:10, you wrote:
> Neither - It is a resource allocation problem, which all UNIX style systems
> seem to lack. And second, it doesn't happen at the present time with
> mice/keyboard/display unless somebody (root) did not configure the system
> properly (as in leave the device inodes accessable to world) OR change the
> protection to permit access.
> Once a resource is allocated to a user session (not process) it should not
> be accessable to other users.

But what's the point of doing it in the kernel instead of the user space? 
Basically X11 is nothing but a library for accessing mice/keyboard/display 
plus some daemon that manages these resource and introduces some policies 
(for example each process gets one or more windows it can draw in). And 
especially the display clearly needs some policy enforced to be useful for 
several processes.


> It is NOT sufficient for things like tape drives. The only way to prevent
> conflict at the present time is to change the ownership of the inode, and
> ensure that the protection mask only permits user access. It is ALSO
> necessary to ensure that no other processes have that device open at the
> same time.

Why should several process be allowed to access a tape drive? Raw access, 
like the kernel driver will provide, that allows things like fast-forward 
must be coordinated, at least. You need a higher level interface that 
coordinates things among processes. 

I do agree that the neccessary IPC for the communication between such a 
higher-level driver and the processes that use it is a problem though. That's 
why I like FUSD (http://www.circlemud.org/~jelson/software/fusd/), it gives 
you the ability to create higher-level drivers in user-space that behave like 
kernel drivers. (And, BTW, makes fun stuff possible like accessing 
device files on other computers over the network, without rewriting 
applications)

bye...
