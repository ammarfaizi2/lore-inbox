Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263389AbTKQIiQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 03:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263396AbTKQIiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 03:38:16 -0500
Received: from userel174.dsl.pipex.com ([62.188.199.174]:37509 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id S263389AbTKQIiO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 03:38:14 -0500
Date: Mon, 17 Nov 2003 08:38:24 +0000 (GMT)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: tigran@einstein.homenet
To: William Lee Irwin III <wli@holomorphy.com>
cc: viro@parcelfarce.linux.theplanet.co.uk, <linux-kernel@vger.kernel.org>
Subject: Re: seq_file and exporting dynamically allocated data
In-Reply-To: <20031117083007.GA22764@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0311170832030.1089-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Nov 2003, William Lee Irwin III wrote:

> On Mon, Nov 17, 2003 at 08:21:34AM +0000, Tigran Aivazian wrote:
> > Now, since there is no way to detect EOF, other than by reading an extra 
> > page and discovering that it belongs to the next iteration, we have to do 
> > the lseek(fd, 0, SEEK_SET) anyway.
> > So, the "auto-rewinding" read would only help the cases where application 
> > doesn't need to differentiate between samples and is happy to just 
> > continuously read chunks packed into pages one by one as fast as 
> > possible. In this case it doesn't need to lseek to 0, so auto-rewinding on 
> > kernel side would prevent it from slowing down.
> 
> If you're going to repeatedly read from 0 pread() sounds like a good
> alternative to read() + lseek(), plus no kernel changes required to
> get rid of the lseek().

The reason why I didn't use pread(2) is because I have to do multiple
calls to read(2). There is no way that I know of to pack more than a
single page into a single read(2) with seq_file API.

Yes, I remember Al saying "it's not a page" but in practice it still
appears to be limited to a page unless someone shows a sample seq_file
module which can provide more than a page of data on a single read(2). The
implementations I have looked at in the kernel (e.g. mm/slab.c) are
limited to a single page per read(2).

Kind regards
Tigran

