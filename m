Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317648AbSHLKFJ>; Mon, 12 Aug 2002 06:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317701AbSHLKFJ>; Mon, 12 Aug 2002 06:05:09 -0400
Received: from pizda.ninka.net ([216.101.162.242]:23963 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317648AbSHLKFI>;
	Mon, 12 Aug 2002 06:05:08 -0400
Date: Mon, 12 Aug 2002 02:54:53 -0700 (PDT)
Message-Id: <20020812.025453.114975744.davem@redhat.com>
To: mroos@linux.ee
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: Linux TCP problem while talking to hostme.bkbits.net ?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.GSO.4.43.0208121024250.29811-100000@romulus.cs.ut.ee>
References: <200208112125.BAA16174@sex.inr.ac.ru>
	<Pine.GSO.4.43.0208121024250.29811-100000@romulus.cs.ut.ee>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Meelis Roos <mroos@linux.ee>
   Date: Mon, 12 Aug 2002 10:28:10 +0300 (EEST)

   Before and after the connetion attempt - looks like the number of bad
   segments is increasing so probably not a TCP bug.
   
   Since I can connect to this server fine from different locations, it
   looks like something (ISP caches/shapers? cable modem?) is corrupting
   specific packets in a reproducible way.

Aparently something is wrong with the checksums.
InErrs gets incremented in three cases:

1) Header too small, unlikely what you see

2) Bad SYN sequences, Abort On Syn in TcpExt would have been
   incremented also if this were the case, it was not

3) Bad TCP checksum

Hmmm, do you have messages that say "hw tcp v4 csum failed"
in your kernel logs?  Any other interesting kernel messages?
