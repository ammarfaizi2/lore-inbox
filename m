Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267076AbSKMAqN>; Tue, 12 Nov 2002 19:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267079AbSKMAqN>; Tue, 12 Nov 2002 19:46:13 -0500
Received: from mail.gurulabs.com ([208.177.141.7]:44947 "EHLO
	mail.gurulabs.com") by vger.kernel.org with ESMTP
	id <S267076AbSKMAqN>; Tue, 12 Nov 2002 19:46:13 -0500
Subject: Is this proper fsync'ing ?
From: Dax Kelson <dax@gurulabs.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1037148241.25372.14.camel@aramis>
References: <1037148241.25372.14.camel@aramis>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 12 Nov 2002 17:55:55 -0700
Message-Id: <1037148955.25373.28.camel@aramis>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is some strace output from email delivery via maildrop compiled
with --with-dirsync:

open("./Maildir/tmp/1037107256.1332_0.mail,S=673", O_WRONLY|O_NONBLOCK|O_CREAT|O_EXCL, 0666) = 3
write(3, "message contents goes here"..., 673) = 673
fsync(3)                          = 0
close(3)                          = 0
link("./Maildir/tmp/1037107256.1332_0.mail,S=673", "./Maildir/new/1037107256.1332_0.mail,S=673") = 0
open("./Maildir/new", O_RDONLY)   = 3
fsync(3)                          = 0
close(3)                          = 0
unlink("./Maildir/tmp/1037107256.1332_0.mail,S=673") = 0
[snip some non-relevant stuff]
exit(0)

Does this look correct/safe? Filesystem is ext3 data=writeback.

