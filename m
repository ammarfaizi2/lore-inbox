Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265399AbUFOKCQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265399AbUFOKCQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 06:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265396AbUFOKCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 06:02:16 -0400
Received: from p4.ensae.fr ([195.6.240.202]:22571 "EHLO pc809.ensae.fr")
	by vger.kernel.org with ESMTP id S265399AbUFOKCP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 06:02:15 -0400
From: Guillaume =?iso-8859-15?q?Lac=F4te?= <Guillaume@Lacote.name>
Reply-To: Guillaume@Lacote.name
To: linux-kernel@vger.kernel.org
Subject: BIO ordering and NativeCommandQueueing
Date: Tue, 15 Jun 2004 12:02:12 +0200
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406151202.12884.Guillaume@Lacote.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
(I hope this is the right place for this - sorry if it is not).

Native Command Queueing (and Tagged Command Queueing) is a feature provided by 
the hardware of newer IDE (and old SCSI) disk drives which basically consists 
in reordering the commands issued on the ATA bus to improve speed.

I assume however that the fastest way to read sectors 101 to 110 is to ask for 
them in that order: 101,102,...,110 . This is a basic assumption made by most 
OSes and apps I presume (otherwise for example DMA performance would be 
catastrophic).

Here is my point: since a bvec consists of _ordered_ requests only, what is 
the use of NCQ ? Requests will arrive to the drive in increasing order, which 
is the best possible ordering performance-wise; thus NCQ will do never do 
anything.

Am I mistaken ? 
