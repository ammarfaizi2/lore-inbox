Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262450AbTCIHFC>; Sun, 9 Mar 2003 02:05:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262455AbTCIHFC>; Sun, 9 Mar 2003 02:05:02 -0500
Received: from comtv.ru ([217.10.32.4]:4554 "EHLO comtv.ru")
	by vger.kernel.org with ESMTP id <S262450AbTCIHFA>;
	Sun, 9 Mar 2003 02:05:00 -0500
X-Comment-To: Daniel Phillips
To: Daniel Phillips <phillips@arcor.de>
Cc: Alex Tomas <bzzz@tmi.comex.ru>, "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, "Theodore Ts'o" <tytso@mit.edu>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [Bug 417] New: htree much slower than regular ext3
References: <11490000.1046367063@[10.10.2.4]> <m34r6fyya8.fsf@lexa.home.net>
	<20030307173425.5C4D3FAAAE@mx12.arcor-online.net>
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: 09 Mar 2003 10:08:34 +0300
In-Reply-To: <20030307173425.5C4D3FAAAE@mx12.arcor-online.net>
Message-ID: <m3r89hrp8t.fsf@lexa.home.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Daniel Phillips (DP) writes:

 DP> On Fri 07 Mar 03 16:46, Alex Tomas wrote:
 DP> The problem I see with your approach is that the traversal is no
 DP> longer in hash order, so a leaf split in the middle of a
 DP> directory traversal could result in a lot of duplicate dirents.
 DP> I'm not sure there's a way around that.

1) As far as I understand, duplicates are possible even in classic ext2
   w/o sortdir/index. See the diagram:

                    Process 1                  Process 2

                    getdents(2) returns
                    dentry1 (file1 -> Inode1)
                    dentry2 (file2 -> Inode2)

context switch -->
                                               unlink(file1), empty dentry1
                                               creat(file3), Inode3, use dentry1
                                               creat(file1), Inode1, use dentry3

context switch -->

                    getdents(2) returns
                    dentry3(file1 -> Inode1)


Am I right?


2) Why do not use hash order for traversal like ext3_dx_readdir() does?
   Upon reading several dentries within some hash set readdir() sorts them
   in inode order and returns to an user.


with best regards, Alex

