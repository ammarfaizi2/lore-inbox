Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131396AbRC0QWd>; Tue, 27 Mar 2001 11:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131395AbRC0QW1>; Tue, 27 Mar 2001 11:22:27 -0500
Received: from d83b5259.dsl.flashcom.net ([216.59.82.89]:58497 "EHLO
	home.lameter.com") by vger.kernel.org with ESMTP id <S131396AbRC0QVv>;
	Tue, 27 Mar 2001 11:21:51 -0500
Date: Tue, 27 Mar 2001 08:21:07 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
To: Chris Mason <mason@suse.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: ReiserFS phenomenon with 2.4.2 ac24/ac12
In-Reply-To: <206950000.985703696@tiny>
Message-ID: <Pine.LNX.4.21.0103270820190.6242-100000@home.lameter.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Mar 2001, Chris Mason wrote:
> On Monday, March 26, 2001 06:57:37 PM -0800 Christoph Lameter
> <christoph@lameter.com> wrote:
> > On Mon, 26 Mar 2001, Chris Mason wrote:
> >> On Monday, March 26, 2001 03:21:29 PM -0800 Christoph Lameter
> >> > On Mon, 26 Mar 2001, Chris Mason wrote:
> >> >> On Saturday, March 24, 2001 11:56:08 AM -0800 Christoph Lameter
> >> >> <christoph@lameter.com> wrote:
> >> >> > I got a directory /a/yy that I tried to erase with rm -rf /a/yy.
> >> >> > 
> >> >> > rm hangs...
> >> >> > 
> >> >> > ls gives the following output:
> >> >> > 
> >> >> > ls: /a/yy/cache3A0F94EA0A00557.html: No such file or directory
> >> >> > ls: /a/yy/cache3A0F94EA0A00557.html: No such file or directory
> >> >> > ls: /a/yy/cache3A8CCC6A0490B05.gifcache393C2B6A2CD2DF1.crumb: No
> >> >> > such file or directory
> >> >> > ls: /a/yy/cache3A0F94EA0A00557.html: No such file or directory
> >> >> > ls: /a/yy/cache3A0F94EA0A00557.html: No such file or directory
> >> >> > ls: /a/yy/cache3A8CCC6A0490B05.gifcache393C2B6A2CD2DF1.crumb: No
> >> >> > such file or directory
> >> >> > 
> >> >> > 
> > output of reiserfsck:
> > bad_leaf: block 9454 has invalid item 4: 1928 5204 0x1 DIR, len 184,
> 
> This is probably the cause of the errors.  hopefully /a is inode number
> 1928 and /a/yy is inode number 5204 ( you can check with ls -i ).  Please
> send me (privately) the output of debugreiserfs -b 9454, and we'll figure
> out the best way to fix it.
root@k2-400:/a/christoph# debugreiserfs -b 9454 /dev/hda6
 
<-------------debugreiserfs, 2000------------->
reiserfsprogs 3.x.0h
9454 is free in true bitmap
 
===================================================================
LEAF NODE (9454) contains level=1, nr_items=11, free_space=16 rdkey
-------------------------------------------------------------------------------
|###|type|ilen|f/sp| loc|fmt|fsck|                   key
|
|   |    |    |e/cn|    |   |need|
|
-------------------------------------------------------------------------------
|  0|1928 1929 0x6d1 DRCT, len 8, entry count 65535, fsck need 0, format
new|
-------------------------------------------------------------------------------
|  1|1928 1930 0x0 SD, len 44, entry count 65535, fsck need 0, format new|
(NEW SD), mode -rw-------, size 47353, nlink 1, mtime 03/24/2001 07:15:21
-------------------------------------------------------------------------------
|  2|1928 1930 0x1 IND, len 48, entry count 0, fsck need 0, format new|
12 pointers
[  101228(4) 101377 101379 101450 101585 101590(4)]
-------------------------------------------------------------------------------
|  3|1928 5204 0x0 SD, len 44, entry count 65535, fsck need 0, format new|
(NEW SD), mode d---------, size 96, nlink 2, mtime 03/23/2001 20:49:37
-------------------------------------------------------------------------------
|  4|1928 5204 0x1 DIR, len 184, entry count 5, fsck need 0, format old|
###: Name                     length    Object key           Hash     Gen
number
  0: ".                        "(  1)   1928           5204           0
1, loc b0,  state 4 ()
  1: "..                       "(  2)      1              2           0
2, loc a8,  state 4 ()
  2: "cache3A0F94EA0A00557.html"( 25)   5204           5334  1942043776
0, loc 88,  state 4 ()
  3: "cache3A0F94EA0A00557.html"( -6) 263760           5334        5248
86, loc 88,  state 4 (BROKEN)
  4: "cache3A8CCC6A0490B05.gifcache393C2B6A2CD2DF1.crumb"( 50) 263760
64136        5248   86, loc 50,  state 4 (BROKEN)
-------------------------------------------------------------------------------
|  5|1928 20843 0x0 SD, len 44, entry count 65535, fsck need 0, format
new|
(NEW SD), mode -rw-------, size 21439, nlink 1, mtime 03/25/2001 19:44:34
-------------------------------------------------------------------------------
|  6|1928 20843 0x1 IND, len 24, entry count 0, fsck need 0, format new|
6 pointers
[  100720 100724 100942 101486 102588 102614]
-------------------------------------------------------------------------------
|  7|1928 42413 0x0 SD, len 44, entry count 65535, fsck need 0, format
new|
(NEW SD), mode -rw-------, size 3978, nlink 1, mtime 03/25/2001 20:00:32
-------------------------------------------------------------------------------
|  8|1928 42413 0x1 IND, len 4, entry count 0, fsck need 0, format new|
1 pointers
[  102864]
-------------------------------------------------------------------------------
|  9|1931 1933 0x0 SD, len 44, entry count 65535, fsck need 0, format new|
(NEW SD), mode -rw-------, size 3448, nlink 1, mtime 03/24/2001 07:15:14
-------------------------------------------------------------------------------
| 10|1931 1933 0x1 DRCT, len 3304, entry count 65535, fsck need 0, format
new|
===================================================================


