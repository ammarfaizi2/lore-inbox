Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbUCOBqg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 20:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbUCOBqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 20:46:36 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:41950 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S262192AbUCOBqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 20:46:32 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Date: Mon, 15 Mar 2004 12:46:21 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16469.2797.130561.885788@notabene.cse.unsw.edu.au>
cc: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.4-mm1 - 4g patch breaks when X86_4G not selected
In-Reply-To: message from Neil Brown on Saturday March 13
References: <20040310233140.3ce99610.akpm@osdl.org>
	<16465.3163.999977.302378@notabene.cse.unsw.edu.au>
	<20040311172244.3ae0587f.akpm@osdl.org>
	<16465.20264.563965.518274@notabene.cse.unsw.edu.au>
	<20040311235009.212d69f2.akpm@osdl.org>
	<16466.57738.590102.717396@notabene.cse.unsw.edu.au>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday March 13, neilb@cse.unsw.edu.au wrote:
> On Thursday March 11, akpm@osdl.org wrote:
> > > I thought I might try selectively removing patches, but it isn't clear
> > > what order the borken-out patches were applied it.
> > > If you have an ordered list, I can try a binary search.
> > 
> > See the `series' file in the broken-out directory.
> > 
> 
> Ahh... would you consider moving that up one level, or spelling it
> "Series" or "00series" or something to make it stand out for the
> uninitiated??
> 
> > > Or if you can suggest some patches that I can try backing out....
> > 
> > Maybe turn off -mregparm?  Or back off the 4g/4g patches?  Maybe they broke
> > non-4:4 code comehow.
> > 
> 
> Looks like it might be a good guess....
> 

And it turns out it was spot on.
Applying  4g-2.6.0-test2-mm2-A5.patch (on top of preceding -mm1
patches) causes my server not to boot.

I tried all the broken out patches except
     4g-2.6.0-test2-mm2-A5.patch
     4g4g-locked-userspace-copy.patch

but then it couldn't find /sbin/init, even though the root filesystem
was successful found (I don't know if that is significant).

With all of mm1 applied, and with X86_4G selected, it boots fine.
But without X86_4G it doesn't get to print out any messages at all,
even with 'earlyprintk=vga' set.

I am happy to experiment with if you or anyone has patches you would
like tested.

NeilBrown
