Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271479AbTGQRc4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 13:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271503AbTGQRc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 13:32:56 -0400
Received: from [213.4.129.129] ([213.4.129.129]:1896 "EHLO tfsmtp2.mail.isp")
	by vger.kernel.org with ESMTP id S271479AbTGQRcb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 13:32:31 -0400
From: RAMON_GARCIA_F <RAMON_GARCIA_F@terra.es>
To: linux-kernel@vger.kernel.org
Message-ID: <fb7ddfab3b.fab3bfb7dd@teleline.es>
Date: Thu, 17 Jul 2003 19:47:11 +0200
X-Mailer: Netscape Webmail
MIME-Version: 1.0
Content-Language: es
Subject: Suggestion for a new system call: convert file handle to a
 cookie for transfering file handles between processes.
X-Accept-Language: es
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I suggest to add a new system call for transfering a file handle between
two processes.

In Linux, transfer of file handles can be done through a Unix domain
socket. This mechanism is quite unflexible. It requires that the two
applications connect by this kind of socket, and it is difficult to
use from shell scripts.

The new mechanims proposed is more flexible.

A cookie is a large integer number (160 bit suggested) that can be used
to refer to a file handle from any process. It is randomly choosen by
the kernel at creation time. Afterwards, any process that knows this
cookie can convert it back to a file handle. When this conversion is
done, the cookie dies and is no longer valid.

An example of why cookies are useful.

Let cdwritter be a program for writting CDs. Unlike other programs,
cdwritter is rationally designed. It is a server process that listens
through a named pipe, thus making it easy to write either command line
or graphical interfaces that use its functionality. The named pipe
is called /var/run/cdwritter

To keep this discussion simple, cdwritter supports writting a single
file (usually an ISO image) to a cdrecorder. The user gives a command,
and afterwards the CD is burned. To write a file, the user must write a
string "write <cookie>" to /var/run/cdwritter. The cookie is used to
identify the file.

An alternative would be that cdwritter accepts a file name instead of
a cookie. But then, the author of cdwritter would have to check if the
user has permission to access the file. This makes cdwritter more error
prone.

Shell scripts can write CDs to cdwriter. The command get_cookie, opens a
file given on the command line and prints a cookie on stdout. Thus a
shell script for burning the image my_nude_photos.iso would be:

echo "write $(get_cookie my_nude_photos.iso)" > /var/run/cdwritter

CREDITS: The Plan9 operating system provided inspiration for this idea.

Ramon






