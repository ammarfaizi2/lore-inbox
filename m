Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266323AbSKXLsu>; Sun, 24 Nov 2002 06:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266330AbSKXLsu>; Sun, 24 Nov 2002 06:48:50 -0500
Received: from leon.mat.uni.torun.pl ([158.75.2.17]:54454 "EHLO
	Leon.mat.uni.torun.pl") by vger.kernel.org with ESMTP
	id <S266323AbSKXLst>; Sun, 24 Nov 2002 06:48:49 -0500
Date: Sun, 24 Nov 2002 12:55:45 +0100 (CET)
From: Michal Wronski <wrona@mat.uni.torun.pl>
X-X-Sender: wrona@Leon
To: linux-kernel@vger.kernel.org
cc: Peter Waechtler <pwaechtler@mac.com>,
       Krzysztof Benedyczak <golbi@mat.uni.torun.pl>,
       "Gustafson, Geoffrey R" <geoffrey.r.gustafson@intel.com>,
       "Abbas, Mohamed" <mohamed.abbas@intel.com>
Subject: Re: [PATCH] unified SysV and POSIX mqueues - complete rewrite
In-Reply-To: <Pine.LNX.4.44.0211131555530.9870-100000@Leon>
Message-ID: <Pine.LNX.4.44.0211241251320.4806-100000@Leon>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I found a "bug" in your implementation:

+ if (!(q = get_mqueue(filp)))
+ return -EBADF;
+ if ((filp->f_mode & O_ACCMODE) == O_RDONLY)
+ return -EBADF;
+ if ((unsigned int) msg_prio > (unsigned int) MQ_PRIO_MAX)
+ return -EINVAL;
+ if (msg_len > q->attr.mq_msgsize)
+ return -EMSGSIZE;

POSIX says: "The value of msg_prio shall be less than {MQ_PRIO_MAX}."

Michal Wronski

