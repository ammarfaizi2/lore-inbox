Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284702AbRLEUrg>; Wed, 5 Dec 2001 15:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284698AbRLEUrQ>; Wed, 5 Dec 2001 15:47:16 -0500
Received: from mailout5-1.nyroc.rr.com ([24.92.226.169]:62173 "EHLO
	mailout5.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S284696AbRLEUrP>; Wed, 5 Dec 2001 15:47:15 -0500
Message-ID: <03c201c17dcc$4e14c930$1a01a8c0@allyourbase>
From: "Dan Maas" <dmaas@dcine.com>
To: <adam-dated-1007982419.3acea7@flounder.net>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <fa.g60uruv.1n5cija@ifi.uio.no> <fa.h8gf0vv.18kimh8@ifi.uio.no>
Subject: Re: Maximum heap size?
Date: Wed, 5 Dec 2001 15:34:54 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you are hitting a 1GB limit I would assume the jvm isn't very bright
> about its allocation of resources. You should run out at something like
> 2.5Gb of allocations. (you lose some to app and library maps)

Specifically, the jvm is probably getting memory from brk(), because brk()
only operates in the ~1GB region between 0x08000000 + epsilon (where the
executable ends) and 0x40000000 (where shared libs begin). The easiest way
to get more than 1GB is to mmap() anonymous pages (which will come from the
remaining ~2GB region between 0x40000000 and 0xBFFFFFFF). e.g. glibc will
use anonymous mmap() to fulfill large malloc() requests.

Regards,
Dan

