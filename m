Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288950AbSANTuw>; Mon, 14 Jan 2002 14:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288955AbSANTus>; Mon, 14 Jan 2002 14:50:48 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:5 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id <S288950AbSANTtm>;
	Mon, 14 Jan 2002 14:49:42 -0500
Message-ID: <3C43357D.40600@namesys.com>
Date: Mon, 14 Jan 2002 22:46:05 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolabs.com>
CC: Oleg Drokin <green@namesys.com>, reiserfs-list@namesys.com,
        linux-kernel@vger.kernel.org, ewald.peiszer@gmx.at,
        matthias.andree@stud.uni-dortmund.de
Subject: Re: [reiserfs-list] Boot failure: msdos pushes in front of reiserfs
In-Reply-To: <20020113223803.GA28085@emma1.emma.line.org> <20020114095013.A4760@namesys.com> <3C42BE0E.2090902@namesys.com> <20020114143650.D828@namesys.com> <20020114104242.M26688@lynx.adilger.int>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:

>On Jan 14, 2002  14:36 +0300, Oleg Drokin wrote:
>
>>On Mon, Jan 14, 2002 at 02:16:30PM +0300, Hans Reiser wrote:
>>
>>>So what solution should we use, zeroing or fixing msdos to not try 
>>>something reiserfs can find, or both or what?
>>>
>>We can use both:
>>     destroy MSDOS superblock (if any) at mkreiserfs (or don't touch 1st
>>     block of the device if there is no msdos superblock).
>>     And link reiserfs code into the kernel earlier than msdos code.
>>
>
>Hmm, I could have sworn I submitted patches already which did both of these
>things.  In general, it is perfectly safe to zero the bootsector of a
>partition when you mkfs it (mke2fs has been doing this for a long time).
>If you mkfs your boot partition (and zap the bootblock) you would have to
>run LILO on it anyways after they install a new kernel, because the
>location of the kernel would change.
>
Can the kernel be in a different partition from the boot partition?  If 
so, it is not safe, yes?

>
>
>'Re: 2.4.15-pre1: "bogus" message with reiserfs root and other weirdness'
>dated Nov 21, 2001 for patch to clean up reiserfs boot messages and order.
>
>'Re: [reiserfs-list] Re: Basic reiserfs question' dated Sep 7, 2001 for
>patch which (among other things) zaps non-reiserfs data from the disk
>when mkreiserfs is run (also referenced in a subsequent posting
>'Re: [reiserfs-list] mkreiserfs /dev/hdb' dated Oct 1, 2001).
>

Oleg, please review his patches and integrate them into our release process.

>
>
>There was a patch submitted within the past week to clean up the FAT
>messages when "silent" is passed.  In any case, that is mostly irrelevant
>if reiserfs is moved up in the probe order.
>
>Cheers, Andreas
>--
>Andreas Dilger
>http://sourceforge.net/projects/ext2resize/
>http://www-mddsp.enel.ucalgary.ca/People/adilger/
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>



