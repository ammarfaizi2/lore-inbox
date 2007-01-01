Return-Path: <linux-kernel-owner+w=401wt.eu-S932575AbXAAXxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932575AbXAAXxo (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 18:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932583AbXAAXxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 18:53:44 -0500
Received: from gate.crashing.org ([63.228.1.57]:45045 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932575AbXAAXxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 18:53:43 -0500
In-Reply-To: <20070101.150831.17863014.davem@davemloft.net>
References: <445cb4c27a664491761ce4e219aa0960@kernel.crashing.org> <20070101.005714.35017753.davem@davemloft.net> <385664dfd55cfdfb9f9651fc90bf46b0@kernel.crashing.org> <20070101.150831.17863014.davem@davemloft.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <a54f3f0a00e6e50cfd3ce90995943960@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, devel@laptop.org, dmk@flex.com,
       wmb@firmworks.com, hch@infradead.org, jg@laptop.org
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
Date: Tue, 2 Jan 2007 00:52:36 +0100
To: David Miller <davem@davemloft.net>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> If you *really* want (the option of) showing things as text
>> in the filesystem, you better make it so that there is a
>> one-to-one translation back to binary.  For example, what
>> does this mean, is it a text string or two bytes:
>>
>> 01.02
>>
>> Yes you as a user can guess, but scripts can't (reliably).
>
> We have some extensive code in fs/openpromfs/inode.c that
> determines whether a property is text or not.  I can't
> guarentee it works %100, but it's very context dependant
> (only the driver "knows") but it works for all the cases
> I've tried.

It's still a heuristic, I don't think the kernel should be
doing things like this; leave the guesswork to userland,
where different users can guess in different ways if they
want/need.

Some real life properties contain _both_ a binary part and
a text part, btw.

> I really think you're making a mountain out of a mole hill, to be
> honest :-)

Heh.  There is one big problem: text representation is useless
(to scripts etc.) unless it can be transformed back to binary;
i.e., it has to be possible to reliably detect _how_ some
property is represented into text, something that cannot be
done with how openpromfs handles it.


Segher

