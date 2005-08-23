Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751327AbVHWF7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbVHWF7u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 01:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbVHWF7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 01:59:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41097 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S1751327AbVHWF7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 01:59:49 -0400
Date: Tue, 23 Aug 2005 07:02:39 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, davej@redhat.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, mlindner@syskonnect.de
Subject: Re: skge missing ifdefs.
Message-ID: <20050823060239.GC9322@parcelfarce.linux.theplanet.co.uk>
References: <20050801203442.GD2473@redhat.com> <20050801203818.GA7497@havoc.gtf.org> <20050822195913.GF27344@redhat.com> <20050822132333.2ff893e6.akpm@osdl.org> <20050822203522.GB9322@parcelfarce.linux.theplanet.co.uk> <20050822134218.55de5b82.akpm@osdl.org> <Pine.LNX.4.61.0508230015300.3743@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0508230015300.3743@scrub.home>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2005 at 12:24:19AM +0200, Roman Zippel wrote:
> Hi,
> 
> On Mon, 22 Aug 2005, Andrew Morton wrote:
> 
> > Al Viro <viro@parcelfarce.linux.theplanet.co.uk> wrote:
> > >
> > > mail -s '[PATCH] (45/46) %t... in vsnprintf' torvalds@osdl.org <<'EOF'
> > 
> > <wonders what the other 45 patches did>
> > 
> > Could you copy a mailing list on patches, please?
> 
> Seconded.
> Al, I'd like to know which of the m68k related patches you want to merge.

See ftp.linux.org.uk/pub/people/viro/patchset/T* + adb.h delta from CVS.
That's a minimum getting mainline m68k to sane state and not breaking
other platforms.  These are against -rc6-git2, but their counterparts
in more recent patchset have not changed.  BTW, m68k patches were not
in the series sent to Linus and I would definitely Cc m68k folks on them
if they would go there.

As for your s/thread_info/stack/ - I don't believe it's doable in mainline
right now.  It's definitely separate from m68k merge and should not be
mixed into it.  Moreover, mandatory changes to every platform arch-specific
code over basically cosmetic issue (renaming a field of task_struct) at
this point are going to be gratitious PITA for every architecture with
out-of-tree development.  And m68k folks, of all people, should know what
fun it is.

When folks start using task_thread_info() in arch/* (i.e. by 2.6.1[45]) the
size of that delta will go down big way and it will be less painful.  Until
then...  Not a good idea.
