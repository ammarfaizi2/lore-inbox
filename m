Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264583AbUBIB5M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 20:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264608AbUBIB5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 20:57:12 -0500
Received: from linuxhacker.ru ([217.76.32.60]:57752 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S264583AbUBIB5J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 20:57:09 -0500
Date: Mon, 9 Feb 2004 03:56:59 +0200
From: Oleg Drokin <green@linuxhacker.ru>
To: James Bromberger <james@rcpt.to>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23 && md raid1 && reiserfs panic
Message-ID: <20040209015659.GC1978@linuxhacker.ru>
References: <20040207112302.GA2401@phobe.internal.pelicanmanufacturing.com.au> <200402081722.i18HMBFT074505@car.linuxhacker.ru> <20040209011040.GB27378@phobe.internal.pelicanmanufacturing.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040209011040.GB27378@phobe.internal.pelicanmanufacturing.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Feb 09, 2004 at 09:10:40AM +0800, James Bromberger wrote:
> > JB> The symptoms: rm a file from a working RAID1 md reiserfs filesystem, 
> > JB> and I get a panic, rm(1) segfaults, and all further I/O to any interactive 
> > JB> shells stop. The entire system is rednered incapable; reboot (via 
> > JB> ctrl-alt-del) doesnt shutdown and the only action is to hard reset the box.
> > 
> > What if you run reiserfsck over the volume that seems to be corrupted,
> > then fix the errors and then retry the operation?
> Yes! That was it. Attached is the output I captured from reiserfsck. 
> It identified the very file I was attempting to remove that was causing
> the segfault in rm(1).
> So I guess this is a reiserfs specific issue when it kills all disk I/O
> when this correcption happens. Hmm.

Yes, in-kernel reiserfs is not all that good when it comes to corrupted
filesystems yet. The source of this corruption is yet unknown, though.

You can fix the corruption with reiserfsck --fix-fixable, or
reiserfsck --rebuild-tree if first one does not work.
Be sure to use latest reiserfsprogs.

Bye,
    Oleg
