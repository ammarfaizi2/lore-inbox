Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131834AbQKJXjP>; Fri, 10 Nov 2000 18:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132172AbQKJXjF>; Fri, 10 Nov 2000 18:39:05 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:21551 "EHLO
	nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S131834AbQKJXiq>; Fri, 10 Nov 2000 18:38:46 -0500
Message-ID: <3A0C86FE.DBEEDB5C@linux.com>
Date: Fri, 10 Nov 2000 15:38:38 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: LKML <linux-kernel@vger.kernel.org>, reiserfs-list@namesys.com
Subject: Re: [reiserfs-list] [bug] kernel panic related to 
 reiserfs,2.4.0-test11-pre1 and 3.6.18
In-Reply-To: <911040000.973870260@coffee>
Content-Type: multipart/mixed;
 boundary="------------D377A9CD1D88FE196F3D2492"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------D377A9CD1D88FE196F3D2492
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This is the first time I had kdb running.  All other times I lost the console
from the deadlock.  The deadlock is bad enough to prevent any more access to
basically everything.  I'm still running the same kernel and will do so for
several more days.  It usually happens every two to three days.

Chris Mason wrote:

> On Friday, November 10, 2000 06:15:40 -0800 David Ford <david@linux.com>
> wrote:
>
> > Over the last three weeks my box has been locking up w/ a black screen
> > of death.  This time I had kdb patched in and got the following:
> >
> > Entering kdb (current=0xcf906000, pid 16808) Panic: invalid operand
> > due to panic @ 0xc0163d7a
>
> Odd.  There is nothing in de_still_valid that should panic, unless there is
> some major memory corruption going on.  Do you always get the same trace?
>
> [ ... ]
>
> > I have been writing code on it for the last two days straight.  It was
> > fully functional until I left for 15 minutes for a shower.  I came back
> > and the system is hosed.  Everything is quickly going to D state.  I can
> > move and type until I attempt to execute or reference anything.  It's
> > all downhill from there.
> >
> > It is 2.4.0-test11-pre1 with reiserfs 3.6.18.
> >
> > With kdb, after the panic happens, I can hit 'sr s' then 'g', it will
> > OOPS (process sendmail) then continue.  Without kdb, I am SOL and have
> > to hit the power button.  sysrq won't react.
> >
>
> Once you get inside reiserfs_rename, you've started a transaction.  If you
> oops inside there, the transaction never finishes, and all the other
> transactions end up waiting on it.  So, if you can continue without hanging
> the box, the oops didn't happen in reiserfs_rename ;-)  Could you send a
> decoded version?
>
> -chris

No, I can't continue.  Everything is halted beyond that.  I can type into an
rxvt only until I hit enter, then that rxvt is hosed.  I cannot even jump from
X to console.  Even input via the serial console was dead.  Luckily the
keyboard remained alive, I suspect it was only from the grace of kdb.
Normally it is also dead.

>>EIP; c0163d7a <de_still_valid+3e/dc>   <=====
Trace; c02ba2e5 <devfsd_buf_size+1c45/8e58>
Trace; c02ba37d <devfsd_buf_size+1cdd/8e58>
Trace; c0163e31 <entry_points_to_object+19/80>
Trace; c01642fa <reiserfs_rename+432/748>
Trace; c02bf60f <devfsd_buf_size+6f6f/8e58>
Trace; c0139c94 <vfs_rename_other+26c/2c4>
Trace; c0139d25 <vfs_rename+39/90>
Trace; c0139ef9 <sys_rename+17d/204>
Trace; c010aadb <system_call+33/38>
Code;  c0163d7a <de_still_valid+3e/dc>
00000000 <_EIP>:
Code;  c0163d7a <de_still_valid+3e/dc>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0163d7c <de_still_valid+40/dc>
   2:   8b 7d c4                  mov    0xffffffc4(%ebp),%edi
Code;  c0163d7f <de_still_valid+43/dc>
   5:   8b 45 bc                  mov    0xffffffbc(%ebp),%eax
Code;  c0163d82 <de_still_valid+46/dc>
   8:   8b 4d c8                  mov    0xffffffc8(%ebp),%ecx
Code;  c0163d85 <de_still_valid+49/dc>
   b:   0f b7 57 14               movzwl 0x14(%edi),%edx
Code;  c0163d89 <de_still_valid+4d/dc>
   f:   03 50 34                  add    0x34(%eax),%edx
Code;  c0163d8c <de_still_valid+50/dc>
  12:   89 c8                     mov    %ecx,%eax

-d


--
"The difference between 'involvement' and 'commitment' is like an
eggs-and-ham breakfast: the chicken was 'involved' - the pig was
'committed'."



--------------D377A9CD1D88FE196F3D2492
Content-Type: text/x-vcard; charset=us-ascii;
 name="david.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for David Ford
Content-Disposition: attachment;
 filename="david.vcf"

begin:vcard 
n:Ford;David
x-mozilla-html:TRUE
adr:;;;;;;
version:2.1
email;internet:david@kalifornia.com
title:Blue Labs Developer
x-mozilla-cpt:;14688
fn:David Ford
end:vcard

--------------D377A9CD1D88FE196F3D2492--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
