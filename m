Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267560AbTAHGiZ>; Wed, 8 Jan 2003 01:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267655AbTAHGiZ>; Wed, 8 Jan 2003 01:38:25 -0500
Received: from zukmail03.zreo.compaq.com ([161.114.128.27]:25618 "EHLO
	zukmail03.zreo.compaq.com") by vger.kernel.org with ESMTP
	id <S267560AbTAHGiY> convert rfc822-to-8bit; Wed, 8 Jan 2003 01:38:24 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: linux i386 stack trace
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Date: Wed, 8 Jan 2003 07:46:58 +0100
Message-ID: <224CFA9643B4CE4BA18137CF73DB2F32010F2CD0@broexc01.emea.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: linux i386 stack trace
Thread-Index: AcK24ghWl3t0N1fLTpmNnjUZmrSORw==
From: "Roets, Chris (Tru64&Linux support)" <Chris.Roets@hp.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Jan 2003 06:46:59.0705 (UTC) FILETIME=[BE56C690:01C2B6E1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I known nothing about i386 calling conventions, but I would like to analyse a kernel stack.
 
I have the following stack trace :
 
STACK TRACE FOR TASK: 0xc4cb6000(vi)
 
 0 schedule+770 [0xc01130e2]
 1 schedule_timeout+18 [0xc0112d42]
 2 do_select+513 [0xc0140a11]
 3 sys_select+820 [0xc0140db4]
 4 system_call+44 [0xc0106f14]
   ebx: 00000001   ecx: bffff700   edx: 00000000   esi: bffff680
   edi: 00000000   ebp: bffff798   eax: 0000008e   ds:  002b
   es:  002b       eip: 4010e0ee   cs:  0023       eflags: 00000202
   esp: bffff630   ss:  002b
================================================================
 
>> dump -x 3301670612 40
0xc4cb7ed4:       c4cb7f00 
                  c4cb6000 
                  00000000 
                  c29f3000
0xc4cb7ee4:       c4cb6000 
                  00000000 
                  c0274000 
                  c02b2540 
0xc4cb7ef4:       7fffffff 
                  7fffffff 
                  00000000 
                  c4cb7f30 
0xc4cb7f04:       c0112d47 schedule_timeout+23
                  c29f3000 
                  cc75e914 
                  c4cb7f54 
0xc4cb7f14:       00000000 
                  c8dde7c4 
                  00000001 
                  c4cb7f90 
0xc4cb7f24:       00000000 
                  00000000 
                  7fffffff 
                  00000000
0xc4cb7f34:       c0140a16 do_select+518
                  c4cb7f54 
                  00000001 
                  c4cb6000
0xc4cb7f44:       7fffffff 
                  00000001 
                  00000000 
                  00000001 
0xc4cb7f54:       00000000 
                  c730f000 
                  00000001 
                  bffff684 
0xc4cb7f64:       c17d83ec 
                  00000001 
                  c0140db9 sys_select+825
                  00000001 
 
can anybody point me out where the arguments and the local variables are ?
take for example 
    int do_select(int n, fd_set_bits *fds, long *timeout)
    {
            poll_table table, *wait;
            int retval, i, off;
            long __timeout = *timeout;

           ......
I t has 3 arguments and tree local variable
I would be nice to have the same for ia64
 
Chris
