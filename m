Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbTKQJza (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 04:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263460AbTKQJza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 04:55:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29408 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263448AbTKQJz3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 04:55:29 -0500
Date: Mon, 17 Nov 2003 09:55:28 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: seq_file and exporting dynamically allocated data
Message-ID: <20031117095528.GV24159@parcelfarce.linux.theplanet.co.uk>
References: <20031117090339.GC22764@holomorphy.com> <Pine.LNX.4.44.0311170937550.748-100000@einstein.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311170937550.748-100000@einstein.homenet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 17, 2003 at 09:42:09AM +0000, Tigran Aivazian wrote:
> Here are two files: simple.c kernel module and user.c user test program.  
> If you (or anyone) believe it is possible to return more than a single
> page on a read(2) please change them accordingly and let me know.

> 	while (1) {
> 		len = read(fd, procs, MAXPROCS*PROCLEN);
> 		nproc = len/PROCLEN;

Broken userland code.  You expect read() to return a multiple of PROCLEN,
for one thing.  For another, you have (several lines below) a broken
loop termination logics.

EOF had been reached when read() returns 0.  Until then read() returns
an arbitrary amount of bytes between 1 and 'size' argument.  Since you
are using read(2) directly, use it correctly...
