Return-Path: <linux-kernel-owner+w=401wt.eu-S1754833AbWLVNQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754833AbWLVNQL (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 08:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754832AbWLVNQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 08:16:11 -0500
Received: from mercury.sdinet.de ([193.103.161.30]:46701 "EHLO
	mercury.sdinet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754835AbWLVNQK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 08:16:10 -0500
Date: Fri, 22 Dec 2006 14:16:08 +0100 (CET)
From: Sven-Haegar Koch <haegar@sdinet.de>
To: Andrey Borzenkov <arvidjaar@mail.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19: File system corruption "stuck" until device is replugged
In-Reply-To: <200612220759.11961.arvidjaar@mail.ru>
Message-ID: <Pine.LNX.4.64.0612221410300.21828@mercury.sdinet.de>
References: <200612220759.11961.arvidjaar@mail.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Dec 2006, Andrey Borzenkov wrote:

> I had USB stick (fat32) that reported file system corruption on mount and
> hence was mounted read-only. No amount of umount/dosfsck/mount could make it
> rw again. dosfsck reported device as clean but it still would mount ro and I
> continued to see directory that had been deleted by the very first dosfsck
> run! I unplugged it, looked under Win2k - it was OK - and only then did I
> notice that directory claimed as corrupted did not even exist. Replugging
> it - mounted OK.
>
> I am not sure if this is a bug or "work as designed". May be this is specific
> fat32 problem; still it does not look right?

I think at the first mount time there was a read error for an unknown 
reason, and this turned the partition (not the filesystem) into read-only 
mode. All further mount attempts only found a read-only medium, and thus 
where only able to mount read-only. I've been bitten by this more than 
once, too - there seems to be no way to avoid a reboot/replug when one of 
your data disks has thrown a read error, taking (for me) the whole server 
down, when just one unimportant data-disk thinks it has problems again (as 
happens with my home-server about once every one or two weeks).

c'ya
sven

-- 

The Internet treats censorship as a routing problem, and routes around it.
(John Gilmore on http://www.cygnus.com/~gnu/)
