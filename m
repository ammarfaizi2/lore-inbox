Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbWGRKDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWGRKDz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 06:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932158AbWGRKDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 06:03:55 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:22493 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932154AbWGRKDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 06:03:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ocq0sqLJ5hgNPtLrZ+34z8/QtS3HbQuyTn90tjRgW8WmjYaOPQTgj3xhlt8fVixy09f5qpywSPQm7Ycc84Zwf0fVkpvS7+QdbQCIuThiqRyBnpwEO3bbtrcy9ThUmzt89x5Hi4d2zsOy6mZMLdMyl1ksheFZvE1z7AaJ1na9oKk=
Message-ID: <4df04b840607180303i3d8c8bd0o4d2a24752ec2e150@mail.gmail.com>
Date: Tue, 18 Jul 2006 18:03:54 +0800
From: "yunfeng zhang" <zyf.zeroos@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Improvement on memory subsystem
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux core memory developers:

It's my pleasure to show some ideas in my OS named Zero to you, the features
listed below, I think, can be introduced into Linux 2.6.16.1 and later. The
following section is divided into two parts by the implmentation difficulty.

Minor improvement.
1. Apply dlmalloc arithmetic (http://g.oswego.edu/dl/html/malloc.html) on memory
page allocation instead of buddy arithmetic. As the result, we can get more
consecutive memory pages easily.
2. Read-ahead process during page-in/out (page fault or swap out) should be
based on its VMA to enhance IO efficiency instead of the relative physical pages
in swap space.
3. All slabs are all off-slab type. Store slab instance in page structure.
4. Introduce PrivateVMA class and discard anonymous VMA to simplify the
relationship between VMA and its pages. When a VMA is split/combined, update the
member mapping of all relating pages. In fact, those methods should be rare to
use.
5. Add a lock bit in pte. Note, the feature want CPU preserves a programer
available bit in pte. So we can avoid to allocate page before locking the pte
during do_anonymous_page, in other words, relief memory page allocation
pressure.
6. Swap out pages by scaning all vmas linking to Zone instead of scaning pages.

Major improvement.
1. No COW on anonymous vma.
2. Dynamic page mapping on core space. It's the further discussion about former
item 1 in minor improvment section, other features on it is applying DLPTE
arithmetic on core PTE array, introducing RemapDaemon.

You can download http://www.cublog.cn/u/21764/upfile/060718173355.zip to find
more about those features and it's convenient to illustrate my idea for there is
a lots of diagrams in it. Summary of the file is MemoryArchitecture.pdf is the
documentation of my Zero OS memory subsystem. Code in Implementation/memory/
shows some sample implementation about my memory subsystem. Note, not like other
OS, I do like to write documentation and my OS is far from completion, even its
memory subsystem.

My blog (Chinese site): http://zeroos.cublog.cn/

Regarding
                                                            Yunfeng Zhang
