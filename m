Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265264AbTF1PHx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 11:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265265AbTF1PHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 11:07:53 -0400
Received: from cs180094.pp.htv.fi ([213.243.180.94]:14976 "EHLO
	hades.pp.htv.fi") by vger.kernel.org with ESMTP id S265264AbTF1PHw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 11:07:52 -0400
Subject: Re: TCP send behaviour leads to cable modem woes
From: Mika Liljeberg <mika.liljeberg@welho.com>
To: Svein Ove Aas <svein.ove@aas.no>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200306281604.52876.svein.ove@aas.no>
References: <200306272020.57502.svein.ove@aas.no>
	 <200306272145.22008.svein.ove@aas.no> <1056743877.681.5.camel@hades>
	 <200306281604.52876.svein.ove@aas.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1056813724.668.23.camel@hades>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 28 Jun 2003 18:22:05 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-06-28 at 17:04, Svein Ove Aas wrote:
> Well, it doesn't appear to have any effect.
> (What is it *supposed* to do? Something about spurious retransmission 
> timeouts, was it?)

Yeah, frto should help if you're seeing unnecessary retransmission
timeouts caused by delay spikes. It won't do much good if you're also
losing packets, e.g., due to overflowing the modem buffers. From what I
gathered from your explanation, the cable link might also be bunching up
the incoming ACK packets into bursts, each of which causes the sending
TCP to inject a corresponding burst of new segments into the network. If
that's what is happening, rate capping is probably more effective. Even
if you set the rate cap a little high it should mitigate the effects of
the bursts.

	MikaL

