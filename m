Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbTJ1Xkr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 18:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbTJ1Xkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 18:40:47 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:3310 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261755AbTJ1Xkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 18:40:46 -0500
Date: Wed, 29 Oct 2003 00:40:41 +0100
From: Jan Kara <jack@suse.cz>
To: Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
       Alex Lyashkov <shadow@itt.net.ru>
Subject: Re: Linux 2.4 quota (accounting?) bug ...
Message-ID: <20031028234037.GB29342@atrey.karlin.mff.cuni.cz>
References: <20031025162640.GA24020@DUK2.13thfloor.at> <20031025163128.GA20786@atrey.karlin.mff.cuni.cz> <20031025174225.GB24020@DUK2.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031025174225.GB24020@DUK2.13thfloor.at>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Hi,
> On Sat, Oct 25, 2003 at 06:31:28PM +0200, Jan Kara wrote:
> >   Hi,
> > 
> > > a friend of mine, made me aware of the following
> > > imbalance, which looks like a minor accounting bug 
> > > to me, but might be a quota bug ...
> >   Sorry but the code seems correct to me - we get reference to dquot by
> > get_dquot_ref() and than we put the reference by dqput(). dqput() is
> > correct because something nasty might happen in the mean time and so we
> > might be the last holders of the dquot. What do you think is wrong?
> 
> dqput() does dqstats.drops++;
> which isn't correct if this should be the same as
> put_dquot_ref(), but maybe I'm just irritated by 
> strange statistics on some kernels showing more
> drops than lookups+allocated after sync/quotaoff
  Oh, now I see... At first I didn't understand that the problem is in
the quota statistics. I'll fix that.

							Honza
