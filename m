Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131188AbRAFUDs>; Sat, 6 Jan 2001 15:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132041AbRAFUDi>; Sat, 6 Jan 2001 15:03:38 -0500
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:21265 "EHLO
	mailout.plan9.de") by vger.kernel.org with ESMTP id <S131188AbRAFUD2>;
	Sat, 6 Jan 2001 15:03:28 -0500
Date: Sat, 6 Jan 2001 20:57:26 +0100
From: Marc Lehmann <pcg@goof.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Stefan Traby <stefan@hello-penguin.com>,
        Daniel Phillips <phillips@innominate.de>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Journaling: Surviving or allowing unclean shutdown?
Message-ID: <20010106205726.A9664@cerebro.laendle>
Mail-Followup-To: David Woodhouse <dwmw2@infradead.org>,
	"Stephen C. Tweedie" <sct@redhat.com>,
	Stefan Traby <stefan@hello-penguin.com>,
	Daniel Phillips <phillips@innominate.de>,
	Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
In-Reply-To: <20010104224946.C1290@redhat.com> <Pine.LNX.4.30.0101031253130.6567-100000@springhead.px.uk.com> <Pine.LNX.4.21.0101031325270.1403-100000@duckman.distro.conectiva> <3A5352ED.A263672D@innominate.de> <20010104192104.C2034@redhat.com> <20010104220821.B775@stefan.sime.com> <20010104224946.C1290@redhat.com> <1628.978695936@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1628.978695936@redhat.com>; from dwmw2@infradead.org on Fri, Jan 05, 2001 at 11:58:56AM +0000
X-Operating-System: Linux version 2.2.18 (root@cerebro) (gcc version pgcc-2.95.2.1 20001224 (release)) 
X-Copyright: copyright 2000 Marc Alexander Lehmann - all rights reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2001 at 11:58:56AM +0000, David Woodhouse <dwmw2@infradead.org> wrote:
> You mount it read-only, recover as much as possible from it, and bin it.
> 
> You _don't_ want the fs code to ignore your explicit instructions not to
> write to the medium, and to destroy whatever data were left.

The problem is: where did you give the explicit instruction? Just that you
define "read-only" as "the medium should not be written" does not mean
everybody else thinks the same.

actually, I regard "ro" mainly as a "hey kernel, I won't handle writes
now, so please don't try it", like for cd-roms or other non-writeale
media, and please filesystem stay in a clean state.

That ro means "the medium is never written" is an assumption that does not
hold for most disks anyway and is, in the case of journlaing filesystems,
often impossible to implement. You simply can't salvage data without a log
reply. Sure, you can do virtual log replays, but for example the reiserfs
log is currently 32mb. Pinning down that much memory for a virtual log
reply is not possible on low-memory machines.

So the first thing would be to precisely define the meaning of the "ro"
flag.  Before this has happened it is ansolutely senseless to argue about
what it means, as it doesn't mean anything at the moment, except (man mount):

              ro     Mount the file system read-only.

Which it does even with journaling filesystems...

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@opengroup.org |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
