Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268696AbUHZLOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268696AbUHZLOu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 07:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268753AbUHZLKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 07:10:09 -0400
Received: from pop3.telefonica.net ([213.4.129.150]:60299 "EHLO
	telesmtp3.mail.isp") by vger.kernel.org with ESMTP id S268722AbUHZLGu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 07:06:50 -0400
Subject: 
From: Emilio =?ISO-8859-1?Q?Jes=FAs?= Gallego Arias 
	<egallego@telefonica.net>
To: akpm@odsl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 26 Aug 2004 13:06:54 +0200
Message-Id: <1093518414.4155.15.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.93 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20040826032457.21377e94.akpm@osdl.org>

Andrew Morton wrote:

> (Generally, getting all of userspace to agree on a particular library
> is socially hard [*], but I don't see that as a reason for putting the
> functionality into the kernel)

Implement it in libc?

Really, I don't understand why people want file as directory occur magically.
In Unix we already have files and directories, it's enough.

You can modify libc creat("file", mode) to create a directory layout with a 
file named #content (or whatever special name you want) and attributes are 
files in this directory:

emilio@ellugar:~/tm$ ls -lR
.:
total 4
drwxr-xr-x  2 emilio emilio 4096 2004-08-26 12:58 file

./file:
total 0
-rw-r--r--  1 emilio emilio 0 2004-08-26 12:58 attribute1
-rw-r--r--  1 emilio emilio 0 2004-08-26 12:58 attribute2
-rw-r--r--  1 emilio emilio 0 2004-08-26 12:57 #content

Of course we should modify open, rename, etc... so open("file", ...) will
do open("file/#content", ...), etc.. but no need to touch any filesystem 
and will work on any fs. 

Of course there are lots of questions of being backwars compatible etc, but
no more than doing it in the kernel.

Regards,

Emilio

