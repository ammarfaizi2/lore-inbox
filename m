Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317211AbSGHWe1>; Mon, 8 Jul 2002 18:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317209AbSGHWe0>; Mon, 8 Jul 2002 18:34:26 -0400
Received: from [209.184.141.189] ([209.184.141.189]:22718 "HELO UberGeek")
	by vger.kernel.org with SMTP id <S317211AbSGHWe0> convert rfc822-to-8bit;
	Mon, 8 Jul 2002 18:34:26 -0400
Subject: Re: Terrible VM in 2.4.11+?
From: Austin Gonyou <austin@digitalroadkill.net>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020709001137.A1745@mail.muni.cz>
References: <20020709001137.A1745@mail.muni.cz>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 08 Jul 2002 17:37:02 -0500
Message-Id: <1026167822.16937.5.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I do things like this regularly, and have been using kernels 2.4.10+ on
many types of boxen, but have yet to see this behavior. I've done this
same type of test with 16k blocks up to 10M, and not had this problem I
usually do test with regard to I/O on SCSI, but have tested on IDE,
since we use many IDE systems for developers. I found though, that using
something like LVM, and overwhelming it, causes bdflush to go crazy. I
can hit the wall you refer to then.When bdflushd is too busy...it does
in fact seem to *lock* the system, but of course..it's just bdflush
doing it's thing. If I modify the bdflush params..this causes things to
work just fine, at least, useable.



On Mon, 2002-07-08 at 17:11, Lukas Hejtmanek wrote:
> Hello,
> 
> as of the last stable version 2.4.18 VM management does not work for me
> properly. I have Athlon system with 512MB ram, 2.4.18 kernel without any
> additional patches.
> 
> I run following sequence of commands:
> 
> dd if=/dev/zero of=/tmp bs=1M count=512 &
> find / -print &
>  { wait a few seconds }
> sync
> 
> at this point find stops completely or at least almost stops.
> 
> The same if I copy from /dev/hdf to /dev/hda. XOSVIEW shows only reading or only
> writing (as bdflushd is flushing buffers). It never shows parallel reading and
> writing. /proc/sys/* has default settings. I do not know the reason why i/o
> system stops when bdflushd is flushing buffers nor reading can be done.
> 
> -- 
> Luká¹ Hejtmánek
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Austin Gonyou <austin@digitalroadkill.net>
