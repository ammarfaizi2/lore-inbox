Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262032AbVGVHxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbVGVHxL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 03:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbVGVHxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 03:53:11 -0400
Received: from web25806.mail.ukl.yahoo.com ([217.12.10.191]:16816 "HELO
	web25806.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262032AbVGVHxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 03:53:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.gr;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=tjKW/SQzAqZ/0bHu6Do2W7/Q6IVvWAj7YY0pyGEDuy0INqH7v4G8Da0vcqQBCZOxGcscxzf6Okwyu/qnV0yCamFyEiblRAW5Qqwg2cQtbtzNOjp2dlQfMjWdHrvGLooFwoTB88mXzL1qcXtMvGrqJ16Ip+NVE1iy5DXjHshif4g=  ;
Message-ID: <20050722075307.46321.qmail@web25806.mail.ukl.yahoo.com>
Date: Fri, 22 Jul 2005 00:53:07 -0700 (PDT)
From: Drosos Kourounis <drososkourounis@yahoo.gr>
Subject: kernel 2.4.20, 2.4.21, 2.4.22 , ... does not compile with gcc-3.4.X
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Developers,
This might be a known issue but it is not known to me!
I tried to compile kernel 2.4.22 under Crux Linux,
and the compilation stopped in sched.c. I do not have
to say much to you because it seems a compiler
problem!
I guess that it would compile nicely with gcc-3.3.X.

The problem is in the following piece of code:
#define FASTCALL(x)     x __attribute__((regparm(3)))

for instance in the following piece of code:
// file inc.h
//------------
#ifndef inc_h
#define inc_h

#define FASTCALL(x)     x __attribute__((regparm(3)))
extern int FASTCALL(wake_up(double a));

#endif

// file inc.c
//------------
#include "inc.h"
inline int wake_up(double a)
{
    return (int) a;
}

root@archon# gcc-3.4.4 inc.c -c 
inc.c:3: error: conflicting types for 'wake_up'
inc.h:5: error: previous declaration of 'wake_up' was
here
inc.c:3: error: conflicting types for 'wake_up'
inc.h:5: error: previous declaration of 'wake_up' was
here

root@archon# gcc-3.3.1 inc.c -c 
root@archon#

so it is indeed a compiler problem!
The question is how do I compile a 2.4.X kernel with 
gcc-3.4.X?

Thanks in advance!
Best Wishes!
Drosos,


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
