Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316542AbSFDIZC>; Tue, 4 Jun 2002 04:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316545AbSFDIZB>; Tue, 4 Jun 2002 04:25:01 -0400
Received: from pg-fw.paradigmgeo.com ([192.117.235.33]:4561 "EHLO
	ntserver2.geodepth.com") by vger.kernel.org with ESMTP
	id <S316542AbSFDIZB>; Tue, 4 Jun 2002 04:25:01 -0400
Message-ID: <EE83E551E08D1D43AD52D50B9F5110927E7A1B@ntserver2>
From: Gregory Giguashvili <Gregoryg@ParadigmGeo.com>
To: "Linux Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: RE: Atomic operations
Date: Tue, 4 Jun 2002 11:23:28 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thanks a lot for your help to all of you...

The last thing, I want to make sure of, is that the following type of code:

int atomic_xadd(int i, atomic_t *v)
{
	int ret;
	__asm__(LOCK "xaddl %1,%0"
		: "=m" (v->counter), "=r" (ret)
		: "0" (v->counter), "1" (i));
	return ret;
}

is less efficient than this one:

int atomic_xadd(int i, atomic_t *v)
{
	asm volatile(LOCK "xaddl %1,%0"
		: "+m" (v->counter), "+r" (i));
	return i;
}

The reason for it is that the first one is more easy to read (at least for
me as a beginner). 

Thanks again for your precious comments.
Best,
Giga
