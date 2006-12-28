Return-Path: <linux-kernel-owner+w=401wt.eu-S1754913AbWL1SOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754913AbWL1SOu (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 13:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754910AbWL1SOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 13:14:50 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:45961 "EHLO
	artax.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754896AbWL1SOt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 13:14:49 -0500
Date: Thu, 28 Dec 2006 19:14:48 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Benny Halevy <bhalevy@panasas.com>, Jan Harkes <jaharkes@cs.cmu.edu>,
       Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, nfsv4@ietf.org
Subject: Re: Finding hardlinks
In-Reply-To: <1167300352.3281.4183.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.64.0612281909200.2960@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz> 
 <E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu>  <20061221185850.GA16807@delft.aura.cs.cmu.edu>
  <Pine.LNX.4.64.0612220038520.4677@artax.karlin.mff.cuni.cz> 
 <1166869106.3281.587.camel@laptopd505.fenrus.org> 
 <Pine.LNX.4.64.0612231458060.5182@artax.karlin.mff.cuni.cz> 
 <4593890C.8030207@panasas.com> <1167300352.3281.4183.camel@laptopd505.fenrus.org>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Dec 2006, Arjan van de Ven wrote:

>
>> It seems like the posix idea of unique <st_dev, st_ino> doesn't
>> hold water for modern file systems
>
> are you really sure?
> and if so, why don't we fix *THAT* instead, rather than adding racy
> syscalls and such that just can't really be used right...

Why don't you rip off the support for colliding inode number from the 
kernel at all (i.e. remove iget5_locked)?

It's reasonable to have either no support for colliding ino_t or full 
support for that (including syscalls that userspace can use to work with 
such filesystem) --- but I don't see any point in having half-way support 
in kernel as is right now.

As for syscall races --- if you pack something with tar and the directory 
changes underneath, you can't expect sane output anyway.

Mikulas
