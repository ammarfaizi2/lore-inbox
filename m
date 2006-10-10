Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbWJJS7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWJJS7t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 14:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbWJJS7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 14:59:49 -0400
Received: from mail.uni-bonn.de ([131.220.15.112]:32149 "EHLO uni-bonn.de")
	by vger.kernel.org with ESMTP id S1751092AbWJJS7s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 14:59:48 -0400
X-Hashcash: 1:20:061010:linux-ide@vger.kernel.org::0dvKfaXkNuPZJRNF:0000000000000000000000000000000000002T4I
X-Hashcash: 1:20:061010:hdaps-devel@sourceforge.net::aIqmjo5z0T0i0Z7z:000000000000000000000000000000000044fA
From: Elias Oltmanns <oltmanns@uni-bonn.de>
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org, hdaps-devel@sourceforge.net
Subject: Re: Debugging strange system lockups possibly triggered by ATA commands
References: <741Eo-2m9-5@gated-at.bofh.it> <742hc-4n3-25@gated-at.bofh.it>
X-Hashcash: 1:20:061009:linux-kernel@vger.kernel.org::uC6PT4Bocxz1fFDz:000000000000000000000000000000000Dfz+
Mail-Copies-To: nobody
Mail-Followup-To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
	hdaps-devel@sourceforge.net
Date: Tue, 10 Oct 2006 20:58:30 +0200
Message-ID: <87ejtgatgp.fsf@denkblock.local>
User-Agent: Gnus/5.110006 (No Gnus v0.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shem,

"Shem Multinymous" <multinymous@gmail.com> wrote:
> Hi Elias,
>
> On 10/9/06, Elias Oltmanns <oltmanns@uni-bonn.de> wrote:
>
>> A slightly stripped version of the patch is available too, which has
>> been verified to trigger the described problem in exactly the same way
>> as the original but lacks the IDLE IMMEDIATE feature (leaving the
>> STANDBY IMMEDIATE option only) in order to make it (hopefully) more
>> readable and easier to understand.
>
> What happens if you strip away *all* the head parking code, leaving
> only the queue freeze code? Conversely, what happens if you issue the
> head park command but don't freeze the queue?

In all setups the loop
# while true; do hdparm -q -y /dev/hda; hdparm -q -C /dev/hda; done
didn't trigger the freeze. This should be very close to the effect of
the patch with all queue freezing stuff removed.

Regarding your question, it seems rather difficult to test the right
thing. Just issuing the commands and leaving the queue alone is easy
to implement and I couldn't reproduce the problem running such a
kernel. Testing the queue handling stuff without actually issuing any
commands seems rather difficult to me as its the callback mechanism
used to freeze the queue after command completion which I'd really
like to test. If I don't issue any command, I don't know how to test
whether the callback procedure and all the rest works as expected.

Regards,

Elias
