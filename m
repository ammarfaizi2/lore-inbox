Return-Path: <linux-kernel-owner+w=401wt.eu-S1753609AbXAAWrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753609AbXAAWrK (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 17:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753792AbXAAWrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 17:47:10 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:54807 "EHLO
	artax.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753280AbXAAWrI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 17:47:08 -0500
Date: Mon, 1 Jan 2007 23:47:06 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Arjan van de Ven <arjan@infradead.org>, Jan Harkes <jaharkes@cs.cmu.edu>,
       Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: Finding hardlinks
In-Reply-To: <20061229100223.GF3955@ucw.cz>
Message-ID: <Pine.LNX.4.64.0701012333380.5162@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz>
 <E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu> <20061221185850.GA16807@delft.aura.cs.cmu.edu>
 <Pine.LNX.4.64.0612220038520.4677@artax.karlin.mff.cuni.cz>
 <1166869106.3281.587.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.64.0612231458060.5182@artax.karlin.mff.cuni.cz>
 <20061229100223.GF3955@ucw.cz>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>>>> If user (or script) doesn't specify that flag, it
>>>> doesn't help. I think
>>>> the best solution for these filesystems would be
>>>> either to add new syscall
>>>> 	int is_hardlink(char *filename1, char *filename2)
>>>> (but I know adding syscall bloat may be objectionable)
>>>
>>> it's also the wrong api; the filenames may have been
>>> changed under you
>>> just as you return from this call, so it really is a
>>> "was_hardlink_at_some_point()" as you specify it.
>>> If you make it work on fd's.. it has a chance at least.
>>
>> Yes, but it doesn't matter --- if the tree changes under
>> "cp -a" command, no one guarantees you what you get.
>> 	int fis_hardlink(int handle1, int handle 2);
>> Is another possibility but it can't detect hardlinked
>> symlinks.
>
> Ugh. Is it even legal to hardlink symlinks?

Why it shoudln't be? It seems to work quite fine in Linux.

> Anyway, cp -a is not the only application that wants to do hardlink
> detection.

I tested programs for ino_t collision (I intentionally injected it) and 
found that CP from coreutils 6.7 fails to copy directories but displays 
error messages (coreutils 5 work fine). MC and ARJ skip directories with 
colliding ino_t and pretend that operation completed successfuly. FTS 
library fails to walk directories returning FTS_DC error. Diffutils, find, 
grep fail to search directories with coliding inode numbers. Tar seems 
tolerant except incremental backup (which I didn't try). All programs 
except diff were tolerant to coliding ino_t on files.

ino_t is no longer unique in many filesystems, it seems like quite serious 
data corruption possibility.

Mikulas

> 						Pavel
