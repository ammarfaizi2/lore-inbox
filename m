Return-Path: <linux-kernel-owner+w=401wt.eu-S1754868AbWL1PZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754868AbWL1PZO (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 10:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754870AbWL1PZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 10:25:13 -0500
Received: from gw-e.panasas.com ([65.194.124.178]:55205 "EHLO
	cassoulet.panasas.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754868AbWL1PZM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 10:25:12 -0500
Message-ID: <4593E1B7.6080408@panasas.com>
Date: Thu, 28 Dec 2006 17:24:39 +0200
From: Benny Halevy <bhalevy@panasas.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       Jan Harkes <jaharkes@cs.cmu.edu>, Miklos Szeredi <miklos@szeredi.hu>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       nfsv4@ietf.org
Subject: Re: Finding hardlinks
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz>	 <E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu>	 <20061221185850.GA16807@delft.aura.cs.cmu.edu>	 <Pine.LNX.4.64.0612220038520.4677@artax.karlin.mff.cuni.cz>	 <1166869106.3281.587.camel@laptopd505.fenrus.org>	 <Pine.LNX.4.64.0612231458060.5182@artax.karlin.mff.cuni.cz>	 <4593890C.8030207@panasas.com> <1167300352.3281.4183.camel@laptopd505.fenrus.org>
In-Reply-To: <1167300352.3281.4183.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Dec 2006 15:24:23.0051 (UTC) FILETIME=[4096F5B0:01C72A94]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>> It seems like the posix idea of unique <st_dev, st_ino> doesn't
>> hold water for modern file systems 
> 
> are you really sure?

Well Jan's example was of Coda that uses 128-bit internal file ids.

> and if so, why don't we fix *THAT* instead

Hmm, sometimes you can't fix the world, especially if the filesystem
is exported over NFS and has a problem with fitting its file IDs uniquely
into a 64-bit identifier.

> rather than adding racy
> syscalls and such that just can't really be used right...
> 

If the syscall is working on two pathnames I agree there might be a race
that isn't different from calling lstat() on each of these names
before opening them. But I'm not sure I see a race if you operate on two
open file descriptors (compared to fstat()ing both of them)

On the nfs side, if the client looked up two names (or opened them over nfsv4)
and has two filehandles in hand, asking the server whether they refer to the
same object isn't racy.

