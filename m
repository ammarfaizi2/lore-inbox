Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318936AbSICVIk>; Tue, 3 Sep 2002 17:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318935AbSICVIk>; Tue, 3 Sep 2002 17:08:40 -0400
Received: from pizda.ninka.net ([216.101.162.242]:37079 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318930AbSICVIj>;
	Tue, 3 Sep 2002 17:08:39 -0400
Date: Tue, 03 Sep 2002 14:05:55 -0700 (PDT)
Message-Id: <20020903.140555.51297783.davem@redhat.com>
To: kuznet@ms2.inr.ac.ru
Cc: taka@valinux.co.jp, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: TCP Segmentation Offloading (TSO)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200209031322.RAA02182@sex.inr.ac.ru>
References: <20020903.220302.26270018.taka@valinux.co.jp>
	<200209031322.RAA02182@sex.inr.ac.ru>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: kuznet@ms2.inr.ac.ru
   Date: Tue, 3 Sep 2002 17:22:37 +0400 (MSD)

   Dave, look, he says we will oops when sendfiling the last byte of a page,
   and will have to call skb_checksum().
   
It is true.  But his patch must be rewritten, bswap is forbidden
on older processors.

Better fix is to verify len >=2 before half-word alignment
test at the beginning of csum_partial.  I am not enough of
an x86 coder to hack this up reliably. :-)
