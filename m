Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131545AbRAHLAd>; Mon, 8 Jan 2001 06:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135562AbRAHLAX>; Mon, 8 Jan 2001 06:00:23 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:6163 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131753AbRAHLAL>; Mon, 8 Jan 2001 06:00:11 -0500
Subject: Re: setfsuid on ext2 weirdness (2.4)
To: bjorn@sparta.lu.se (Bjorn Wesen)
Date: Mon, 8 Jan 2001 11:02:09 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1010108025520.14610B-100000@medusa.sparta.lu.se> from "Bjorn Wesen" at Jan 08, 2001 02:55:30 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Fa43-0004IU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok.. I'm going bananas. It could be a 4am braindeath or a rh7.0 bungholio
> but this is annoying:

There are lots of corner cases in the kernel that are probably a bit off

> main(int argc, char **argv)
> {
> 	int fd;
> 	setfsuid(atoi(argv[1]));
> 	fd = open("/etc/passwd", O_RDONLY);
> 	printf("got fd %d\n", fd);
> }
> 
> [root@wizball /root]# ./setfstest 0 
> got fd 3

(root)

> [root@wizball /root]# ./setfstest 500
> got fd 3

(fsuid==euid)

> [root@wizball /root]# ./setfstest 501
> got fd -1

(other)

perchance. If so does being uid 501 flip the behaviour around ?

> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
