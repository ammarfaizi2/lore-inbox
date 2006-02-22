Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbWBVEYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbWBVEYz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 23:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWBVEYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 23:24:55 -0500
Received: from gw.bendigoit.com.au ([203.16.207.254]:55258 "EHLO
	trantor.sbss.com.au") by vger.kernel.org with ESMTP
	id S1751335AbWBVEYy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 23:24:54 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Subject: flawed assumption in via-rhine (or bug in skb_pad)?
Date: Wed, 22 Feb 2006 15:24:12 +1100
Message-ID: <AEC6C66638C05B468B556EA548C1A77DAF098F@trantor>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: flawed assumption in via-rhine (or bug in skb_pad)?
thread-index: AcY3Z9UVkpL54wP1S+6SRU85h6STqg==
From: "James Harper" <james.harper@bendigoit.com.au>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Should the 'len' field of an skb be updated by a call to skb_pad? I'm
guessing not...

The via-rhine drive does a skb_padto (which in turn calls skb_pad) to
ensure that the skb contains enough bits to satisfy the ethernet minimum
packet size, but then it goes and uses skb->len everywhere else, which
seems like it is assuming that skb->len is incrememted...

The documentation in via-rhine (which I can only assume is correct)
specifically states that the hardware does not do padding, so the driver
would have to explicitly bump the length.

Whatever the cause, I'm getting runt frames and I don't like it :)

Thanks

James

