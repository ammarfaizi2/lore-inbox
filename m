Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131394AbQKBOEN>; Thu, 2 Nov 2000 09:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131684AbQKBOED>; Thu, 2 Nov 2000 09:04:03 -0500
Received: from ife.ee.ethz.ch ([129.132.29.2]:38486 "EHLO ife.ee.ethz.ch")
	by vger.kernel.org with ESMTP id <S131394AbQKBODv>;
	Thu, 2 Nov 2000 09:03:51 -0500
Message-ID: <3A017443.8E436A97@ife.ee.ethz.ch>
Date: Thu, 02 Nov 2000 15:03:47 +0100
From: Thomas Sailer <sailer@ife.ee.ethz.ch>
Organization: IfE
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: de,fr,ru
MIME-Version: 1.0
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Poll and OSS API
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The OSS API (http://www.opensound.com/pguide/oss.pdf, page 102ff)
specifies that a select _with the sounddriver's filedescriptor
set in the read mask_ should start the recording.

Implementing this is currently not possible, as the driver does
not get to know whether the application had the filedescriptor
set in the select call. Similarily for poll, the driver does not
get the caller's events.

Different drivers do it differently. The ISA SB driver just 
unconditionally starts recording on select, whether the bit
in the read mask is set or not. es137* unconditionally does
not start recording. Both drivers violate the API.

I don't think this is all that important though, because
it's that way for more than a year and the first complaint
reached me yesterday.

Comments?

Tom
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
