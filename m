Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261689AbTB0ICU>; Thu, 27 Feb 2003 03:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261701AbTB0ICU>; Thu, 27 Feb 2003 03:02:20 -0500
Received: from daimi.au.dk ([130.225.16.1]:54185 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S261689AbTB0ICT>;
	Thu, 27 Feb 2003 03:02:19 -0500
Message-ID: <3E5DC86C.93AFA6CB@daimi.au.dk>
Date: Thu, 27 Feb 2003 09:12:28 +0100
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.18-19.7.xsmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dominik Kubla <dominik@kubla.de>
CC: Miles Bader <miles@gnu.org>, DervishD <raul@pleyades.net>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: About /etc/mtab and /proc/mounts
References: <20030219112111.GD130@DervishD> <buoy942s6lt.fsf@mcspd15.ucom.lsi.nec.co.jp> <3E5DB2CA.32539D41@daimi.au.dk> <200302270808.21035.dominik@kubla.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Kubla wrote:
> 
> I would recommend to replace /etc/mtab with a pseudo-FS like Sun did
> for /etc/mnttab:
> 
> # uname -rs
> SunOS 5.8
> # mount -p
> ...
> mnttab - /etc/mnttab mntfs - no dev=39c0000
> ...

How does that thing behave? I have considered a /proc/mtab implementation,
that might be slightly similar. It would have to be like /proc/mounts, but
differ in a few fields. The mountpoint and filesystem fields should be
exactly like /proc/mounts, while the device and options fields should be
strings initialized with the same values as /proc/mounts, but otherwise
writable from userspace.

Every line written to /proc/mtab should be parsed into the fields, and
the mountpoints should be searched for a match, if a match is found, the
device and options fields are updated, otherwise the write is simply
ignored.

How does people like this idea? Should something more be done about the
options field? Should they be checked for obvious inconsistencies, or
should a write attempt to remount the filesystem with the new options?

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:aaarep@daimi.au.dk
for(_=52;_;(_%5)||(_/=5),(_%5)&&(_-=2))putchar(_);
