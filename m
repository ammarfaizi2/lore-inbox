Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130577AbRC0GiM>; Tue, 27 Mar 2001 01:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130565AbRC0GiC>; Tue, 27 Mar 2001 01:38:02 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:13843 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S130577AbRC0Ghp>;
	Tue, 27 Mar 2001 01:37:45 -0500
Date: Tue, 27 Mar 2001 08:36:54 +0200
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: Amit D Chaudhary <amit@muppetlabs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: question \ information request on init \ boot sequence when using initrd
Message-ID: <20010327083654.E18314@almesberger.net>
In-Reply-To: <3ABFFDCD.3000803@muppetlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ABFFDCD.3000803@muppetlabs.com>; from amit@muppetlabs.com on Mon, Mar 26, 2001 at 06:41:17PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amit D Chaudhary wrote:
> To put it in brief, since running sbin/init from /linuxrc as resulting 
> in init not having PID 1 and thereby not doing some initialization as 
> expected.

Easy solution: don't run linuxrc, run something else instead. E.g.
putting the following into the kernel's command line should do th
trick:
init=/your_script root=/dev/ram

(With your_script being the original version, without real-root-dev)

> Thereby instead of loading running /sbin/init, we just set 
> /proc/sys/kernel/real-root-dev to /dev/ram0's value which then does the 

Anything involving real-root-dev is likely to be an anachronism.
Combining it with pivot_root just makes it more weird.

> Is this ok or should be modify /sbin/init to run properly inspite of PID 
> <> 1 or is there a 3rd way of doing this?

I'd consider the "PID of init must be 1" a bit of an anachronism too.
After all, a modern Unix system has quite a few demons that you don't
want to kill either, so why make init special ? But anyway, you don't
need to change init.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
