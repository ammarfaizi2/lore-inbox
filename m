Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277338AbRJVAK2>; Sun, 21 Oct 2001 20:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277341AbRJVAKT>; Sun, 21 Oct 2001 20:10:19 -0400
Received: from adsl-204-0-249-112.corp.se.verio.net ([204.0.249.112]:21239
	"EHLO tabby.cats-chateau.net") by vger.kernel.org with ESMTP
	id <S277333AbRJVAKC>; Sun, 21 Oct 2001 20:10:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
Reply-To: jesse@cats-chateau.net
To: Tim Jansen <tim@tjansen.de>, James Simmons <jsimmons@transvirtual.com>
Subject: Re: The new X-Kernel !
Date: Sun, 21 Oct 2001 19:10:32 -0500
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10110211025130.13079-100000@transvirtual.com> <15vO3W-0DSqTwC@fmrl00.sul.t-online.com>
In-Reply-To: <15vO3W-0DSqTwC@fmrl00.sul.t-online.com>
MIME-Version: 1.0
Message-Id: <01102119103200.19723@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 October 2001 14:17, Tim Jansen wrote:
> On Sunday 21 October 2001 19:40, James Simmons wrote:
> > It sets the hardware state of the keyboards and the
> > mice. The user runs apps that alter the state. The second user comes
> > along and log in on desktop two. He runs another small application to
> > test the mice. It changes the state which in turn effects the person on
> > desktop one.
>
> Isn't this a driver problem? If two processes can interfere when using the
> same device the driver should only allow one access (one device file
> opened) at a time. And if two processes need to access it it should be
> managed by a daemon.

Neither - It is a resource allocation problem, which all UNIX style systems
seem to lack. And second, it doesn't happen at the present time with 
mice/keyboard/display unless somebody (root) did not configure the system 
properly (as in leave the device inodes accessable to world) OR change the
protection to permit access.

Once a resource is allocated to a user session (not process) it should not be 
accessable to other users.

Linux doesn't have a resource allocation other than the limited single open
support for character device drivers. This is usually sufficient for 
keyboard/mouse/display since it is the X server that is opening the device.

It is NOT sufficient for things like tape drives. The only way to prevent
conflict at the present time is to change the ownership of the inode, and 
ensure that the protection mask only permits user access. It is ALSO 
necessary to ensure that no other processes have that device open at the same 
time.

How those devices are controled/configured/used after allocation is and 
should remain a user mode function, NOT a kernel function.
