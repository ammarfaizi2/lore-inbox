Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313142AbSC1L7w>; Thu, 28 Mar 2002 06:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313140AbSC1L7o>; Thu, 28 Mar 2002 06:59:44 -0500
Received: from pcp01384392pcs.walngs01.pa.comcast.net ([68.80.48.29]:46212
	"EHLO dysonwi") by vger.kernel.org with ESMTP id <S313139AbSC1L7a>;
	Thu, 28 Mar 2002 06:59:30 -0500
Subject: ANN: BeFS 0.92 released
From: Will Dyson <will_dyson@pobox.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 28 Mar 2002 06:59:24 -0500
Message-Id: <1017316764.3619.58.camel@dysonwi>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I have just released version 0.92 of the read only Be Filesystem driver.
As before, the project website is http://befs-driver.sf.net/ and the
downloads can be found at
http://sourceforge.net/project/showfiles.php?group_id=39575 .

Since the last time I announced a version of this project on the mailing
lists, several significant performance improvements have been made, and
serious bugs have been fixed. If you have a BeOS partition still kicking
around (or if you are just a filesystems junkie and want to test it
using the filesystem images on the download page), I urge you to give it
a try.

It still isn't quite ready for inclusion in the mainline kernel (it
doesn't yet conform to the kernel coding style, for one thing), but I
use it all the time on my system and have yet to have any kind of
stability issue with it. Third party kernel trees are most welcome to
include this driver! 

Here is the recent part of the project's changelog:


Version 0.92 (2002-03-27)
==========
* Fixed module makefile problem. It was not compiling all the correct 
source files!

* Removed duplicated function definition

* Fixed potential null pointer dereference when reporting an error

Version 0.91 (2002-03-26)
==========
* Oy! Fixed stupid bug that would cause an unresolved symbol error.
Thanks to Laszlo Boszormenyi for pointing this out to me.

Version 0.9 (2002-03-14)
==========
* Added Sergey S. Kostyliov's patch to eliminate memcpy() overhead
from b+tree operations. Changes the befs_read_datastream() interface.

* Segregated the functions that interface directly with the linux  vfs 
interface into their own file called linuxvfs.c. [WD]

Version 0.64 (2002-02-07)
==========
* Did the string comparision really right this time (btree.c) [WD]

* Fixed up some places where I assumed that a long int could hold
a pointer value. (btree.c) [WD]

* Andrew Farnham <andrewfarnham@uq.net.au> pointed out that the module
wouldn't work on older (<2.4.10) kernels due to an unresolved symbol.
This is bad, since 2.4.9 is still the current RedHat kernel. I added
a workaround for this problem (compatability.h) [WD]

* Sergey S. Kostyliov made befs_find_key() use a binary search to find 
keys within btree nodes, rather than the linear search we were using 
before. (btree.c) [Sergey S. Kostyliov]

* Made a debian package of the source for use with kernel-package. [WD]


Version 0.63 (2002-01-31)
==========
* Fixed bug in befs_find_brun_indirect() that would result in the wrong
block being read. It was introduced when adding byteswapping in 
0.61. (datastream.c) [WD]

* Fixed a longstanding bug in befs_find_key() that would result in it 
finding the first key that is a substring of the string it is searching
for. For example, this would cause files in the same directory with 
names like file1 and file2 to mysteriously be duplicates of each other 
(because they have the same inode number). Many thanks to Pavel Roskin 
for reporting this serious bug!!!
(btree.c) [WD]

* Added support for long symlinks, after Axel Dorfler explained up how 
they work. I had forgotten all about them. (inode.c, symlink.c) [WD]

* Documentation improvements in source. [WD]

* Makefile fix for independant module when CONFIG_MODVERSION is set in 
kernel config [Pavel Roskin]

* Compile warning fix for namei.c. [Sergey S. Kostyliov]


Version 0.62
==========
* Fixed makefile for module install [WD]


Version 0.61 (2002-01-20)
==========
* Made functions in endian.h to do the correct byteswapping, no matter
the arch. [WD]

* Abbandoned silly checks for a NULL superblock pointer in debug.c. [WD]

* Misc code cleanups. Also cleanup of this changelog file. [WD]

* Added byteswapping to all metadata reads from disk.
Uses the functions from endian.h [WD]

* Remove the typedef of struct super_block to vfs_sb, as it offended
certain peoples' aesthetic sense. [WD]

* Ditto with the befs_read_block() interface. [WD]

-- 
Will Dyson

