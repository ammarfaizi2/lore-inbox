Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267871AbUHPSug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267871AbUHPSug (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 14:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267889AbUHPSuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 14:50:35 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:4467 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267871AbUHPStv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 14:49:51 -0400
Message-ID: <311601c904081611491c23207d@mail.gmail.com>
Date: Mon, 16 Aug 2004 12:49:47 -0600
From: Eric Mudama <edmudama@gmail.com>
Reply-To: Eric Mudama <edmudama@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Re: Any news on a higher performance sata_sil SIL_QUIRK_MOD15WRITE workaround?
Cc: Clem Taylor <clemtaylor@comcast.net>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1092399186.24406.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <411AFD2C.5060701@comcast.net> <411B118B.4040802@pobox.com>
	 <411C4130.4000303@comcast.net> <1092399186.24406.15.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure about "affected" drives, but the issue as Jeff pointed
out is that SI3112/3114 send write data to the host in non-multiples
of 512 bytes, if the command exceeds 15 LBAs in size.

Up to 15*512 bytes gives you a single FIS of 15*512, for anything
larger they have an internal algorithm that is pretty easy to figure
out with a bus trace.

To work with drives that aren't capable of handling this, you can't
issue writes > 15 LBAs to the drive, hence the blacklist/workaround.

--eric
