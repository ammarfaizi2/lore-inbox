Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268460AbTBYXgd>; Tue, 25 Feb 2003 18:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268461AbTBYXgd>; Tue, 25 Feb 2003 18:36:33 -0500
Received: from palrel11.hp.com ([156.153.255.246]:9914 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id <S268460AbTBYXgb>;
	Tue, 25 Feb 2003 18:36:31 -0500
Date: Tue, 25 Feb 2003 15:46:46 -0800
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Invalid compilation without -fno-strict-aliasing
Message-ID: <20030225234646.GB30611@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

	It looks like a compiler bug to me...
	Some users have complained that when the following code is
compiled without the -fno-strict-aliasing, the order of the write and
memcpy is inverted (which mean a bogus len is mem-copied into the
stream).
	Code (from linux/include/net/iw_handler.h) :
--------------------------------------------
static inline char *
iwe_stream_add_event(char *	stream,		/* Stream of events */
		     char *	ends,		/* End of stream */
		     struct iw_event *iwe,	/* Payload */
		     int	event_len)	/* Real size of payload */
{
	/* Check if it's possible */
	if((stream + event_len) < ends) {
		iwe->len = event_len;
		memcpy(stream, (char *) iwe, event_len);
		stream += event_len;
	}
	return stream;
}
--------------------------------------------
	IMHO, the compiler should have enough context to know that the
reordering is dangerous. Any suggestion to make this simple code more
bullet proof is welcomed.

	Have fun...

	Jean
