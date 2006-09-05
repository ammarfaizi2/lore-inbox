Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030190AbWIETti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbWIETti (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 15:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030235AbWIETti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 15:49:38 -0400
Received: from nz-out-0102.google.com ([64.233.162.202]:48012 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030190AbWIETth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 15:49:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AOqDQHs+PLPJps7N5WiQAoaywGz/P8m5aJ8wOZgETaO+39EQn2M5raJre8zcZKIHBIGYlKPvQwPODibKl8sqi251DOpLVWiCuDdg4ZIKiOcAzhJMiRKNVTWZzF2/BE5VIMNoiFLzTGMtN5qLtkKu/rlF8NIbejCmiOul994zRr4=
Message-ID: <a44ae5cd0609051249y767eed58ja1fe1b27858f5cd@mail.gmail.com>
Date: Tue, 5 Sep 2006 12:49:36 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.18-rc5-mm1 + all hotfixes -- INFO: possible recursive locking detected
Cc: LKML <linux-kernel@vger.kernel.org>,
       "Herbert Xu" <herbert@gondor.apana.org.au>,
       linux1394-devel@lists.sourceforge.net,
       "Stefan Richter" <stefanr@s5r6.in-berlin.de>
In-Reply-To: <20060905111306.80398394.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a44ae5cd0609051037k47d1ad7dsa8276dc0cec416bf@mail.gmail.com>
	 <20060905111306.80398394.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/06, Andrew Morton <akpm@osdl.org> wrote:
> On Tue, 5 Sep 2006 10:37:51 -0700
> "Miles Lane" <miles.lane@gmail.com> wrote:
>
> > ieee1394: Node changed: 0-01:1023 -> 0-00:1023
> > ieee1394: Node changed: 0-02:1023 -> 0-01:1023
> > ieee1394: Node suspended: ID:BUS[0-00:1023]  GUID[0080880002103eae]
> >
> > =============================================
> > [ INFO: possible recursive locking detected ]
> > 2.6.18-rc5-mm1 #2
> > ---------------------------------------------
> > knodemgrd_0/2321 is trying to acquire lock:
> >  (&s->rwsem){----}, at: [<f8958897>] nodemgr_probe_ne+0x311/0x38d [ieee1394]
> >
> > but task is already holding lock:
> >  (&s->rwsem){----}, at: [<f8959078>] nodemgr_host_thread+0x717/0x883 [ieee1394]
> >
> > other info that might help us debug this:
> > 2 locks held by knodemgrd_0/2321:
> >  #0:  (nodemgr_serialize){--..}, at: [<c11e76cd>]
> > mutex_lock_interruptible+0x1c/0x21
> >  #1:  (&s->rwsem){----}, at: [<f8959078>]
> > nodemgr_host_thread+0x717/0x883 [ieee1394]
> >
> > stack backtrace:
> >  [<c1003c97>] dump_trace+0x69/0x1b7
> >  [<c1003dfa>] show_trace_log_lvl+0x15/0x28
> >  [<c10040f5>] show_trace+0x16/0x19
> >  [<c1004110>] dump_stack+0x18/0x1d
> >  [<c102f1e1>] __lock_acquire+0x7a2/0x9f8
> >  [<c102f70a>] lock_acquire+0x56/0x74
> >  [<c102b805>] down_write+0x27/0x41
> >  [<f8958897>] nodemgr_probe_ne+0x311/0x38d [ieee1394]
> >  [<f8959098>] nodemgr_host_thread+0x737/0x883 [ieee1394]
> >  [<c1028c19>] kthread+0xaf/0xde
> >  [<c100397b>] kernel_thread_helper+0x7/0x10
> > DWARF2 unwinder stuck at kernel_thread_helper+0x7/0x10
> >
> > Leftover inexact backtrace:
> >
> >  [<c1003dfa>] show_trace_log_lvl+0x15/0x28
> >  [<c10040f5>] show_trace+0x16/0x19
> >  [<c1004110>] dump_stack+0x18/0x1d
> >  [<c102f1e1>] __lock_acquire+0x7a2/0x9f8
> >  [<c102f70a>] lock_acquire+0x56/0x74
> >  [<c102b805>] down_write+0x27/0x41
> >  [<f8958897>] nodemgr_probe_ne+0x311/0x38d [ieee1394]
> >  [<f8959098>] nodemgr_host_thread+0x737/0x883 [ieee1394]
> >  [<c1028c19>] kthread+0xaf/0xde
> >  [<c100397b>] kernel_thread_helper+0x7/0x10
> >  =======================
> > ieee1394: Node resumed: ID:BUS[0-00:1023]  GUID[0080880002103eae]
> > ieee1394: Node changed: 0-00:1023 -> 0-01:1023
> > ieee1394: Node changed: 0-01:1023 -> 0-02:1023
>
> That's a 1394 glitch, possibly introduced by git-ieee1394.patch.
>
>

Hi Andrew,

I am having trouble with backing out the git-ieee1394 patches.  Suggestions?
I am not knowledgable about the kernel code to fix broken patches.

# patch -p1 -R --dry-run < /home/miles/git-ieee1394.patch patching
file drivers/ieee1394/csr.c
patching file drivers/ieee1394/csr.h
patching file drivers/ieee1394/dma.c
patching file drivers/ieee1394/dma.h
patching file drivers/ieee1394/dv1394-private.h
patching file drivers/ieee1394/dv1394.c
patching file drivers/ieee1394/eth1394.c
Hunk #1 succeeded at 66 with fuzz 1 (offset -1 lines).
patching file drivers/ieee1394/highlevel.h
patching file drivers/ieee1394/hosts.c
Hunk #1 succeeded at 98 with fuzz 2 (offset 8 lines).
Hunk #2 FAILED at 113.
Hunk #3 FAILED at 123.
2 out of 3 hunks FAILED -- saving rejects to file drivers/ieee1394/hosts.c.rej
patching file drivers/ieee1394/hosts.h
Hunk #2 succeeded at 109 (offset -3 lines).
Hunk #3 succeeded at 157 (offset -3 lines).
Hunk #4 succeeded at 167 (offset -3 lines).
Hunk #5 succeeded at 193 (offset -3 lines).
patching file drivers/ieee1394/ieee1394-ioctl.h
patching file drivers/ieee1394/ieee1394.h
patching file drivers/ieee1394/ieee1394_core.c
Hunk #1 succeeded at 354 (offset -1 lines).
patching file drivers/ieee1394/ieee1394_core.h
Hunk #1 FAILED at 1.
Hunk #2 succeeded at 57 (offset -1 lines).
Hunk #3 succeeded at 79 (offset -1 lines).
Hunk #4 succeeded at 91 (offset -1 lines).
Hunk #5 succeeded at 203 (offset -1 lines).
Hunk #6 succeeded at 222 (offset -1 lines).
1 out of 6 hunks FAILED -- saving rejects to file
drivers/ieee1394/ieee1394_core.h.rej
patching file drivers/ieee1394/ieee1394_hotplug.h
patching file drivers/ieee1394/ieee1394_transactions.c
Hunk #1 succeeded at 13 with fuzz 2 (offset -1 lines).
Hunk #2 succeeded at 232 (offset 18 lines).
Hunk #3 succeeded at 279 (offset 18 lines).
patching file drivers/ieee1394/ieee1394_transactions.h
patching file drivers/ieee1394/ieee1394_types.h
Hunk #1 FAILED at 1.
Hunk #2 succeeded at 9 with fuzz 2 (offset -22 lines).
Hunk #3 FAILED at 32.
2 out of 3 hunks FAILED -- saving rejects to file
drivers/ieee1394/ieee1394_types.h.rej
patching file drivers/ieee1394/iso.c
patching file drivers/ieee1394/iso.h
patching file drivers/ieee1394/nodemgr.c
Hunk #4 succeeded at 418 (offset 10 lines).
Hunk #5 succeeded at 1260 (offset 9 lines).
Hunk #6 succeeded at 1268 (offset 9 lines).
Hunk #7 succeeded at 1309 (offset 9 lines).
Hunk #8 succeeded at 1501 (offset 9 lines).
Hunk #9 succeeded at 1631 (offset 9 lines).
Hunk #10 succeeded at 1676 (offset 9 lines).
Hunk #11 succeeded at 1707 (offset 9 lines).
Hunk #12 succeeded at 1773 (offset 9 lines).
Hunk #13 succeeded at 1815 (offset 9 lines).
patching file drivers/ieee1394/nodemgr.h
Hunk #5 succeeded at 105 with fuzz 1 (offset -1 lines).
Hunk #6 succeeded at 152 (offset -1 lines).
Hunk #7 succeeded at 169 (offset -1 lines).
patching file drivers/ieee1394/ohci1394.c
patching file drivers/ieee1394/raw1394-private.h
patching file drivers/ieee1394/raw1394.c
patching file drivers/ieee1394/sbp2.c
Hunk #1 succeeded at 367 (offset 11 lines).
Hunk #2 succeeded at 380 (offset 11 lines).
patching file drivers/ieee1394/video1394.c

# patch -p1 -R --dry-run < /home/miles/git-ieee1394-fixup.patch
patching file drivers/ieee1394/hosts.c
Hunk #1 succeeded at 100 with fuzz 2 (offset 10 lines).
Hunk #2 FAILED at 117.
Hunk #3 FAILED at 128.
2 out of 3 hunks FAILED -- saving rejects to file drivers/ieee1394/hosts.c.rej
