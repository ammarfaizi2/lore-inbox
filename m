Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267076AbTBLX26>; Wed, 12 Feb 2003 18:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267924AbTBLX26>; Wed, 12 Feb 2003 18:28:58 -0500
Received: from tapu.f00f.org ([202.49.232.129]:59840 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S267076AbTBLX24>;
	Wed, 12 Feb 2003 18:28:56 -0500
Date: Wed, 12 Feb 2003 15:38:46 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Bruno Diniz de Paula <diniz@cs.rutgers.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: O_DIRECT foolish question
Message-ID: <20030212233846.GA13540@f00f.org>
References: <1045084764.4767.76.camel@urca.rutgers.edu> <20030212140338.6027fd94.akpm@digeo.com> <1045088991.4767.85.camel@urca.rutgers.edu> <20030212224226.GA13129@f00f.org> <1045090977.21195.87.camel@urca.rutgers.edu> <20030212232443.GA13339@f00f.org> <1045092802.4766.96.camel@urca.rutgers.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <1045092802.4766.96.camel@urca.rutgers.edu>
User-Agent: Mutt/1.3.28i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 12, 2003 at 06:33:23PM -0500, Bruno Diniz de Paula wrote:

> But your code doesn't use O_DIRECT:

Sorry, you need to edit it (see my previous email).  A better version
(appended) gives the following results.

cw:3@tapu(cw)$ cp od.c test
cw:3@tapu(cw)$ gcc -Wall od.c
cw:3@tapu(cw)$ ./a.out
read 503 bytes
read 0 bytes

> Let me know whether including O_DIRECT the test worked.

Seems to.  I get 0 the 2nd time about,  presumably this is EOF but
arguably it should return something else.

  --cw

--PEIAKu/WMn1b1Hv9
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
    if ((h = open("test", O_RDONLY|O_DIRECT)) < 0)
	return 1;
    do {
	n = read(h, buf, ps);
	if (n == -1) {
	    perror("read");
	    break;
	}
	printf("read %d bytes\n", n);
    } while(n);

    close(h);

    return 0;
}

--PEIAKu/WMn1b1Hv9--
