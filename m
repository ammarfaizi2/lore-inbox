Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbWHMM5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWHMM5b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 08:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWHMM5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 08:57:31 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:15014 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751144AbWHMM5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 08:57:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=FRsR8qLfDICx4/LpIFnoso+xgptvbgesH9XAyAOCqcKAmJz3js4U4K5HtDsUlSIEofixLP7sYmYl8SNnFBbJO2li/IT+srTY6YfTMER/WWGJhOgrdIHB5QotGfL9BYM2XflJrCrD70ucE6g63NDbe6ln9hgO1dIsx5Yw5R9zNE4=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] aic7xxx: remove excessive inlining
Date: Sun, 13 Aug 2006 14:57:21 +0200
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608131457.21951.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is a resend. I had these patches run-tested
at the time of first submission. Now I have no hardware
to test them. I think that they are still fine, though.

Basically, patches deinline some functions, mainly those
which perform port I/O. They shave off ~55k on AMD64:

# x86_64-pc-linux-gnu-size linux-2.6.17.8_64*/vmlinux
   text    data     bss     dec     hex filename
4632627 1222698  468392 6323717  607e05 linux-2.6.17.8_64/vmlinux
4571327 1223274  468392 6262993  5f90d1 linux-2.6.17.8_64aic/vmlinux

# x86_64-pc-linux-gnu-size linux-2.6.17.8_64*/drivers/scsi/aic7xxx/aic7*xx.o
   text    data     bss     dec     hex filename
 135543   13521     628  149692   248bc linux-2.6.17.8_64/drivers/scsi/aic7xxx/aic79xx.o
 103291   22289     560  126140   1ecbc linux-2.6.17.8_64/drivers/scsi/aic7xxx/aic7xxx.o
  90083   13521     628  104232   19728 linux-2.6.17.8_64aic/drivers/scsi/aic7xxx/aic79xx.o
  87231   22289     560  110080   1ae00 linux-2.6.17.8_64aic/drivers/scsi/aic7xxx/aic7xxx.o
--
vda
