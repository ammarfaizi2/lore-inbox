Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266294AbUANEqn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 23:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266293AbUANEqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 23:46:42 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:10112 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S266309AbUANEqe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 23:46:34 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 13 Jan 2004 20:46:23 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Jeff Dike <jdike@addtoit.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] /dev/anon
In-Reply-To: <20040114014209.GA4301@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.44.0401131817121.12810-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jan 2004, Jeff Dike wrote:

> On Tue, Jan 13, 2004 at 12:38:05PM -0800, Davide Libenzi wrote:
> > Now I'm going to say something really stupid, but why sys_madvise(MADV_DONTNEED)
> > won't work for this?
> > 
> 
> MADV_DONTNEED is fine for anonymous memory, but it can't make a filesystem
> throw out data, which is what I need.  If it did, then people wouldn't be
> agitating for sys_punch.

What do you mean for throw out data? If you mean writing DONTNEED'ed 
dirty pages to the backed up file and release them to the page cache, it 
does. If you mean stop handling page faults inside the DONTNEED'ed region, 
it does not. If you mean zero-filling (ala ftruncate()) the DONTNEED'ed 
region, it obviously does not. I thought your goal was to release memory 
to the host, that's why I proposed sys_madvise(MADV_DONTNEED).



- Davide




