Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbUBZW2p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 17:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbUBZW2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 17:28:45 -0500
Received: from mta6-svc.business.ntl.com ([62.253.164.46]:13547 "EHLO
	mta6-svc.business.ntl.com") by vger.kernel.org with ESMTP
	id S261162AbUBZW2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 17:28:41 -0500
Date: Thu, 26 Feb 2004 22:34:28 +0000 (GMT)
From: Bart Oldeman <bartoldeman@users.sourceforge.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.2/2.6.3 bdev floppy open/read/close 20x slower
Message-ID: <Pine.LNX.4.44.0402262230110.646-100000@enbeo.localnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the following program:

#include <unistd.h>
#include <fcntl.h>

int main(void)
{
	int i;
	for (i = 0; i < 10; i++) {
		char buf[512];
		int fd = open("/dev/fd0", O_RDWR);
		read(fd, buf, sizeof buf);
		close(fd);
	}
	return 0;
}

takes (here) 1 second for Linux kernel 2.6.1 but 20 seconds for 2.6.2/3.
Unless the floppy is mounted at the same time -- then it takes 2 seconds
first time for 2.6.2 and is cached subsequently.

I know there have been some changes to allow hotplugging but isn't this
side-effect a little too harsh?

Bart

