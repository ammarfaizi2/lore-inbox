Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135214AbRDLUcF>; Thu, 12 Apr 2001 16:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135313AbRDLUb4>; Thu, 12 Apr 2001 16:31:56 -0400
Received: from bobas.nowytarg.top.pl ([212.244.190.69]:43275 "EHLO
	bobas.nowytarg.top.pl") by vger.kernel.org with ESMTP
	id <S135214AbRDLUbt>; Thu, 12 Apr 2001 16:31:49 -0400
Date: Thu, 12 Apr 2001 22:31:28 +0200
From: Daniel Podlejski <underley@underley.eu.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Incorect signal handling ?
Message-ID: <20010412223128.A11625@witch.underley.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-PGP-Fingerprint: 4D 72 53 F8 FE 8C 53 B9  66 AD F6 EA C9 17 CD 82
X-GPG-Fingerprint: 299F 1820 582B 283A 5F50  37D9 AA0B 6E10 03D4 EA5D
X-Homepage: http://www.underley.eu.org/
X-Cert: http://www.brainbench.com/transcript.jsp?pid=124954
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

there is litlle programm:

#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <signal.h>
#include <errno.h>
#include <sys/stat.h>
#include <fcntl.h>

static void empty(int sig)
{
	printf ("hello\n");
	return;
}

void main()
{
        int fd, a;
        char buf[512];

	if (fd = open("/tmp/nic", O_RDONLY) < 0)
	{
		perror ("open");
		exit(1);
	}

	signal (SIGALRM, empty);
	alarm (1);

        a = read(fd, buf, 511);

        while (a && a != -1) a = read(fd, buf, 511);

	if (a == -1)
	{
		perror ("read");
		exit(1);
	}
	else printf ("EOF\n");

        exit(0);
}

I open /tmp/nic and run compiled program.
There should be error EINTR in read, but isn't.
Why ?

-- 
Daniel Podlejski <underley@underley.eu.org>
   ... Here await the birth of the son
   The seventh, the heavenly, the chosen one ...
