Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275089AbTHGC1s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 22:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275090AbTHGC1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 22:27:48 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:55987 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S275089AbTHGC1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 22:27:46 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Stephan von Krawczynski <skraw@ithnet.com>
Date: Thu, 7 Aug 2003 12:27:35 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16177.47383.51634.971703@gargle.gargle.HOWL>
Cc: muizelaar@rogers.com, linux-kernel@vger.kernel.org,
       mru@users.sourceforge.net
Subject: Re: FS: hardlinks on directories
In-Reply-To: message from Stephan von Krawczynski on Wednesday August 6
References: <20030804141548.5060b9db.skraw@ithnet.com>
	<yw1xsmohioah.fsf@users.sourceforge.net>
	<20030804152226.60204b61.skraw@ithnet.com>
	<3F2E7C63.2000203@rogers.com>
	<20030804181500.074aec51.skraw@ithnet.com>
	<16175.6729.962817.135747@gargle.gargle.HOWL>
	<20030805114125.30a12916.skraw@ithnet.com>
	<16176.22022.382294.55110@gargle.gargle.HOWL>
	<20030806121432.19f77d27.skraw@ithnet.com>
X-Mailer: VM 7.17 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday August 6, skraw@ithnet.com wrote:
> On Wed, 6 Aug 2003 11:12:38 +1000
> Neil Brown <neilb@cse.unsw.edu.au> wrote:
> 
> > On Tuesday August 5, skraw@ithnet.com wrote:
> > > > > Hm, and I just found out that re-exporting "mount --bind" volumes does
> > > > > not work over nfs...
> > > > > 
> > > > > Is this correct, Neil?
> > > > 
> > > > Yes, though there is a reasonable chance that it can be made to work
> > > > with linux-2.6.0 and nfs-utils-1.1.0 (neither of which have been
> > > > released yet:-)
> > > 
> > > Is this a complex issue? Can you imagine a not-too-big sized patch can make
> > > it work in 2.4? What is the basic reason it does in fact not work?
> > 
> > On reflection, it could probably work in 2.4 and current nfs-utils,
> > but admin might be a bit clumsy.
> > 
> > To allow knfsd to see a mountpoint, you have to export the mounted
> > directory with the "nohide" option.  Currently "nohide" only works
> > properly for exports to specific hosts, not to wildcarded hosts or
> > netgroups.
> > So if your /etc/export contains:
> > 
> >   /path/to/some/--bind/mountpoint servername(nohide,....)
> > 
> > for every mountpoint and every server, then it should work.
> 
> Hm, bad luck. I tried and it did not work. I used 2.4.20 kernel, are there
> chances a later kernel might work?

It worked for me.  There is nothing in recent kernels that would
affect this.

What errors do you get?
Can you describe your setup in a bit more detail.

One thing to be careful of is that you cannot export a directory and a
parent of that directory in the same filesystem to the same client.
This tripped me up the first time I tried it.
Here "parent" means in the real filesystem, ignoring any --bind
mounts.

NeilBrown
