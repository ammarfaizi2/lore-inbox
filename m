Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263098AbVGNSgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263098AbVGNSgT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 14:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263082AbVGNSgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 14:36:10 -0400
Received: from ns1.suse.de ([195.135.220.2]:17551 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S263083AbVGNSfv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 14:35:51 -0400
Message-ID: <42D6B09F.2090800@suse.de>
Date: Thu, 14 Jul 2005 20:36:15 +0200
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050322 Thunderbird/1.0.2 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andy Isaacson <adi@hexapodia.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: resuming swsusp twice
References: <20050713185955.GB12668@hexapodia.org> <42D67D84.2020306@suse.de> <20050714175447.GA16651@hexapodia.org>
In-Reply-To: <20050714175447.GA16651@hexapodia.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Isaacson wrote:

> Perhaps the image should be more rigorously checked?  I'm wishing that
> it would verify that the header and the image matched, after it finishes

in your case, the header and the image matched. There was no new image
on disk. And no new header.

> reading the image.  For example, computing the hash
> 
> MD5(header || image)     (|| denotes "concatenate" in crypto pseudocode.)
> 
> and storing that hash in a final trailing block.  Additionally, of
> course, as soon as the resume has read the image it should overwrite the
> header; and the header should include jiffies or something along those

the header is actually overwritten _prior_ to reading the image back. Or
it should be, obviously it was not in your casee.

> lines to ensure that it won't accidentally have the same contents as the
> previous image's header.
> 
> The hash doesn't have to be MD5; even a CRC should suffice I think...

But the failure you have seen now - failure to invalidate the resume
header - could also happen as long as we do not fix the reason for your
failure. If we fix it, we don't need additional security nets ;-)

But i have no idea what went wrong for you, i'll have a look at the code
but i doubt that i'll find much of interest.

One thing which would be interesting:
You don't eventually have multiple swap partitions?
-- 
Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, Nürnberg \                    -- Leonard Cohen
