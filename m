Return-Path: <linux-kernel-owner+w=401wt.eu-S1161156AbXAHF5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161156AbXAHF5K (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 00:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161166AbXAHF5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 00:57:09 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:57347 "EHLO
	artax.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161156AbXAHF5I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 00:57:08 -0500
Date: Mon, 8 Jan 2007 06:57:06 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: pavel@ucw.cz, matthew@wil.cx, bhalevy@panasas.com, arjan@infradead.org,
       jaharkes@cs.cmu.edu, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, nfsv4@ietf.org
Subject: Re: Finding hardlinks
In-Reply-To: <E1H2qhP-0007qc-00@dorka.pomaz.szeredi.hu>
Message-ID: <Pine.LNX.4.64.0701080652220.3506@artax.karlin.mff.cuni.cz>
References: <4593E1B7.6080408@panasas.com> <E1H01Og-0007TF-00@dorka.pomaz.szeredi.hu>
 <20070102191504.GA5276@ucw.cz> <E1H1qRa-0001t7-00@dorka.pomaz.szeredi.hu>
 <20070103115632.GA3062@elf.ucw.cz> <E1H25JD-0003SN-00@dorka.pomaz.szeredi.hu>
 <20070103135455.GA24620@parisc-linux.org> <E1H28Oi-0003kw-00@dorka.pomaz.szeredi.hu>
 <20070104225929.GC8243@elf.ucw.cz> <E1H2kfa-0007Jl-00@dorka.pomaz.szeredi.hu>
 <20070105131235.GB4662@ucw.cz> <E1H2pXI-0007jY-00@dorka.pomaz.szeredi.hu>
 <Pine.LNX.4.64.0701051502120.28914@artax.karlin.mff.cuni.cz>
 <E1H2qhP-0007qc-00@dorka.pomaz.szeredi.hu>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> And does it matter? If you rename a file, tar might skip it no matter of
>> hardlink detection (if readdir races with rename, you can read none of the
>> names of file, one or both --- all these are possible).
>>
>> If you have "dir1/a" hardlinked to "dir1/b" and while tar runs you delete
>> both "a" and "b" and create totally new files "dir2/c" linked to "dir2/d",
>> tar might hardlink both "c" and "d" to "a" and "b".
>>
>> No one guarantees you sane result of tar or cp -a while changing the tree.
>> I don't see how is_samefile() could make it worse.
>
> There are several cases where changing the tree doesn't affect the
> correctness of the tar or cp -a result.  In some of these cases using
> samefile() instead of st_ino _will_ result in a corrupted result.

... and those are what? If you create hardlinks while copying, you may 
have files duplicated instead of hardlinked in the backup. If you unlink 
hardlinks, cp will miss hardlinks too and create two copies of the same 
file (it searches the hash only for files with i_nlink > 1). If you rename 
files, the archive will be completely fscked up (either missing or 
duplicate files).

> Generally samefile() is _weaker_ than the st_ino interface in
> comparing the identity of two files without using massive amounts of
> memory.  You're searching for a better solution, not one that is
> broken in a different way, aren't you?

What is the relevant case where st_ino/st_dev works and samefile(char 
*path1, char *path2) doesn't?

> Miklos

Mikulas
