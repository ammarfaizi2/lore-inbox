Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932373AbVKUQVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbVKUQVd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 11:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbVKUQVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 11:21:32 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:20869 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932373AbVKUQVb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 11:21:31 -0500
Subject: Re: [PATCH 4/12: eCryptfs] Main module functions
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Michael Thompson <michael.craig.thompson@gmail.com>
Cc: Phillip Hellewell <phillip@hellewell.homeip.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, mike@halcrow.us, mhalcrow@us.ibm.com,
       mcthomps@us.ibm.com, yoder1@us.ibm.com
In-Reply-To: <afcef88a0511210810m751e8d35p603915edf96a67c6@mail.gmail.com>
References: <20051119041130.GA15559@sshock.rn.byu.edu>
	 <20051119041740.GD15747@sshock.rn.byu.edu>
	 <84144f020511190247n5cf17800lb4ff019aa406470@mail.gmail.com>
	 <afcef88a0511210810m751e8d35p603915edf96a67c6@mail.gmail.com>
Date: Mon, 21 Nov 2005 18:21:29 +0200
Message-Id: <1132590089.8487.11.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/19/05, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> > > +       ecryptfs_printk(1, KERN_NOTICE, "Enter; lower_dentry = [%p], "
> > > +                       "lower_dentry->d_name.name = [%s], dentry = "
> > > +                       "[%p], dentry->d_name.name = [%s], sb = [%p]; "
> > > +                       "flag = [%.4x]; lower_dentry->d_count "
> > > +                       "= [%d]; dentry->d_count = [%d]\n", lower_dentry,
> > > +                       lower_dentry->d_name.name, dentry, dentry->d_name.name,
> > > +                       sb, flag, atomic_read(&lower_dentry->d_count),
> > > +                       atomic_read(&dentry->d_count));
> >
> > Could you use KERN_DEBUG instead and drop ecryptfs_printk()?

On Mon, 2005-11-21 at 10:10 -0600, Michael Thompson wrote:
> I don't follow with what you mean. We use ecryptfs_printk for 2 reasons:

Okay, let me spell it out for you: I think it is damn ugly :-)

> 1) Debugging. There is (or atleast at one time was) a large amount of
> ecryptfs_printk's scattered around during the development process.
> Obviously, much has been removed because we don't need them much
> anymore. However, the normal printk functionality doesn't, afaik,
> provide function & line number by default. ecryptfs_printk inserts it
> automatically for easy of use.

Like you said, not all debugging aids should be merged. I don't think
function and line number is enough an argument to justify putting your
own printk() in. That's my thinking anyway.

> 2) Verbosity switch. The intent, eventually atleast, is to be able to
> toggle the value of the verbosity level of ecryptfs at run time (this
> isn't implemented at the moment)... or atleast that's my plan :P Its
> not my project so I have to get "approval" etc. The 0th argument is
> the verbosity in which this message applies (1 being just informative,
> 0 being critical).

Do you really need it? Wouldn't it be better if you figured out which
debug printk() statements make sense and leave those in with KERN_DEBUG?

			Pekka

