Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277983AbRJWQuI>; Tue, 23 Oct 2001 12:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277970AbRJWQt7>; Tue, 23 Oct 2001 12:49:59 -0400
Received: from adsl-63-207-97-74.dsl.snfc21.pacbell.net ([63.207.97.74]:54259
	"EHLO nova.botz.org") by vger.kernel.org with ESMTP
	id <S278092AbRJWQtt> convert rfc822-to-8bit; Tue, 23 Oct 2001 12:49:49 -0400
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: 3ware 3dmd & 2.4.12-ac: Error: No Controllers Found
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Tue, 23 Oct 2001 09:50:18 -0700
Message-ID: <2142.1003855818@nova.botz.org>
From: Jurgen Botz <jurgen@botz.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest 3dmd from the 3ware site doesn't seem to work on recent
kernels, at least on 2.4.12-ac{2,6}.  The driver/array work fine.
3dmd starts up, but bringing up the page gives:

  Error: No Controllers Found

I get the following in syslog:

  Oct 23 09:28:35 nova 3dmd: ioctl(4) failed: No such file or directory
  Oct 23 09:28:35 nova 3dm: 3dmd startup succeeded

Doing an strace on 3dmd (which succeeds only partly, due to threads?)
yields the following, which may be related:

  1649  open("/dev/sda", O_RDWR)          = 4
  1649  ioctl(4, FIBMAP, 0xbffff2a0)      = 327680
  1649  fstat64(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 2), ...}) = 0
  1649  old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, 
-1,
        0) = 0x40000000
  1649  ioctl(1, TCGETS, {B38400 opost isig icanon echo ...}) = 0
  1649  write(1, "ioctl(4) failed: No such file or"..., 43) = 43
  1649  close(4)                          = 0

Anyone else run into this?  Any ideas on how to fix?

:j

-- 
Jürgen Botz                       | While differing widely in the various
jurgen@botz.org                   | little bits we know, in our infinite
                                  | ignorance we are all equal. -Karl Popper


