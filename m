Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937632AbWLFUvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937632AbWLFUvI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 15:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937633AbWLFUvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 15:51:08 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:26523 "EHLO iradimed.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S937632AbWLFUvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 15:51:05 -0500
Message-ID: <45772D56.5020600@cfl.rr.com>
Date: Wed, 06 Dec 2006 15:51:34 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: "Magnus Naeslund(k)" <mag@kite.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6 tmpfs/swap performance oddity
References: <457706CB.20802@kite.se>
In-Reply-To: <457706CB.20802@kite.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Dec 2006 20:51:18.0984 (UTC) FILETIME=[47824C80:01C71978]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14858.000
X-TM-AS-Result: No--7.937600-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Magnus Naeslund(k) wrote:
> But tmpfs seems to get really slow when it has to swap out stuff from
> tmp to a 80 gb swap partition, much slower than just writing a file
> to the ext3 fs. Maybe this is a known thing, and easily tuned, but
> I've not seen any solutions when googling around.

This is a SWAG ( Silly Wild Ass Guess ), but maybe tmpfs isn't mapping 
the files sequentially in ram, or is otherwise doing something to 
prevent proper swap clustering and read ahead?

> Somehow I think I'm missing something here, maybe we're not supposed
> to use tmpfs in this way at all? What more information can I supply
> to narrow down the problem? Is there any secret knobs that I can use
> to tune swap performance?

You aren't supposed to be using tmpfs in this way at all ;)

tmpfs is meant to hold small files that will only exist for a short 
time, or do not need to persist after a reboot.  Keep your big data 
files on a normal filesystem, and let the kernel worry about caching the 
most frequently accessed parts.

