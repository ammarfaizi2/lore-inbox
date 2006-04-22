Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbWDVTv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWDVTv6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 15:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbWDVTv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 15:51:58 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:58051 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751096AbWDVTv5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 15:51:57 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: =?iso-8859-1?q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Subject: Re: Van Jacobson's net channels and real-time
Date: Sat, 22 Apr 2006 15:29:58 +0200
User-Agent: KMail/1.9.1
Cc: Ingo Oeser <netdev@axxeo.de>, "David S. Miller" <davem@davemloft.net>,
       simlo@phys.au.dk, linux-kernel@vger.kernel.org, mingo@elte.hu,
       netdev@vger.kernel.org
References: <Pine.LNX.4.44L0.0604201819040.19330-100000@lifa01.phys.au.dk> <200604211852.47335.netdev@axxeo.de> <20060422114846.GA6629@wohnheim.fh-wedel.de>
In-Reply-To: <20060422114846.GA6629@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200604221529.59899.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jörn,

On Saturday, 22. April 2006 13:48, Jörn Engel wrote:
> Unless I completely misunderstand something, one of the main points of
> the netchannels if to have *zero* fields written to by both producer
> and consumer. 

Hmm, for me the main point was to keep the complete processing
of a single packet within one CPU/Core where this is a non-issue.

> Receiving and sending a lot can be expected to be the 
> common case, so taking a performance hit in this case is hardly a good
> idea.

There is no hit. If you receive/send in bursts you can simply aggregate
them until a certain queueing threshold. 

The queue design outlined can split the queueing in reserve and commit stages,
where the producer can be told how much in can produce and the consumer is
told  how much it can consume. 

Within their areas the producer and consumer can freely move around.
So this is not exactly a queue, but a dynamic double buffer :-)

So maybe doing queueing with the classic head/tail variant is better here,
but the other variant might replace it without problems and allows
for some nice improvements.


Regards

Ingo Oeser
