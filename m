Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271755AbRHRDd2>; Fri, 17 Aug 2001 23:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271767AbRHRDdT>; Fri, 17 Aug 2001 23:33:19 -0400
Received: from relay2.primushost.com ([207.244.125.21]:63453 "EHLO
	relay2.primushost.com") by vger.kernel.org with ESMTP
	id <S271755AbRHRDdF>; Fri, 17 Aug 2001 23:33:05 -0400
From: Jay Rogers <jay@rgrs.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: select() says closed socket readable
Reply-to: Jay Rogers <jay@rgrs.com>
Message-Id: <E15Xwmb-0007eJ-00@shell2.shore.net>
Date: Fri, 17 Aug 2001 23:28:21 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For linux 2.4.2, select() indicates socket ready for read on a
socket that's never been connected.  This is inconsistent with
other versions of Unix including Linux 2.2.

The following program demonstrates:

    #include <stdio.h>
    #include <unistd.h>
    #include <sys/time.h>
    #include <sys/types.h>
    #include <sys/socket.h>
    
    main(int argc, char *argv[])
    {
        fd_set rfds;
        int retval;
        int sock;
        struct timeval tv;
    
        sock = socket(AF_INET, SOCK_STREAM, 0);
        if (sock == -1) abort();
    
        FD_ZERO(&rfds);
        FD_SET(sock, &rfds);
        tv.tv_sec = 0;
        tv.tv_usec = 0;
    
        retval = select(sock + 1, &rfds, NULL, NULL, &tv);
        printf("retval from select(): %d\n", retval);
    
        exit(0);
    } /* end main program */

Output from "ver_linux" follows:

Linux costarica 2.4.2-2 #1 Sun Apr 8 20:41:30 EDT 2001 i686 unknown
 
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.91.0.2
util-linux             2.10r
modutils               2.4.2
e2fsprogs              1.19
reiserfsprogs          3.x.0f
pcmcia-cs              3.1.22
PPP                    2.4.0
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.57
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         nfs lockd sunrpc nls_iso8859-1 ide-cd cdrom autofs 3c59x ipchains usb-uhci usbcore
