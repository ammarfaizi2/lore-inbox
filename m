Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbTKTTo3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 14:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbTKTTo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 14:44:29 -0500
Received: from tench.street-vision.com ([212.18.235.100]:55690 "EHLO
	tench.street-vision.com") by vger.kernel.org with ESMTP
	id S261780AbTKTTo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 14:44:27 -0500
Subject: Re: OT: why no file copy() libc/syscall ??
From: Justin Cormack <justin@street-vision.com>
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <03112013081700.27566@tabby>
References: <1068512710.722.161.camel@cube> <03111209360001.11900@tabby>
	<20031120172143.GA7390@deneb.enyo.de>  <03112013081700.27566@tabby>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 20 Nov 2003 19:44:13 +0000
Message-Id: <1069357453.26642.93.camel@lotte.street-vision.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-11-20 at 19:08, Jesse Pollard wrote:
> Now if you wanted the remote server to deny the network copy... could
> be done - after all the credentials for both input and output files
> are present on the server. If the server decides NOT to copy, then fine.
> It would just cause the user to make the copy with a read/write loop.
> 
> I was only thinking of it as a way to gain access to any filesystem
> support that may be available for copying files. If none is available,
> then do it in user mode.
> 
> Personally, I'm not sure it is a good idea, partly because the semantics
> of a file copy operation are not well defined (some of the following IS 
> known).
> 
> 1. what happens if the copy is aborted?
> 2. what happens if the network drops while the remote server continues?
> 3. what about buffer synchronization?
> 4. what errors should be reported ?
> 5. what happens when the syscall is interupted? Especially if the remote
>    copy may take a while (I've seen some require an hour or more - worst
>    case: days due to a media error (completed after the disk was replaced)).
> 6. what about a client opening the copy before it is finished copying?

If you really want a filesystem that supports efficient copying you
probably want it to have the equivalent of COW blocks, so that a copy
just sets up a few pointers, and the copy only happens when the original
or copied files are changed.

But basically you wont get a syscall until you have a filesystem with
semantics that only maps onto this sort of operation.

Justin


