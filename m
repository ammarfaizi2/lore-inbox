Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275121AbRJAP13>; Mon, 1 Oct 2001 11:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275122AbRJAP1J>; Mon, 1 Oct 2001 11:27:09 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:59399 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S275121AbRJAP1E>; Mon, 1 Oct 2001 11:27:04 -0400
Message-ID: <3BB88B63.AEE6EF8E@namesys.com>
Date: Mon, 01 Oct 2001 19:27:31 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: foner-reiserfs@media.mit.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: ReiserFS data corruption in very simple configuration
In-Reply-To: <200109221000.GAA11263@out-of-band.media.mit.edu>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the meaning of metadata journaling: that writes in progress at the time
of the crash may write garbage, but you won't need to fsck.  You can get this
behaviour with other filesystems like FFS also.  If you cannot accept those
terms of service, you might use ext3 with data journaling on, but then your
performance will be far worse.  It is a tradeoff, not a bug.  Regarding where to
email these types of reiserfs questions, you might email
reiserfs-list@namesys.com with such questions, or try
www.namesys.com/support.html if you want paid support service on it.

Best,

Hans

foner-reiserfs@media.mit.edu wrote:
> 
> [Please CC me on any replies; I'm not on linux-kernel.]
> 
> The ReiserFS that comes with both Mandrake 7.2 and 8.0 has
> demonstrated a serious data corruption problem, and I'd like
> to know (a) if anyone else has seen this, (b) how to avoid it,
> and (c) how to determine how badly I've been bitten.
> 
> My configuration in each case has been an AMD CPU running ReiserFS
> exactly as configured "out of the box" by running the Mandrake 7.2 or
> 8.0 installation CD and opting to run ReiserFS instead of the default.
> This is a uniprocessor machine with one IDE 80GB Maxtor disk---no RAID
> or anything fancy like that.  The hardware itself is rock solid and
> has never demonstrated any faults at all.  (MDK 8.0 appears to use
> RSFS 3.6.25; I'm not longer running MDK 7.2, so I can't check that.)
> The machine had barely been used before each corruption problem; I'm
> not running some strange root-priv stuff, and each time, the FS hadn't
> had more than a few minutes to a few hours of use since being created.
> 
> In each case, I've gotten in trouble by editing my XF86Config-4 file,
> guessing wrong on a modeline, hanging X (blank gray screen & no
> response to anything), and being forced to hit the reset button
> because nothing else worked.  Under 7.2, I discovered that my
> XF86Config-4 file suddenly had a block of nulls in it.  That time, I
> thought I must have been hallucinating, but I ran a background job to
> sync the filesystem every second while continuing to debug the X
> problems, and didn't see the corruption again.
> 
> Now, I was just bitten by the -same- behavior under MDK 8.0.  After
> accidentally hanging X, I waited a few seconds just in case a sync was
> pending, hit reset, and had all sorts of lossage:
>   (1) Parts of the XF86Conf-4 file had lines garbled, e.g.,
>       sections of the file had apparently been rearranged.
>   (2) /var/log/XFree86.0.log was truncated, and maybe garbled.
>   (2) Logging in as root was fine, but then logging in as myself
>       I got "Last login: <4-5 lines of my XFree86.0.log file (!)>"
>       instead of a date!  Logging in again gave me the proper
>       last-login time, but clearly wtmp or something else had
>       gotten stepped on in some weird way.
> Obviously, the behavior I saw once under MDK 7.2 was no hallucination
> or accidental yank in Emacs.
> 
> I thought the whole point of a journalling file system was to
> -prevent- corruption due to an unexpected failure!  This seems to be
> -far- worse than a normal filesystem---ext2fs would at least choke and
> force fsck to be run, which might actually fix the problem, but this
> is ridiculous---it just silently trashes random files.
> 
> So I now have possibly-undetected filesystem damage.  My -guess- is
> that only files written within a few minutes of the reset are likely
> to be affected, but I really don't know, and don't know of a good way
> to find out.  Must I reinstall the OS -again-, starting from a blank
> partition, to be sure?  Maybe I should just give up on ReiserFS completely.
> 
> [If there is a more-appropriate place for me to send this---such as
> a particular Mandrake list, or a particular ReiserFS list---please let
> me know, particularly if I can get a quick answer -without- going
> through the overhead of subscribing to the list, being flooded, and
> unsubscribing---that's what archives are for.  Some websearching
> for "ReiserFS corruption" yielded -thousands- of hits---not a good
> sign---and a very large proportion of them were on this list, so I
> figure this is as good a place to ask as any.  Thanks again.]
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
