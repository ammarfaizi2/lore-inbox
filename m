Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263884AbUDGRlF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 13:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbUDGRlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 13:41:05 -0400
Received: from quimby.programmfabrik.de ([193.108.181.138]:44048 "EHLO
	quimby.programmfabrik.de") by vger.kernel.org with ESMTP
	id S263884AbUDGRlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 13:41:01 -0400
Subject: cp fails in this symlink case, kernel 2.4.25, reiserfs + ext2
From: Martin Rode <martin.rode@zeroscale.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Zeroscale GmbH & Co.
Message-Id: <1081359310.1212.537.camel@marge.pf-berlin.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 07 Apr 2004 19:35:11 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear developers,

After 10 years with linux I am happy I can report something :-). 

I don't know 100% if is a bug, but I think it is.

The example below fails on reiserfs as well as on ext2 for me. I dont
think it should fail, or am I missing something? 

Please cc me personally, I am not a subscriber.

Kernel testet: 2.4.[25|19]
Filesystems testet: reiserfs, ext2

Take Care,
Martin


How to reproduce:
-----------------

In any directory try this:

1) mkdir -p alpha/gamma beta
2) (cd alpha; ln -s ../beta .; ln -s gamma latest;)
3) echo "Test" > alpha/gamma/myfile

4) Check
apu:/home/martin/tmp/bug# find -exec file {} \;
.: directory
./alpha: directory
./alpha/gamma: directory
./alpha/gamma/myfile: ASCII text
./alpha/beta: symbolic link to `../beta'
./alpha/latest: symbolic link to `gamma'
./beta: directory

5) cp fails
apu:/home/martin/tmp/bug# (cd alpha/beta; cp ../latest/myfile .)
cp: cannot stat `../latest/myfile': No such file or directory

6) cp ok
apu:/home/martin/tmp/bug# (cd alpha/; cp latest/myfile beta && echo
"ok")
ok



