Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129460AbQLXI7X>; Sun, 24 Dec 2000 03:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129627AbQLXI7N>; Sun, 24 Dec 2000 03:59:13 -0500
Received: from attila.bofh.it ([213.92.8.2]:49104 "HELO attila.bofh.it")
	by vger.kernel.org with SMTP id <S129460AbQLXI64>;
	Sun, 24 Dec 2000 03:58:56 -0500
Date: Sun, 24 Dec 2000 09:28:35 +0100
From: "Marco d'Itri" <md@Linux.IT>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com, viro@math.psu.edu
Subject: innd mmap bug in 2.4.0-test12
Message-ID: <20001224092835.B649@wonderland.linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can confirm the bug which loses updates to the inn active file when
it's unmapped is present again in 2.4.0-test12.

I put "cp active active.ok" in the rc file before shutting down the
daemon and at the next boot the files are different, every time.

Alexander Viro posted this test case:

#include <unistd.h>
main(argc,argv)
int argc;
char **argv;
{
        int fd;
        char c=0;
        truncate(argv[1], 10);
        fd = open(argv[1], 1);
        lseek(fd, 16384, 0);
        write(fd, &c, 1);
        close(fd);
}

but I tried it and it gives the correct result (a 16384 bytes long file
with only the first few bytes non-zeroed).

Linux wonderland 2.4.0-test12 #15 Thu Dec 21 16:40:16 CET 2000 i586 unknown

-- 
ciao,
Marco

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
