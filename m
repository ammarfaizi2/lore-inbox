Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262553AbTCMVWS>; Thu, 13 Mar 2003 16:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262554AbTCMVWS>; Thu, 13 Mar 2003 16:22:18 -0500
Received: from 12-249-212-150.client.attbi.com ([12.249.212.150]:32943 "EHLO
	rekl.yi.org") by vger.kernel.org with ESMTP id <S262553AbTCMVWR>;
	Thu, 13 Mar 2003 16:22:17 -0500
Date: Thu, 13 Mar 2003 15:32:58 -0600 (CST)
From: Rob Ekl <lkhelp@rekl.yi.org>
To: linux-kernel@vger.kernel.org
Subject: Sendfile, loopback, and TCP header checksum
Message-ID: <Pine.LNX.4.53.0303131510060.10653@rekl.yi.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  I'm working on a program that uses sendfile() to copy a file to a TCP
socket.  I did some testing where the server and client processes were on
the same machine.  While watching ethereal's packet dumps, I noticed the
packets that sendfile() creates are reported to have incorrect checksums.  
Other packets from the same program (ie created by write() or writev() )
have the correct checksum.

I tried another program that doesn't use sendfile(), but write() from a 
mmap()'ed file.  The checksums are reported to be correct for that 
program's packets.

I also tried executing my program across a LAN with only an ethernet
switch between the two machines.  The checksums were reported correct for 
this situation as well.

This leads me to the conclusion that using sendfile() on a loopback
interface over a TCP connection generates packets with incorrect checksums
in the TCP headers.

I do not know if ethereal is falsely reporting that the checksums are 
incorrect, but it's a very limited scope of the source of packets with 
incorrect checksums (only sendfile-generated to loopback).

Is this something that even needs to be addressed, since the receiver
would discard the packet if the checksum is incorrect, but since it's over
loopback, there's no chance of receiving data corrupted by the transport
medium and loopback ignores the checksum?

System information:  2.4.20 on both machines, ia32 CPUs, ethereal 0.9.10 
with libpcap 0.7.

Please reply directly, as I am not subscribed to the list.  Thanks.

