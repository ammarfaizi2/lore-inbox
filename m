Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319077AbSIJIQj>; Tue, 10 Sep 2002 04:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319080AbSIJIQj>; Tue, 10 Sep 2002 04:16:39 -0400
Received: from tnt-2-5.pops.easynet.fr ([212.180.33.5]:50170 "HELO
	hubert.heliogroup.fr") by vger.kernel.org with SMTP
	id <S319077AbSIJIQi>; Tue, 10 Sep 2002 04:16:38 -0400
From: Hubert Tonneau <hubert.tonneau@pliant.cx>
To: linux-kernel@vger.kernel.org
Subject: User land kernel configuration/profiling model proposal
Date: Tue, 10 Sep 2002 08:19:45 GMT
X-Mailer: Pliant 76
Message-Id: <20020910081638Z319077-685+45673@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The external view of the kernel configuration status would be a set of global
entries such as:
/network/device/eth0/ip=10.11.12.13
/network/device/eth0/mask=255.255.255.0
...

Each open handle also has such a private tree, and each process also.

Now, only three kernel functions are required to provide overall kernel
configuration and profiling:

int kernel_configure(int handle,const char *buffer,int length);

  the buffer is assumed to be filled with a SET OF lines.
  'handle' is zero if accessing the kernel global tree instead of a handle
  specific one.

int kernel_query(int handle,const char *path,int path_length,char *buffer,int buffer_length);

  asks the kernel to fill the buffer with one line per entry,
  selecting only entries starting by 'path'

int open_process(int pid);

  returns a handle to the process enabling to access process related
  informations.


This model covers all at once the features from:
. /proc
. ioctl
. all specific user land tools

The problem with /proc filesystem is that it does not allow to access all
a subtree at once, so in order to provide a set of consistent informations,
they have to be provided as a single file, with the parsing related
nightmare.

The problem with ioctl is that using numbers is too much efficiency
with a too high lack of flexibility drawback, and once again, configuring
will often need several datas, so a structure with the versioning related
problems.

What's also very interesting with this model is that you can now have
a single tool for configuring all the kernel instead of multiple
'ifconfig' 'raidhotadd' and others.

Last point, it's also very valuable for providing feedback to developpers:
when one fails to compile the kernel, he can provide his .config file.
Now, when one computer bahaves stangely, he could provide a dump of
he's runtime configuration.


What's left as an exercise to readers is how this could fit in the Linux
kernel code :-)

