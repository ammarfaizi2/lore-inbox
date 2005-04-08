Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262856AbVDHPqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262856AbVDHPqh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 11:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262857AbVDHPqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 11:46:37 -0400
Received: from mailfe04.swip.net ([212.247.154.97]:23277 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262856AbVDHPqe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 11:46:34 -0400
X-T2-Posting-ID: dB8bZLHXm6KAmbp1mi7F+A==
Subject: Re: Timestamp of file modified through mmap are not changed in 2.6
From: Alexander Nyberg <alexn@dsv.su.se>
To: Xavier Roche <roche+kml2@exalead.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4256A06C.8020304@exalead.com>
References: <4256A06C.8020304@exalead.com>
Content-Type: text/plain
Date: Fri, 08 Apr 2005 17:46:28 +0200
Message-Id: <1112975188.16451.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Timestamp of file modified through mmap are not changed in 2.6 (even 
> after msync()). Observations on 2.4 and 2.6 kernels:
> - on 2.4, timestamps are altered a few seconds after the program exits.
> - on 2.6, timestamps are never altered.
> 
> Is this behaviour a normal behaviour ?
> 
> Program example to reproduce the bug (you need to create a "test" file 
> in the current directory first):

Yeah there's been at least one bug on bugzilla open for this, and I
recall the posix specification saying the times on files shall be
updated on mmap file changes (which makes sense too).

Doing it at msync is easy, keeping track of memory mapped data etc. is
more cumbersome. I sent a patch doing this a while ago (doesn't work now
due to msync rework, think it was the 4-level changes) that worked well
for me but nobody seemed to be be overwhelmed by it :-)

http://lkml.org/lkml/diff/2004/12/5/95/1

