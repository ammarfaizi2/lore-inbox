Return-Path: <linux-kernel-owner+w=401wt.eu-S932838AbXABL1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932838AbXABL1V (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 06:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932848AbXABL1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 06:27:21 -0500
Received: from gate.crashing.org ([63.228.1.57]:59652 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932838AbXABL1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 06:27:21 -0500
In-Reply-To: <20070101.193144.74746471.davem@davemloft.net>
References: <385664dfd55cfdfb9f9651fc90bf46b0@kernel.crashing.org> <20070101.150831.17863014.davem@davemloft.net> <a54f3f0a00e6e50cfd3ce90995943960@kernel.crashing.org> <20070101.193144.74746471.davem@davemloft.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e16f612db37ceee06392a0d7656d4242@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, devel@laptop.org, dmk@flex.com,
       wmb@firmworks.com, hch@infradead.org, jg@laptop.org
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
Date: Tue, 2 Jan 2007 12:26:21 +0100
To: David Miller <davem@davemloft.net>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> There is one big problem: text representation is useless
>> (to scripts etc.) unless it can be transformed back to binary;
>> i.e., it has to be possible to reliably detect _how_ some
>> property is represented into text, something that cannot be
>> done with how openpromfs handles it.
>
> Text is text is text for many propertiers,

Sure some properties contain (or _should_ contain!) just
one simple text string.  You can simply "cat" those when
they are binary in the filesystem too FWIW.

> in particular
> the ones you actually end up wanting to modify.

But that is just one simple use of the filesystem.  One that
doesn't work at all on PowerPC btw -- at kernel run time,
we don't have access to OF at all anymore.

> In order for a problem to exist, you have to show counter
> examples where the problem triggers and something fails.
>
> What in userspace wants to modify a OFW property, which
> is not text?

I never was talking about modifying.  Most things that
most users want to modify aren't normal OF properties
anyway, but configuration variables.  In some/many OF
implementations updating those via the device tree doesn't
work.

> In my experience all such cases are limited to ASCII text
> valued properties, such as device aliases, environment
> variables, and things like nvramrc.

If the text representation in the file system was unambiguous,
it wouldn't be useless for scripts anymore, merely very
inconvenient.


Segher

