Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbVJCHH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbVJCHH1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 03:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbVJCHH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 03:07:27 -0400
Received: from us02smtp1.synopsys.com ([198.182.60.75]:30934 "EHLO
	vaxjo.synopsys.com") by vger.kernel.org with ESMTP id S932157AbVJCHH0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 03:07:26 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
x-mimeole: Produced By Microsoft Exchange V6.5.7226.0
Subject: Shared Library Holes in x86_amd64
Date: Mon, 3 Oct 2005 12:37:20 +0530
Message-ID: <7EC22963812B4F40AE780CF2F140AFE9168364@IN01WEMBX1.internal.synopsys.com>
Thread-Topic: Shared Library Holes in x86_amd64
Thread-Index: AcXH6Ri0vuQYNcF1TKiZmyAtwmjCaQ==
From: "Arijit Das" <Arijit.Das@synopsys.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 03 Oct 2005 07:07:25.0228 (UTC) FILETIME=[1B7AFEC0:01C5C7E9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I strace a "/bin/sleep 23" command in a RHAS3.0/x86-AMD64 machine, I
see that holes are being created in some of the mapped shared libraries
using the mprotect system call like this:

2a95931000     1260K r-xp /lib64/tls/libc-2.3.2.so
2a95a6c000     1024K ---p /lib64/tls/libc-2.3.2.so   <HOLE>
2a95b6c000       20K rw-p /lib64/tls/libc-2.3.2.so

open("/lib64/tls/libc.so.6", O_RDONLY)  = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0@\322\1\0"...,
640) = 640
fstat(3, {st_mode=S_IFREG|0755, st_size=1669064, ...}) = 0
mmap(NULL, 2375528, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =
0x2a95931000
mprotect(0x2a95a6c000, 1085288, PROT_NONE) = 0
mmap(0x2a95b6c000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED,
3, 0x13b000) = 0x2a95b6c000
mmap(0x2a95b71000, 16232, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x2a95b71000
close(3)

This gives me a feeling that a section of the shared library file i.e.
the section mapped with PROT_NONE flag doesn't contain any useful data
and hence, is not being used. 
 
Does anybody know the reason behind such holes inside a shared library
like /lib64/tls/libc.so.6 in RHAS30/x86_amd64 platforms? 

Thanks for your time,
Arijit

