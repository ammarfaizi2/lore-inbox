Return-Path: <linux-kernel-owner+w=401wt.eu-S964913AbXABXg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbXABXg2 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 18:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752742AbXABXg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 18:36:28 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:45304
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752710AbXABXg1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 18:36:27 -0500
Date: Tue, 02 Jan 2007 15:36:26 -0800 (PST)
Message-Id: <20070102.153626.14976011.davem@davemloft.net>
To: daniel.marjamaki@gmail.com
Cc: netdev@vger.kernel.org, kernel-janitors@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/core/flow.c: compare data with memcmp
From: David Miller <davem@davemloft.net>
In-Reply-To: <80ec54e90701010116u27d02341kb2be785f17f18e3d@mail.gmail.com>
References: <20061231.123715.115911390.davem@davemloft.net>
	<80ec54e90612312347w2b906e5eg725a7761110c6897@mail.gmail.com>
	<80ec54e90701010116u27d02341kb2be785f17f18e3d@mail.gmail.com>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Daniel_Marjamäki" <daniel.marjamaki@gmail.com>
Date: Mon, 1 Jan 2007 10:16:02 +0100

> I have done a little testing on my own. My results is that memcpy is
> many times faster even with aligned data.

Your test program doesn't make any measurements, from where did
you get these "results"?

Also, your test program is broken because in the memcmp() case GCC
totally optimizes away the call to memcmp() because it can see the
comparison data at compile time and therefore it computes the memcmp()
result at compile time.  There are no memcmp() calls made at all by
your program.

You should look at the assembler code emitted by a test program
that is measuring performance, in detail, to make sure the test
program really is doing what you think it is.
