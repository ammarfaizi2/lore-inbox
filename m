Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267923AbUJTCvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267923AbUJTCvY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 22:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270215AbUJTCuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 22:50:23 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:63716 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S270292AbUJTCnn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 22:43:43 -0400
Date: Wed, 20 Oct 2004 04:43:42 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: LKML <linux-kernel@vger.kernel.org>,
       Vserver <vserver@list.linux-vserver.org>
Subject: Re: [Vserver] PROBLEM: Oops in log_do_checkpoint, using vserver
Message-ID: <20041020024342.GA9260@mail.13thfloor.at>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>,
	Vserver <vserver@list.linux-vserver.org>
References: <20041018032511.GY21419@ns.snowman.net> <20041018115523.GA2352@mail.13thfloor.at> <20041018122025.GA28813@ns.snowman.net> <20041019220100.GB12780@ns.snowman.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041019220100.GB12780@ns.snowman.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2004 at 06:01:00PM -0400, Stephen Frost wrote:
> * Stephen Frost (sfrost@snowman.net) wrote:
> > * Herbert Poetzl (herbert@13thfloor.at) wrote:
> > > have seen that too, once in a while, but there where
> > > some changes in 2.6.9, so maybe trying 2.6.9-rc4
> > > (or soon final) with vs1.9.3-rc3 (not much changed
> > > here, see delta for details) would be a good check
> > 
> > Ok.  I had been planning on moving to 2.6.9 and 1.9.3 as soon as both
> > were final.  Guess I can try the RC releases though. :)
> 
> Alright, I got the same oops w/ 2.6.9 and vs1.9.3-rc3:
> 
> Assertion failure in log_do_checkpoint() at fs/jbd/checkpoint.c:361: 
> "drop_count != 0 || cleanup_ret != 0"

you can split up this assertion into

 - drop_count != 0
 - cleanup_ret != 0

and fail on that (or just output those values
before you panic) ... this might give some
deeper insight into the issue ...

> 
> I noticed someone else had this problem too:
> 
> http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=123137

hmm, so that kernel should not be vserver related
at all, so I'd say something with the ext3 journal
is broken ...

> I also followed up on that w/ my oops from 2.6.8.1.
> 
> I also upgraded to 0.30.195, though I don't think that (or vserver in
> general, really) is related to this oops.

yeah, probably not, I think the vserver changes 
just make the oops more likely (or simply the 
increased load does)

> If there's anything else I can do to help get this resolved, please let
> me know..  This is the only problem I'm having with this server now,
> other than this it's behaving pretty nicely. :)

maybe until it gets fixed, mounting the ext3
without journal might help here?

best,
Herbert

> 	Thanks,
> 
> 		Stephen



> _______________________________________________
> Vserver mailing list
> Vserver@list.linux-vserver.org
> http://list.linux-vserver.org/mailman/listinfo/vserver

