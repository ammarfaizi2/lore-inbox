Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264849AbRFTGi3>; Wed, 20 Jun 2001 02:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264850AbRFTGiJ>; Wed, 20 Jun 2001 02:38:09 -0400
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:45373 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S264849AbRFTGiE>; Wed, 20 Jun 2001 02:38:04 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: fs/namei.c lookup_flags is misleading
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 20 Jun 2001 16:37:54 +1000
Message-ID: <31086.993019074@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.6-pre3 and earlier.  fs/namei.c:lookup_flags() checks for O_CREATE,
it even has a comment saying that O_CREATE|O_EXCL is a special case.
But the only place lookup_flags() is called has

if (!(flag & O_CREAT)) {
	if (path_init(pathname, lookup_flags(flag), nd))

so O_CREATE can never be set.  Not a bug, just misleading.  It does not
help that path_walk() has a variable called lookup_flags.

