Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268292AbUH3ShK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268292AbUH3ShK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 14:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268161AbUH3Saz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 14:30:55 -0400
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:64271 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id S268886AbUH3S03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 14:26:29 -0400
Message-ID: <41337153.60505@superbug.demon.co.uk>
Date: Mon, 30 Aug 2004 19:26:27 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040812)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: Rogier Wolff <R.E.Wolff@harddisk-recovery.nl>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Driver retries disk errors.
References: <20040830163931.GA4295@bitwizard.nl> <20040830174632.GA21419@thunk.org>
In-Reply-To: <20040830174632.GA21419@thunk.org>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:
> On Mon, Aug 30, 2004 at 06:39:31PM +0200, Rogier Wolff wrote:
> 
>>We encounter "bad" drives with quite a lot more regularity than other
>>people (look at the Email address). We're however, wondering why the
>>IDE code still retries a bad block 8 times? 
> 
> 
> I could see retrying 2 or 3 times, but 8 times does seem to be a bit
> much, agreed.
> 
> 
>>In fact we regularly are able to recover data from drives: we have a
>>userspace application that retries over and over again, and this
>>sometimes recovers "marginal" blocks. This could be considered "good
>>practise" if there is a filesystem requesting the block. On the other
>>hand, when this happens, the drive is usually beyond being usable for
>>a filesystem: if we recover one block this way, the next block will be
>>errorred and the filesystem "crashes" anyway. In fact this behaviour
>>may masquerade the first warnings that something is going wrong....
> 
> 
> If the block gets successfully read after 2 or 3 tries, it might be a
> good idea for the kernel to automatically do a forced rewrite of the
> block, which should cause the disk to do its own disk block
> sparing/reassignment.  
> 
> 						- Ted

It does the same retries with CD-ROM and DVDs, and if the retries fail, 
it disables DMA! It even does the retries when reading CD-Audio.
Maybe there should be a "retrys" setting that can be set by hdparm, then 
we could set the retry counts, and what happens when a retry fails on a 
per device basis.

