Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269106AbUIHOvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269106AbUIHOvf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 10:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268255AbUIHNZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 09:25:56 -0400
Received: from open.hands.com ([195.224.53.39]:21417 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S269007AbUIHNYk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 09:24:40 -0400
Date: Wed, 8 Sep 2004 14:35:47 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] to add device+inode check to ipt_owner.c - HACKED UP
Message-ID: <20040908133547.GB1017@lkcl.net>
References: <20040908100946.GA9795@lkcl.net> <20040908103922.GD9795@lkcl.net> <20040908104739.GX23987@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040908104739.GX23987@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello, hello, thank you v. much for responding.

On Wed, Sep 08, 2004 at 11:47:39AM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:

> On Wed, Sep 08, 2004 at 11:39:22AM +0100, Luke Kenneth Casson Leighton wrote:
> > +static int
> > +match_inode(const struct sk_buff *skb, const char *devname, unsigned long i_num)
> > +{
> > +	struct task_struct *g, *p;
> > +	struct files_struct *files;
> > +	/*
> > +	struct inode *inode;
> > +	struct super_block *sb;
> > +	struct block_device *bd;
> > +	*/
> > +	int i;
> > +	read_lock(&tasklist_lock);
> > +
> > +	/* lkcl: these are fairly obvious (just obtuse): hunt for the
> > +	 * filesystem device, then its superblock, then the inode is
> > +	 * relevant to that superblock, _then_ we can find the inode.
> > +	bd = bdget(dev);
> 
> 
> ... the hell?  Where does that "dev" come from?

it's code commented out that i put in there when i _really_ wasn't
sure what i was doing.

it might come in handy so i haven't deleted it yet.

basically in an earlier experiment, i put the device (dev_t)
major/minor number into ipt_owner.h.

then i discovered that fs/proc/base.c could look up a vfsmount
struct, which according to struct vfsmount contains the _name_
of the device.

i'm counting on that actually working.

if it doesn't work, then it's back to the drawing board and uncommenting
the stuff that you have noticed is all commented out, above.

l.


-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />

