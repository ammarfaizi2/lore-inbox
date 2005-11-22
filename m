Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964960AbVKVPVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964960AbVKVPVz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 10:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964961AbVKVPVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 10:21:55 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:26027 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964960AbVKVPVx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 10:21:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S9Kp7u2cCs5gBEtAhWW6LwksAmsS7yK9jQbZoMQuAFa2uvjW5tzoCBfV6///z3to+7WnDAumW4gbgCNsW2XmyoaMtnpGCg7rxTWDKkQg4mFV1q54bsYddXGFOxrLfkDGGBt+jQE61+NDrGCwAIQAG0KWNvhEcODsewlQi3wod18=
Message-ID: <625fc13d0511220721m3a6ad3ebp21b28a6b331ca05a@mail.gmail.com>
Date: Tue, 22 Nov 2005 09:21:52 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: Franck <vagabon.xyz@gmail.com>
Subject: Re: How can I prevent MTD to access the end of a flash device ?
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <cda58cb80511220658n671bc070v@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <cda58cb80511070248o6d7a18bex@mail.gmail.com>
	 <cda58cb80511220658n671bc070v@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/05, Franck <vagabon.xyz@gmail.com> wrote:
> Hi,
>
> I have two questions that I can't answer by my own. I tried to look at
> FAQ and documentation on MTD website but found no answer.
>
> First question is about size of flash. I have a Intel strataflash
> whose size is 32MB but because of a buggy platform hardware I can't
> access to the last 64KB of the flash. How can I make MTD module aware
> of this new size. The restricted map size is initialized by my driver
> but it doesn't seem to be used by MTD.

The chip driver will detect a 32MiB chip from the CFI probe.  The map
size isn't really used by the chip driver, it's just needed to ensure
that the area is accessible.  What you could try doing is adding a
cfi_fixup function that changes the CFI data read in to remove the
last 64KiB of the chip...  not sure if that will work though.

> The second question is about the "cacheable" mapping field in map_info
> structure. I looked at others drivers and this field seems to be
> optional. Does this field, if set, improve flash access a lot ? Should
> I set up a cacheable mapping ?

Usually this isn't something you want to do especially with flash.  If
a cache line is flushed back to the chip it's probably not going to
work.  The cacheable mappings work for RAM based devices though.

josh
