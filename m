Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261626AbSJQCHp>; Wed, 16 Oct 2002 22:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261635AbSJQCHp>; Wed, 16 Oct 2002 22:07:45 -0400
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:57313 "EHLO
	kolivas.net") by vger.kernel.org with ESMTP id <S261626AbSJQCHo>;
	Wed, 16 Oct 2002 22:07:44 -0400
Message-ID: <1034820820.3dae1cd4bc0e3@kolivas.net>
Date: Thu, 17 Oct 2002 12:13:40 +1000
From: Con Kolivas <conman@kolivas.net>
To: Andrew Morton <akpm@digeo.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Pathological case identified from contest
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found a pathological case in 2.5 while running contest with process_load
recently after checking the results which showed a bad result for 2.5.43-mm1:

2.5.43-mm1              101.38  72%     42      31%
2.5.43-mm1              102.90  75%     34      28%
2.5.43-mm1              504.12  14%     603     85%
2.5.43-mm1              96.73   77%     34      26%

This was very strange so I looked into it further

The default for process_load is this command:

process_load --processes $nproc --recordsize 8192 --injections 2

where $nproc=4*num_cpus

When I changed recordsize to 16384, many of the 2.5 kernels started exhibiting
the same behaviour. While the machine was apparently still alive and would
respond to my request to abort, the kernel compile would all but stop while
process_load just continued without allowing anything to happen from kernel
compilation for up to 5 minutes at a time. This doesnt happen with any 2.4 kernels.

I'm not sure what to make of this. Suggestion?

Con
