Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279841AbRKAWzq>; Thu, 1 Nov 2001 17:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279847AbRKAWzh>; Thu, 1 Nov 2001 17:55:37 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:42247 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S279845AbRKAWzZ>; Thu, 1 Nov 2001 17:55:25 -0500
Message-ID: <3BE1D2A7.FDC86888@namesys.com>
Date: Fri, 02 Nov 2001 01:54:31 +0300
From: Hans Reiser <reiser@namesys.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-4GB i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
CC: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: writing a plugin for reiserfs compression
In-Reply-To: <Pine.LNX.4.30.0111011754580.2106-100000@mustard.heime.net>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Basically a good idea, lots of people have agreed with you for years on it. 
Wait until Sep. 30, 2002, and it will become especially easy to write this for
reiserfs using reiser4 plugins.  Probably not very hard to write using reiser3
though.  If you don't want to wait, I will review any patch you create for
reiser3, and express an opinion when I see it.  Clean and simple is more
important to getting it accepted by me than optimal, at least for reiser3.  Your
code will be easy tp author excepting the uncompression upon read, which is
probably not that hard.  I think we can spare three bits for you in the stat
data.  Your code will get tested in 2.5 before being sent in for 2.4 users if
you do it for v3. 

Hans


Roy Sigurd Karlsbakk wrote:
> 
> hi
> 
> I got this idea the other day...
> 
> Novell NetWare has a feature I really like. It's a file compression
> feature they've been having since version 4.0 (or 4.10) of the OS.
> 
> - Once a day, a job is run to compress all files that havent been touched
> within <n> days - default 14, that have not been flagged CAN'T COMPRESS
> or DON'T COMPRESS (see below).
> 
> - After the file is compressed, it's checked against the compression
> gain. If this is less than <n> per cent (default 30), the compressed
> version is being deleted and the file is flagged CAN'T COMPRESS. If the
> file is compressed, the uncompressed version is being deleted and the file
> is flagged COMPRESSED.
> 
> - When a compressed file is accessed, it'll be decompressed on the fly and
> flagged ACCESSED AFTER COMPRESSION. The next time it's accessed within the
> given <n> days (above), it's decompressed and the compressed file
> discarded. The flag COMPRESSED is cleared.
> 
> Files can be flagged 'DON'T COMPRESS' and 'FORCE COMPRESS' manually by the
> user or admin. 'FORCE COMPRESS' is dominant over 'CAN'T COMPRESS'.
> 
> The result is that you're saving loads of space (typically 50-70% on a
> netware file server) and, since the compression job is batched up
> (typically by night), the performance penalty is minimal. File
> decompression will happen quite rarely, as only the least-accessed files
> are compressed.
> 
> TODO:
> New attributes must be added somehow. 'ls' and 'find' and perhaps other
> files must be modified to take advantage of this. The compression job can
> be a simple script with something like
> 
>         find . -type f ! --compressed ! --dont-compress / -exec fcomp {} \;
> 
> (and check can't compress and force compression).
> 
> There must be a way to access the compressed files directly to make
> backups more efficient - backing up already compressed files's a good
> thing.
> 
> COMMENT:
> And yes - I know a lot of people are saying this is something we don't
> need, as diskspace doesn't cost anything today compared to what it used
> to. The first time I heard that, was in '92. We're always using too much
> diskspace!
> 
> Please cc: to me as I'm not on the list
> 
> roy
> ---
> Praktiserende dyslektiker.
> La ikke ortografiske krumspring skygge for
> intensjonen bak denne fremstilling.
