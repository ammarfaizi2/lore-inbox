Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267927AbTBLXOy>; Wed, 12 Feb 2003 18:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267929AbTBLXOy>; Wed, 12 Feb 2003 18:14:54 -0500
Received: from tapu.f00f.org ([202.49.232.129]:56256 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S267927AbTBLXOx>;
	Wed, 12 Feb 2003 18:14:53 -0500
Date: Wed, 12 Feb 2003 15:24:43 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Bruno Diniz de Paula <diniz@cs.rutgers.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: O_DIRECT foolish question
Message-ID: <20030212232443.GA13339@f00f.org>
References: <1045084764.4767.76.camel@urca.rutgers.edu> <20030212140338.6027fd94.akpm@digeo.com> <1045088991.4767.85.camel@urca.rutgers.edu> <20030212224226.GA13129@f00f.org> <1045090977.21195.87.camel@urca.rutgers.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <1045090977.21195.87.camel@urca.rutgers.edu>
User-Agent: Mutt/1.3.28i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 12, 2003 at 06:02:58PM -0500, Bruno Diniz de Paula wrote:

> ext2.

are you able to test with another fs? (reiserfs and XFS also support
O_DIRECT)

> read(3, "", 4096)                       = 0

odd... I'm not sure why you get this

i tested locally here and it works as expected ... my test code is
appended.


  --cw

--wac7ysb48OaltWcw
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="od.c"


#define _GNU_SOURCE

#include <unistd.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>

int main()
{
    int h;
    int ps;
    char *buf;
    ssize_t n;

    ps = getpagesize();
    if (!(buf = valloc(ps)))
	return 1;
    if ((h = open("test", O_RDONLY)) < 0)
	return 1;
    n = read(h, buf, ps);
    printf("read %d bytes\n", n);
    close(h);

    return 0;
}

--wac7ysb48OaltWcw--
