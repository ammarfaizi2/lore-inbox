Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbUDEL5m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 07:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbUDEL5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 07:57:42 -0400
Received: from ahriman.Bucharest.roedu.net ([141.85.128.71]:52445 "EHLO
	ahriman.bucharest.roedu.net") by vger.kernel.org with ESMTP
	id S262056AbUDEL5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 07:57:38 -0400
Date: Mon, 5 Apr 2004 15:00:12 +0300 (EEST)
From: Mihai RUSU <dizzy@roedu.net>
X-X-Sender: dizzy@ahriman.bucharest.roedu.net
To: linux-kernel@vger.kernel.org
Subject: 2.6.5 & AMD64 epoll weirdness
Message-ID: <Pine.LNX.4.58L0.0404051326360.1773@ahriman.bucharest.roedu.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I have this little test program:
#include <sys/epoll.h>

int main(void)
{
    int efd;
    struct epoll_event event;
    struct epoll_event events[10];

    efd = epoll_create(100);
    event.data.fd = 0;
    epoll_ctl(efd, EPOLLIN, 0, &event);
    epoll_wait(efd, events, 10, -1);
}

This program runs fine on x86/32bit with 2.6.5 kernel. But on AMD64 it 
does this (strace qoute):

epoll_create(0x64)                      = 3
epoll_ctl(0x3, 0x1, 0, 0x7fbffff860)    = -1 ENOSYS (Function not implemented)
epoll_wait(0x3, 0x7fbffff7e0, 0xa, 0xffffffff) = -1 ENOSYS (Function not implemented)

This is rather weird because I would expect to have epoll_create() fail 
too (in fact I use this check at runtime, I try epoll_create and if it 
works I presume epoll is functional; I needed this check because glibc 
might have dummy epoll functions which always fail although the program 
compiles fine with it). So do I really need to check all epoll syscalls 
before presuming that epoll works on the current system ? (I would like to 
have epoll_create failing in the case it doesnt supports AMD64).

Thanks!

-- 
Mihai RUSU                                    Email: dizzy@roedu.net
GPG : http://dizzy.roedu.net/dizzy-gpg.txt    WWW: http://dizzy.roedu.net
                       "Linux is obsolete" -- AST
