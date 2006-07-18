Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbWGRSg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbWGRSg2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 14:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWGRSg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 14:36:28 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:55436 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S932347AbWGRSg1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 14:36:27 -0400
Message-ID: <44BD2A29.8060405@dgreaves.com>
Date: Tue, 18 Jul 2006 19:36:25 +0100
From: David Greaves <david@dgreaves.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>
Cc: Martin Filip <bugtraq@smoula.net>, linux-kernel@vger.kernel.org
Subject: Re: NFS and partitioned md
References: <1151355145.4460.16.camel@archon.smoula-in.net>	<17568.31894.207153.563590@cse.unsw.edu.au>	<1151432312.11996.32.camel@reaver.netbox-in.cz> <17571.19699.980491.970386@cse.unsw.edu.au>
In-Reply-To: <17571.19699.980491.970386@cse.unsw.edu.au>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> On Tuesday June 27, bugtraq@smoula.net wrote:
>> Hi,
>>
>> thx for your interrest,
>>
>> Neil Brown pí¹e v Út 27. 06. 2006 v 10:32 +1000:
>>> So I suspect there is something else going on that has nothing to do
>>> with the usage of partitioned md.... then again, maybe there is some
>>> weird sign extension happening to '254' somewhere, though that would
>>> be terribly strange.
>> (as I look on that it comes on my mind, that problem could be minor
>> longer than 1 byte)
>>
> 
> Exactly.  4105 > 256.  Such devices need a different format filehandle
> which didn't work until very recently due to a bug (obviously no-one
> tried it until recently).
> 
> The patch below fixes the kernel so that this will work.
> Alternately use md_d0 md_d1, md_d2, or md_d3.  Then it will work with
> no patches.

FWIW (and google) I have just encountered this problem on 2.6.16.9 server.

My error message with the NFS mount failing was:
mount teak:/media /mnt/test
mount: teak:/media: can't read superblock

teak:~# ll /dev/media*
brw-rw---- 1 root disk 254, 8128 2006-07-18 18:39 /dev/media
brw-rw---- 1 root disk 254, 8129 2006-07-18 18:39 /dev/media1
brw-rw---- 1 root disk 254, 8130 2006-07-18 18:39 /dev/media2
brw-rw---- 1 root disk 254, 8131 2006-07-18 18:39 /dev/media3
brw-rw---- 1 root disk 254, 8132 2006-07-18 18:39 /dev/media4

I rebooted to use /dev/md_d0 and /dev/md_d0p1 and it's fine.

David
