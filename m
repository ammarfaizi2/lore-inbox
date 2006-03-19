Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751390AbWCSEsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbWCSEsy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 23:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbWCSEsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 23:48:54 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:21905 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751390AbWCSEsx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 23:48:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=QYArSi9Mw9IN4SbtkvREDIze3q5YlSEQx0b0JORFrqtcqLeVu9IPNX3foTXUwAtsR0sTEMwZGlzyno52JZP6I2hUDTbim1gk/FPasTw37DziH86CsNey/6DJ21YUEIRc3kqYOSANENyFyibi9OYaJB04uur29D/sP6vgCoSNhK0=
Message-ID: <4ae3c140603182048k55d06d87ufc0b9f0548574090@mail.gmail.com>
Date: Sat, 18 Mar 2006 23:48:52 -0500
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Question regarding to store file system metadata in database
Cc: linux-fsdevel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was wondering why only few file system uses database to store file
system metadata. Here, metadata primarily refers to directory entries.
For example, one can setup a database to store file pathname, its
inode number, and some extended attribution. File pathname can be used
as primary key. As such, we can achieve pathname to inode mapping as
well as many other features such as fast search and extended file
attribute management. In contrast, storing file system entries in
directory files may result in slow dentry search. I guess that's why
ReiserFS and some other file systems proposed to use B+ tree like
strucutre to manage file entries. But why not simple use database to
provide the same feature? DB has been heavily optimized to provide
fast search and should be good at managing metadata.

 I guess one concern about this idea is  performance impact caused by
database system. I ran a test on a mysql database: I inserted about
1.2 million such kind of records into an initially empty mysql
database. Average insertion rate is about 300 entries per second,
which is fast enough to handle normal file system burden, I think.  I
haven't try the query speed, but I believe it should be fast enough
too (maybe I am wrong, if so, please point that out.).

Then I am a little curious why only few people use database to store
file system metadata, although I know WinFS plans to use database to
manage metadata. I guess one reason is that it is difficult for kernel
based file system driver to access database. But this could be
addressed by using efficient kernel/user communication mechanism.
Another reason could be the worry about database system. If database
system crashes, file system will stop functioning too. However, the
feature needed by file system is really a small part of database
system, A reduced database system should be sufficient to provide this
feature and be stable enough to support a file system.

Can someone point out more issues that could become obstables to using
database to manage metadata for a file system?

Many thanks!
Xin
