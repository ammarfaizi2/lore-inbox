Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289866AbSBKRhG>; Mon, 11 Feb 2002 12:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289865AbSBKRgx>; Mon, 11 Feb 2002 12:36:53 -0500
Received: from eventhorizon.antefacto.net ([193.120.245.3]:32963 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S289866AbSBKRgg>; Mon, 11 Feb 2002 12:36:36 -0500
Message-ID: <3C67FFC5.7020701@antefacto.com>
Date: Mon, 11 Feb 2002 17:30:45 +0000
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us
MIME-Version: 1.0
To: William Stearns <wstearns@pobox.com>
CC: Larry McVoy <lm@bitmover.com>,
        ML-linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [bk patch] Make cardbus compile in -pre4
In-Reply-To: <Pine.LNX.4.33.0202092358500.1868-100000@sparrow.websense.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Stearns wrote:
> Good day, Larry,
> 
> On Sat, 9 Feb 2002, Larry McVoy wrote:
> 
> 
>>On Sat, Feb 09, 2002 at 01:01:34PM -0800, David Lang wrote:
>>
>>>do you have a script that can go back after the fact and see what can be
>>>hardlinked?
>>>
>>>I'm thinking specififcly of the type of thing that will be happening to
>>>your server where you have a bunch of people putting in a clone of one
>>>tree who will probably not be doing a clone -l to set it up, but who could
>>>have and you want to clean up after the fact (and perhapse again on a
>>>periodic basis, becouse after all of these trees apply a changeset from
>>>linus they will all have changed (breaking the origional hardlinks) but
>>>will still be duplicates of each other.
>>>
>>We don't, but we can, and we should.  "bk relink tree1 tree2" seems like 
>>the right interface.
>>
>>Right now we aren't too worried about the disk space, the data is sitting 
>>on a pair of 40GB drives and we're running the trees in gzip mode, so they
>>are 75MB each.  But yes, it's a good idea, we should do it, and probably
>>should figure out some way to make it automatic.  I'll add it to the
>>(ever growing) list, thanks.
>>
> 
> 	Larry, I'll save you the time.
> 	"freedups -a -d /some/dir [/other/dirs]" will look for identical
> files (the -d requires dates to be equal as well as the content) and
> hardlink them.  It's not terribly efficient, but works marvelously well.  
> Run it from cron once a week or so, perhaps?
> 	http://www.stearns.org/freedups/
> 	Cheers,
> 	- Bill


Not terribly efficient? That's a bit of an understatement :-)
The findup component of fslint is MUCH quicker, and it's
also written in bash. A quick test against two 2.4.17 trees gives:

1m36s for  ./findup /usr/src/linux[12] | ./fstool/mergeDup
18m17s for ./freedups -a /usr/src/linux[12]

Note mergeDup was a quick hack and took 1m30s of findup's time!
I'm going to rewrite it in python ASAP to help with this.

You can download the current version of fslint from
http://developers.antefacto.net/~padraig/fslint.tar.gz

Padraig.

