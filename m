Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131246AbRDNIXq>; Sat, 14 Apr 2001 04:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131275AbRDNIXf>; Sat, 14 Apr 2001 04:23:35 -0400
Received: from sitebco-home-5-17.urbanet.ch ([194.38.85.209]:21593 "EHLO
	vulcan.alphanet.ch") by vger.kernel.org with ESMTP
	id <S131246AbRDNIX1>; Sat, 14 Apr 2001 04:23:27 -0400
Date: Sat, 14 Apr 2001 10:23:24 +0200
Message-Id: <200104140823.KAA30162@vulcan.alphanet.ch>
From: Marc SCHAEFER <schaefer@alphanet.ch>
To: linux-kernel@vger.kernel.org
Subject: Re: SCSI tape corruption problem
Newsgroups: alphanet.ml.linux.kernel
Organization: ALPHANET NF -- Not for profit telecom research
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now try this:

   cd ~archive
   mt -f /dev/tapes/tape0 rewind
   tar cvf - . | gzip -9 | dd of=/dev/tapes/tape0 bs=32k

and then:

   mt -f /dev/tapes/tape0 rewind
   dd if=/dev/tapes/tape0 bs=32k | gzip -d | tar --compare -v -f -

The above is the proper way to talk to a tape drive through gzip.

PS: if you pre-compress, it can be wise to suppress hardware compression
(mt -f /dev/nst0 datcompression 0) and maybe use a big buffer with
the buffer command.

