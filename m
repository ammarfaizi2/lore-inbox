Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129228AbQK0GUg>; Mon, 27 Nov 2000 01:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129295AbQK0GUR>; Mon, 27 Nov 2000 01:20:17 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:60172 "HELO
        note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
        id <S129228AbQK0GUP>; Mon, 27 Nov 2000 01:20:15 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Alexander Viro <viro@math.psu.edu>
Date: Mon, 27 Nov 2000 16:49:45 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14881.62969.786424.812353@notabene.cse.unsw.edu.au>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, "Mohammad A. Haque" <mhaque@haque.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tigran Aivazian <tigran@veritas.com>
Subject: Re: ext2 filesystem corruptions back from dead? 2.4.0-test11
In-Reply-To: message from Alexander Viro on Friday November 24
In-Reply-To: <14877.53881.182935.597766@notabene.cse.unsw.edu.au>
        <Pine.GSO.4.21.0011240006040.12702-100000@weyl.math.psu.edu>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
        LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
        8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday November 24, viro@math.psu.edu wrote:
> 
> 
> On Fri, 24 Nov 2000, Neil Brown wrote:
> 
> > I ran my test script, which builds a variety of raid5 arrays with
> > varying numbers of drives and chunk sizes, and runs mkfs/bonnie/dbench
> > on each array, and it got through about 8 file systems but choked on
> > the 9th by trying to allocate lots of blocks in the system zone (after
> > running for about an hour). 
> 
> Bloody interesting. I don't see anything recent that could affect the
> areas in question. Intersting versions to check: 11-pre5 and 11-pre6.
> It smells like buffer cache corruption, but I don't see anything
> relevant. __generic_unplug_device() change loock pretty innocent,
> ditto for bh_kmap() ones in raid5 and on ext2 side we had two obviously
> equivalent replacements (pre5->pre6). No buffer.c changes, no VM ones.
> Urgh.

Turns out my data is a false alarm.  It was a bug in my raid5 code -
and not a recent bug either - that was causing my filesystem
corruption.

So if your earlier patches work for everybody else then they look like
a good way to go.  I have fixed my fatal flaw and I cannot reproduce
the problems any more.  Patch has gone to Alan.

NeilBrown
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
