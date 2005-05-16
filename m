Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261797AbVEPSjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbVEPSjq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 14:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbVEPSjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 14:39:46 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:45023 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261797AbVEPShN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 14:37:13 -0400
In-Reply-To: <E1DWqbP-0005G2-00@dorka.pomaz.szeredi.hu>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: bulb@ucw.cz, ericvh@gmail.com, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       smfrench@austin.rr.com
MIME-Version: 1.0
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OFF8F363D7.8F085A59-ON88257003.0065014C-88257003.006629FE@us.ibm.com>
From: Bryan Henderson <hbryan@us.ibm.com>
Date: Mon, 16 May 2005 11:35:22 -0700
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Build V70_04122005|April 12, 2005) at
 05/16/2005 14:37:06,
	Serialize complete at 05/16/2005 14:37:06
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I'm constantly getting lost in the maze of rules, on what exactly
>happens on setuid() etc, but I know that setuid() resets the
>capabilities as well.  What's the way of changing euid and suid back
>to ruid, and yet keeping some capabilities?

Plus, they keep changing as we try to strike the perfect balance between 
logical, flexible architecture and compatibility with other kernels.

That setuid() to nonzero removes all capabilities in addition to its 
essential function is a special case to ensure that old programs that mean 
to drop privileges by setting uid nonzero still do so.  Because it's an 
exception and not architecture, no other part of the kernel should rely on 
that for correctness.

As a practical matter, a process can use a prctl(SET_KEEPCAPS) system call 
to indicate that it's aware that uids and capabilities have nothing to do 
with each other, and thus a setuid() by that process doesn't do the 
special case.

Note that another way a process can end up with capabilities but euid 
nonzero is that another process did a capset() system call on it.

--
Bryan Henderson                          IBM Almaden Research Center
San Jose CA                              Filesystems

