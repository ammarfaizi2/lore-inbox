Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264098AbUESHaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264098AbUESHaZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 03:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264076AbUESHaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 03:30:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:9089 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264098AbUESHaR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 03:30:17 -0400
Date: Wed, 19 May 2004 00:30:13 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andy Lutomirski <luto@myrealbox.com>
Cc: Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       olaf+list.linux-kernel@olafdietsche.de, Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH] scaled-back caps, take 4
Message-ID: <20040519003013.L21045@build.pdx.osdl.net>
References: <fa.dt4cg55.jnqvr5@ifi.uio.no> <40A4F163.6090802@stanford.edu> <20040514110752.U21045@build.pdx.osdl.net> <200405141548.05106.luto@myrealbox.com> <20040517231912.H21045@build.pdx.osdl.net> <40A9D356.6060807@stanford.edu> <20040518182751.J21045@build.pdx.osdl.net> <40AABE49.1050401@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <40AABE49.1050401@myrealbox.com>; from luto@myrealbox.com on Tue, May 18, 2004 at 06:54:17PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Lutomirski (luto@myrealbox.com) wrote:
> Chris Wright wrote:
> > This does change the current notion of layering.  I see your point though, 
> > likening it to say reading inode and finding S_ISUID bit.
> 
> On the other hand, no one would put reading of a SELinux security label 
> here.  But we already have fields in binprm specifically for commoncap.  I 
> have no strong preference.

Yes, I stopped short of that argument only because capabilities fall
into a bit more of a gray zone than other modules.  But I do prefer
leaving it in the module.

> >>The reason I killed the old algorithm is because it's scary (in the sense 
> >>of being complicated and subtle for no good reason) and because I don't see 
> >>the point of inheritable caps.  I doubt anything uses them currently on a 
> >>vanilla kernel because they don't _do_ anything.  So I killed them.
> > 
> > This does break all those caps aware apps (yeah, tongue-in-cheek ;-)
> > that actually have the idea to widen the effective set, yet limit the
> > inheriable set.  Seriously, I don't know how much this matters.
> 
> Yah, they're broken anyway right now if that's what they're doing.

On Linux they are.  On IRIX they aren't.  This is part of the issue as I
see it.

> The reason I didn't go for something like your approach (other than not 
> thinking of it) was that, as long as we're changing the semantics, we might 
> as well make them as clean as possible.  I also didn't mind ripping out 
> lots of old code :).  If the inheritable mask stays, then programs need to 
> be audited for what happens if they are run with different inheritable 
> masks.  I'd rather just eliminate that complication and the corresponding 
> blob of commoncap code.  Obviously my patch fails a lot of your tests as a 
> result.

Actually the only glaring difference (aside from the uid/suid and non-root
execs nonroot-yet-diff-id-setuid-app issue I mentioned earlier) is in
something like "=ep cap_setpcap-ep cap_ipc_lock+i" IIRC.

I have the feeling we both are after the same thing, which is introducing
the ability to keep some caps through exec and still being able to sleep
at night w/ confidence that there isn't some subtle new hole lurking.
This is why I aimed to change as little code as possible.

> So do we arm-wrestle over whose implementation wins? :)  I'd say mine wins 
> on readability (not your fault -- the old code was pretty bad to begin 
> with) and some simplicity, but yours has the benefit of being less intrusive.

Hehe, arm wrestling could be entertaining ;-)  I'm in favor of the most
conservative change, which I feel is in my patch.  But I'm game to
continue to pick on each.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
