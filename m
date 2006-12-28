Return-Path: <linux-kernel-owner+w=401wt.eu-S964977AbWL1Sl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbWL1Sl2 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 13:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbWL1Sl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 13:41:27 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:28367 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964885AbWL1Sl1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 13:41:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=YWeYab0RFmSNH4f6dX+Jb6kULRs9K/GDAC4hzlXyWlnP4udRxBGVMJVnh5BSb5iLM7Z+tc9Sl5stUlmtLIvt943VDa4Dn4yclSMbbOgnFJcrC9w1eiyj1x63N3C55UbKnfpNZdkcD9Q3cmcLI7mUasgGD7XXq39e80DSQs9FlK0=
Message-ID: <80ec54e90612281041q3b2c2bcemb0308c1e89a29ac@mail.gmail.com>
Date: Thu, 28 Dec 2006 19:41:25 +0100
From: "=?ISO-8859-1?Q?Daniel_Marjam=E4ki?=" <daniel.marjamaki@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Want comments regarding patch
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all!

I sent a patch with this content:

-       for (i = 0; i < MAX_PIRQS; i++)
-               pirq_entries[i] = -1;
+       memset(pirq_entries, -1, sizeof(pirq_entries));

I'd like to know if you have any comments to this change. It was of
course my intention to make the code shorter, simpler and faster.

I've discussed this with Ingo Molnar and here's our conversation:

INGO:

hm, i'm not sure i like this - the '-1' in the memset is for a byte,
while the pirq_entries are word sized. It should work because the bytes
happen to be 0xff for the word too, but this is encodes an assumption,
and were we ever to change that value it could break silently. gcc ought
to be able to figure out the best way to initialize the array.


DANIEL:

Thank you for the comments.

I understand your point, it's good. But I personally still like my
method better.
For me -1 is just as valid as an argument as 0. As you note however,
it assumes that the next developer understands the encoding of
negative numbers. A developer who doesn't know the encoding could be
very confused. Would my patch be ok if I used '0xff' instead of '-1'?

With version 3.3.6 (gcc) there's quite a big difference in the
assembly code (between 'for' and 'memset').

INGO:

0xff might be better, but i'm still uneasy about it ... No other piece
of code within the kernel does this.

could you post the patch and the reasoning to
linux-kernel@vger.kernel.org as well? That way others can chime in as
well.
