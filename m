Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932482AbVHNKko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbVHNKko (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 06:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932483AbVHNKko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 06:40:44 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:19116 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S932482AbVHNKkn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 06:40:43 -0400
In-Reply-To: <42FF19AC.6010502@colorfullife.com>
References: <42FF19AC.6010502@colorfullife.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5dd81f5a65eb47acb87fcf4953c88bf1@iki.fi>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Teemu Koponen <tkoponen@iki.fi>
Subject: Re: Opening of blocking FIFOs not reliable?
Date: Sun, 14 Aug 2005 03:40:34 -0700
To: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Apple Mail (2.622)
X-Spam-Niksula: No
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 14, 2005, at 3:15, Manfred Spraul wrote:

>> Opening a FIFO for WR_ONLY should release a previously blocked 
>> RD_ONLY open. I suspect this is not guaranteed on a heavily loaded 
>> Linux box.
>>
> Do you have a test case?
> IIRC we had that bug, and it was fixed by adding PIPE_WCOUNTER:
> PIPE_WRITERS counts the number of writers. This one is decreased 
> during close(). PIPE_WCOUNTER counts how often a writer was seen. It's 
> never decreased. Readers that wait for a writer wait until 
> PIPE_WCOUNTER changes, they do not look at PIPE_WRITERS.

Ah, I missed the semantics of WCOUNTER.  True, writer's open should 
always release the reader' s open (as Alan pointed out).

I do have a test application, which experienced dead-locked readers' 
opens before I artificially delayed writers' closes. The application 
runs on PlanetLab, which uses VServer, though. I'll try to construct 
next a minimal test case based on the application and reproduce the 
behavior on a vanilla box...

Teemu

--

