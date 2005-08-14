Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932473AbVHNKPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbVHNKPq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 06:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbVHNKPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 06:15:46 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:59268 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S932473AbVHNKPp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 06:15:45 -0400
Message-ID: <42FF19AC.6010502@colorfullife.com>
Date: Sun, 14 Aug 2005 12:15:08 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.10) Gecko/20050719 Fedora/1.7.10-1.5.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Teemu Koponen <tkoponen@iki.fi>
CC: linux-kernel@vger.kernel.org
Subject: Re: Opening of blocking FIFOs not reliable?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Teemu wrote:

>Opening a FIFO for WR_ONLY should release a previously blocked RD_ONLY 
>open. I suspect this is not guaranteed on a heavily loaded Linux box.
>  
>
Do you have a test case?
IIRC we had that bug, and it was fixed by adding PIPE_WCOUNTER:
PIPE_WRITERS counts the number of writers. This one is decreased during 
close(). PIPE_WCOUNTER counts how often a writer was seen. It's never 
decreased. Readers that wait for a writer wait until PIPE_WCOUNTER 
changes, they do not look at PIPE_WRITERS.

--
    Manfred
