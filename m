Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285062AbRLLC5y>; Tue, 11 Dec 2001 21:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285063AbRLLC5o>; Tue, 11 Dec 2001 21:57:44 -0500
Received: from ftoomsh.progsoc.uts.edu.au ([138.25.6.1]:16137 "EHLO ftoomsh")
	by vger.kernel.org with ESMTP id <S285062AbRLLC5b>;
	Tue, 11 Dec 2001 21:57:31 -0500
Date: Wed, 12 Dec 2001 13:57:13 +1100
From: Matt <matt@progsoc.uts.edu.au>
To: Andrew Morton <akpm@zip.com.au>
Cc: Berend De Schouwer <bds@jhb.ucs.co.za>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Kernel Oops on cat /proc/ioports
Message-ID: <20011212135713.M5809@ftoomsh.progsoc.uts.edu.au>
In-Reply-To: <1008073796.5535.5.camel@bds.ucs.co.za> <3C16ADB1.F9E847E9@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3C16ADB1.F9E847E9@zip.com.au>; from akpm@zip.com.au on Tue, Dec 11, 2001 at 05:06:57PM -0800
X-OperatingSystem: Linux ftoomsh.progsoc.uts.edu.au 2.2.15-pre13
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2001 at 05:06:57PM -0800, Andrew Morton wrote:
> Berend De Schouwer wrote:

>> [1.] One line summary of the problem:

>> Running "cat /proc/ioports" causes a segfault and kernel oops.

>> ...
>> [7.3.] Module information (from /proc/modules):

>> cyclades              147616  16 (autoclean)

> cyclades does request_region(), but forgets to do release_region().
> This will leave the region allocated in kernel data structures, but
> its "name" field resides in module memory.

> So if you load cyclades.o, then rmmod it, then cat /proc/ioports,
> you'll touch unmapped memory and go boom.

> Some brave soul needs to teach cyclades about release_region().
> Shame the Nobel prizes are all gone this year.

speaking of living in module memory, a similar thing happens with the
via-rhine driver. after my machine has been up for a few hours the
"via-rhine" string in /proc/iomem and /proc/ioports gets over written
and prints garbage. since this has never been the cause for an oops on
my machine i never bothered reporting it. if anyone wants details i'll
provide.

	matt

