Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbVBNXn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbVBNXn6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 18:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVBNXn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 18:43:58 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:49743 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261290AbVBNXnh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 18:43:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=lysb5ur4LBf0FgSW8si5KyPN8FNPI9rvVNRq6H/I7TPiJRVmz1Y8tsMniBNf+H+KAmq3whP0hBsPEbT/yN46gikRwd/ty0XfzJXlyysavOnD7hdSzOLLfBEjs0O/XptyeRqSw4qo+ydouxBkukcimNCj+pj+oJEsOWBCmojjyW4=
Date: Tue, 15 Feb 2005 00:43:29 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: prakashp@arcor.de, paolo.ciarrocchi@gmail.com, gregkh@suse.de,
       pmcfarland@downeast.net, linux-hotplug-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 001 release
Message-Id: <20050215004329.5b96b5a1.diegocg@gmail.com>
In-Reply-To: <1108422240.28902.11.camel@krustophenia.net>
References: <20050211004033.GA26624@suse.de>
	<420C054B.1070502@downeast.net>
	<20050211011609.GA27176@suse.de>
	<1108354011.25912.43.camel@krustophenia.net>
	<4d8e3fd305021400323fa01fff@mail.gmail.com>
	<42106685.40307@arcor.de>
	<1108422240.28902.11.camel@krustophenia.net>
X-Mailer: Sylpheed version 1.9.2+svn (GTK+ 2.6.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Mon, 14 Feb 2005 18:04:00 -0500,
Lee Revell <rlrevell@joe-job.com> escribió:

> Last I heard Gentoo does not even do it by default.
> 
> I don't see why so much effort goes into improving boot time on the
> kernel side when the most obvious user space problem is ignored.


There's stuff that it could be done in the kernel to help improving those numbers,
IMHO.

xp logs all the io done the first two minutes after booting. The next time it boots
it tries to read all those files at once so the programs will find stuff in memory
instead of having to do lots of small seeks. Some people in the linux field have
got a list of the files used at startup and they've thrown it at a "readhead" script,
which seems to help but IMHO it's somewhat "hacky" compared with the 
xp's trick. xp also does that when you start a program, it saves a log of all the
io done and it preloads it efficiently at startup - it improves "cold-cache" loading
times a _lot_. I haven't seen any alternative for that in the linux world, and
being able to keep track of al the io done by a given process would fix that (some
people has put used printk's for that, but i think it can be done better)

Also, it analyzes all those io "logs" and defragments (in background every 3 days,
and with low load without the user noticing it) the disk according to the _use_ of the
systems. Linux kernel can keep a file unfragmented, but currently there's no way
linux can do decisions like "this system starts openoffice, so I'm going to move the
binaries to another place of the disk where they'll load faster" or "when X program
uses /lib/libfoo.so it also uses /lib/libbar.so, so I'm going to put those two together
in the disk because that will avoid seeks". Kernel only can keep a single file
unfragmented, but it doesn't know about how several files must be (un)fragmented
between them. Being able to defragment things seems to be the one fix that (even
mac os x does it)

Userspace is where the problem is, but it's not going to be fixed. Ever. If
something, it's going to be worse - it's how software works. And even if you make
openoffice "fast", you still could _improve_ things with the tricks described
above. Disks are too slow, and things like demand-loading executables generate
too many small seeks, and programs can't control demand-loading so I don't
think userspace is the only with work to do.
