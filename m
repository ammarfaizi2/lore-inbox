Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265995AbUAVFSp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 00:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266092AbUAVFSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 00:18:44 -0500
Received: from mail-04.iinet.net.au ([203.59.3.36]:46824 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265995AbUAVFSA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 00:18:00 -0500
Message-ID: <400F5CE5.6000602@cyberone.com.au>
Date: Thu, 22 Jan 2004 16:17:25 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Deadline for video capture
References: <200401221608.05924.kernel@kolivas.org>
In-Reply-To: <200401221608.05924.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Con Kolivas wrote:

>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>Hi all
>
>I suspected that the anticipatory scheduler might not have been the best 
>choice for video capture because of the interruption to writes by reads and 
>the subsequent anticipatory delay associated with it.  I have now confirmed 
>that booting with the default anticipatory i/o elevator I get many dropped 
>frames that I don't get if I boot with elevator=deadline. 
>
>briefly: dual 7200 rpm ATA5 IDE drives in software RAID0
>
>I guess there isn't really a lot to do about this, it's a compromise one way 
>or the other. The anticipatory scheduler seems better all round but in this 
>large streaming write situation it doesn't seem ideal. Any sysctl settings I 
>could use to blunt the anticipation just before I do video capture?
>

echo 0 > /sys/block/*/queue/iosched/antic_expire
Turns it off alltogether.

You could also adjust read and write batch expire settings which are
heavily biased toward reads.


