Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751648AbWADKML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbWADKML (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 05:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751658AbWADKML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 05:12:11 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:29146 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1751648AbWADKMK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 05:12:10 -0500
Message-ID: <43BB9F71.60909@cosmosbay.com>
Date: Wed, 04 Jan 2006 11:12:01 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Andrew Morton <akpm@osdl.org>, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Shrinks sizeof(files_struct) and better layout
References: <20051108185349.6e86cec3.akpm@osdl.org> <437226B1.4040901@cosmosbay.com> <20051109220742.067c5f3a.akpm@osdl.org> <4373698F.9010608@cosmosbay.com> <43BB1178.7020409@cosmosbay.com> <Pine.LNX.4.61.0601041010180.29257@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0601041010180.29257@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Wed, 04 Jan 2006 11:12:02 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt a écrit :
>> 2) Reduces the size of (files_struct), using a special 32 bits (or 64bits)
>> embedded_fd_set, instead of a 1024 bits fd_set for the close_on_exec_init and
>> open_fds_init fields. This save some ram (248 bytes per task)
> 
> 
>> as most tasks dont open more than 32 files.
> 
> How do you know, have you done some empirical testing?
> 
20 years working on Unix/linux machines yes :)

Just try this script on your linux machines :

for f in /proc/*/fd; do ls $f|wc -l;done

more than 95% of tasks have less than 32 concurrent files opened.

(I remember working on AT&T Unix in 1985, with a limit of 20 concurrent files 
per process : it was just fine)

Eric
