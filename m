Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbVBVSaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbVBVSaq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 13:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVBVSap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 13:30:45 -0500
Received: from users.ccur.com ([208.248.32.211]:11569 "EHLO flmx.iccur.com")
	by vger.kernel.org with ESMTP id S261274AbVBVSaj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 13:30:39 -0500
Subject: Re: idr_remove
From: Jim Houston <jim.houston@ccur.com>
To: russell@coker.com.au
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200502192332.54815.russell@coker.com.au>
References: <200502192332.54815.russell@coker.com.au>
Content-Type: text/plain
Organization: Concurrent Computer Corp.
Message-Id: <1109096566.1010.53.camel@new.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 22 Feb 2005 13:22:46 -0500
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Feb 2005 18:30:39.0404 (UTC) FILETIME=[9BCB96C0:01C5190C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-02-19 at 07:32, Russell Coker wrote:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109838483518162&w=2
> 
> I am getting messages "idr_remove called for id=0 which is not allocated" when 
> SE Linux denies search access to /dev/pts.
> 
> The attached file has some klogd output showing the situation, triggered in 
> this case by installing a new kernel package on a SE Debian system.  The 
> above URL references Jim Houston's message with the patch to add this 
> warning.

Hi Russell, Everyone,

I believe that the warning is correct.  It is intended to catch
the case where an id is freed without being allocated.  The most
likely case is the teardown of the pty is calling idr_remove()
twice for the same id value.  The other possible case is that
an id has not been allocated and idr_remove() is being called
by mistake.  

I spent time looking at the pty and selinux code yesterday.
I had little luck finding where the selinux code hooks into 
the pty code.

I have not used selinux.  I have a recent Fedora FC3 install but I
didn't enable selinux.  If you can give me cookbook directions,
I will try to reproduce the problem here.

I was hoping that changing the file permissions on /dev/pts might
produce the same effect.  It prevent xterm from opening the pty but
it didn't cause the idr_remove() warning.

Jim Houston - Concurrent Computer Corp.

