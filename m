Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315370AbSEYVHj>; Sat, 25 May 2002 17:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315375AbSEYVHi>; Sat, 25 May 2002 17:07:38 -0400
Received: from APuteaux-101-2-1-180.abo.wanadoo.fr ([193.251.40.180]:54800
	"EHLO inet6.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S315370AbSEYVHh>; Sat, 25 May 2002 17:07:37 -0400
Date: Sat, 25 May 2002 23:07:35 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
To: Jeremy White <jwhite@codeweavers.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: isofs unhide option:  troubles with Wine
Message-ID: <20020525230735.A18560@bouton.inet6-interne.fr>
Mail-Followup-To: Jeremy White <jwhite@codeweavers.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <1022301029.2443.28.camel@jwhiteh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 11:30:29PM -0500, Jeremy White wrote:
> Greetings,
> 
> When installing Microsoft Office with Wine, we find that some
> MS CDs have certain files marked as hidden on the CD.
> [...]
> 
> Unfortunately, I don't have a strong feeling for what the
> 'right' solution is.  I see several options:
> 
>     1.  Invert the logic of the option, make it 'hide' instead
>         of unhide, and so unhide is the default.
> 
>     2.  Make it possible to set this mount option from user
>         space (I don't like this, but it would get me around
>         the problem).
> 
>     3.  Make it so that isofs/dir.c still strips out hidden
>         files, but enable isofs/namei.c to return a hidden file that
>         is opened directly by name.
> 
> I am willing to submit a patch to implement the appropriate solution.
> 
> Comments and opinions are greatly appreciated; please copy me directly
> though, as I am not subscribed.
> 
> Thanks,
> 
> Jeremy
> 

With 3. Wine's FindFirstFile and FindNextFile wont't be able to report
hidden files and Win32 programs could rely on that instead of using
hard-coded filenames.
If I'm not mistaken these functions return all files and put file flags
in a struct. User apps are responsible of the hiding.
One could argue that Win32 programs could rely on the file flags being
reported correctly, but I find this far less probable.

If one goal is to allow Wine to implement the Win32 syscalls as correctly as
possible 3. is not an option IMHO.

Moreover I don't like the idea of files readable but not findable by common
tools, seems broken to me.

2. will lead to entries in FAQ:

Q: What does the "unhide" option mean in my /etc/fstab ?
A: Lengthy explanation on ISO9660, Windows FS versus Unix FS and so on...

1. will do what Linux already does for other FAT/NTFS contents, simply show
the info to the users even if Windows' tools hide it by default.

Personnaly I would choose 1. (I prefer short FAQs).

LB.
