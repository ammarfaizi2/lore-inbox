Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274898AbRIVMtF>; Sat, 22 Sep 2001 08:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274899AbRIVMsz>; Sat, 22 Sep 2001 08:48:55 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:4113 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S274898AbRIVMst>; Sat, 22 Sep 2001 08:48:49 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15276.34915.301069.643178@beta.reiserfs.com>
Date: Sat, 22 Sep 2001 16:47:31 +0400
To: foner-reiserfs@media.mit.edu
Cc: linux-kernel@vger.kernel.org,
        Reiserfs mail-list <Reiserfs-List@Namesys.COM>
Subject: Re: ReiserFS data corruption in very simple configuration
In-Reply-To: <200109221000.GAA11263@out-of-band.media.mit.edu>
In-Reply-To: <200109221000.GAA11263@out-of-band.media.mit.edu>
X-Mailer: VM 6.89 under 21.4 (patch 3) "Academic Rigor" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

foner-reiserfs@media.mit.edu writes:
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

Stock reiserfs only provides meta-data journalling. It guarantees that
structure of you file-system will be correct after journal replay, not
content of a files. It will never "trash" file that wasn't accessed at
the moment of crash, though. Full data-journaling comes at cost. There
is patch by Chris Mason <Mason@Suse.COM> to support data journaling in
reiserfs. Ext3 supports it also.

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

Reiserfs mail-list <Reiserfs-List@Namesys.COM>,
archive at http://marc.theaimsgroup.com/?l=reiserfs&r=1&w=2

 > through the overhead of subscribing to the list, being flooded, and
 > unsubscribing---that's what archives are for.  Some websearching
 > for "ReiserFS corruption" yielded -thousands- of hits---not a good
 > sign---and a very large proportion of them were on this list, so I
 > figure this is as good a place to ask as any.  Thanks again.]

Nikita.
