Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262568AbRFWWcz>; Sat, 23 Jun 2001 18:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262997AbRFWWcp>; Sat, 23 Jun 2001 18:32:45 -0400
Received: from gadolinium.btinternet.com ([194.73.73.111]:34726 "EHLO
	gadolinium.btinternet.com") by vger.kernel.org with ESMTP
	id <S262568AbRFWWca>; Sat, 23 Jun 2001 18:32:30 -0400
Date: Sat, 23 Jun 2001 23:30:01 GMT
From: James Stevenson <mistral@stev.org>
Message-Id: <200106232330.f5NNU1u15051@cyrix.stev.org>
To: hjb@pro-linux.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: Two nfsd bugs in 2.4.x
In-Reply-To: <20010624000750.D2868@mandel.hjb.de>
In-Reply-To: <20010624000750.D2868@mandel.hjb.de>
Reply-To: mistral@stev.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Since I switched to the kernel nfsd I have troubles exporting my
>filesystems. I think in kernel 2.2.x there was no problem, neither was
>it with the userspace nfsd. Currently I run kernel 2.4.5pre1 on the
>server.

i have also had a few problems with nfsd when i have
moved to 2.4.x (2.4.5-ac15 currently) from 2.2.x
both the server and client side.

problems i have been seeing include.

a) if the server goes down the client sometimes does not remount the
   share. and it prints lots of "stale nfs handles or something"
   this is fine if it is remounted by hand.

>1. When I try to boot one of my diskless clients (kernel 2.0.34), it mounts
>its root fs from /opt/boot/client which is on an ext2 fs. But apparently
>it hangs when it tries to access lib/ld-linux.so.1 (seen with a network
>sniffer). This is a symbolic link pointing to lib/ld-linux.so.1.9.2.
>In the kernel log I find:
>
>nfsd Security: lib/ld-linux.so.1 bad export.

there are some options that do things with symlinks have you tried
looking at some of those ?


>2. I cannot any longer mount the server's /usr on certain workstations.
>It works on my main workstation which currently runs kernel 2.4.5.
>On other workstations I get "permission denied by server". I tried various
>kernels (2.0.36, 2.2.3, 2.3.52) and various versions of mount (2.7l, 2.10o).
>My /etc/exports contains the line
>
>/usr            *.hjb.de(rw,no_root_squash)
>
>and all my clients are in my local DNS. The syslog shows
>rpc.mountd: getfh failed: Operation not permitted

hi yes i saw this it appeard to rpc.mountd that the
client had already mounted the dir but the nfsd
seemed to think otherwise it was returning the
error to rpc.mountd rebooting the server was the only
work around i found in this restarting the programs
did not seem to help.

eg
client1: mount /home (works fine)
client2: mount /home (did not work)
server: restart nfs programs
client2: mount /home (did not work)
server: reboot
client2: mount /home (works)

and client1 works all the way though (except when the
server is down of course)

i have only seem these a few times and its been working fine
since. so i think they are probably pritty hard to produce

	James
-- 
---------------------------------------------
Web: http://www.stev.org
Mobile: +44 07779080838
E-Mail: mistral@stev.org
 11:20pm  up  3:32,  5 users,  load average: 0.33, 0.39, 0.33
