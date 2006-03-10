Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbWCJDWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbWCJDWu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 22:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbWCJDWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 22:22:50 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:36587 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932121AbWCJDWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 22:22:50 -0500
Subject: Re: How can I link the kernel with libgcc ?
From: Lee Revell <rlrevell@joe-job.com>
To: Carlos Munoz <carlos@kenati.com>
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org,
       alsa-devel <alsa-devel@lists.sourceforge.net>
In-Reply-To: <4410EC0D.3090303@kenati.com>
References: <4410D9F0.6010707@kenati.com>
	 <200603100145.k2A1jMem005323@turing-police.cc.vt.edu>
	 <1141956362.13319.105.camel@mindpipe>  <4410EC0D.3090303@kenati.com>
Content-Type: text/plain
Date: Thu, 09 Mar 2006 22:22:41 -0500
Message-Id: <1141960963.13319.116.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(added alsa-devel to cc:)

On Thu, 2006-03-09 at 19:01 -0800, Carlos Munoz wrote:
> >Audio drivers should never have to directly manipulate the samples -
> >they just manage the DMA buffers and interrupts and wake up the process
> >at the right time.  Mixing, routing, volume control, DSP go in
> >userspace.
>
> Unfortunately, the driver needs to populate several coefficient tables 
> for the hardware to perform silence suppression and other advance 
> features. The values for these tables are calculated using log10 
> operations. I don't  see a clean way to push these operations to user 
> space without the need for custom applications that build the tables and 
> pass them to the driver.

Unless you can do it with fixed point math, or use a static table, you
might have to do just that, with a sysfs interface.  For example the
emu10k1 driver uses an ioctl interface to upload code to the built in
(floating point) DSP.  But new ioctls are frowned upon...

Lee

