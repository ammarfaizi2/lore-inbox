Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129226AbQK3MR0>; Thu, 30 Nov 2000 07:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129267AbQK3MRQ>; Thu, 30 Nov 2000 07:17:16 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:10766 "EHLO
        wire.cadcamlab.org") by vger.kernel.org with ESMTP
        id <S129226AbQK3MRI>; Thu, 30 Nov 2000 07:17:08 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14886.15897.534178.896687@wire.cadcamlab.org>
Date: Thu, 30 Nov 2000 05:46:33 -0600 (CST)
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@torque.net
Subject: Re: [KBUILD] Re: PATCH  - kbuild documentation.
In-Reply-To: <14885.37565.611695.816426@notabene.cse.unsw.edu.au>
        <200011300036.eAU0aTc05028@flint.arm.linux.org.uk>
        <14886.8847.933172.241464@notabene.cse.unsw.edu.au>
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Neil Brown <neilb@cse.unsw.edu.au>]
> O_OBJS := $(shell echo $(obj-y) | tr ' ' '\n' | cat -n | sort -u +1 | sort -n | cut -f2)

Clever.  I like pipelines too.  Here is a one-fork equivalent, untested:

  nodups = $(shell g=' '; for f in $(1); do case $$g in (*" $$f "*) ;; (*) g="$$g$$f "; echo $$f; esac; done)

  O_OBJS := $(call nodups,$(obj-y))

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
