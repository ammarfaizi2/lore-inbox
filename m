Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbVJSLuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbVJSLuA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 07:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbVJSLt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 07:49:59 -0400
Received: from nutty.inf.ed.ac.uk ([129.215.216.3]:7348 "EHLO
	nutty.inf.ed.ac.uk") by vger.kernel.org with ESMTP id S1750788AbVJSLt7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 07:49:59 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] libata: fix broken Kconfig setup
Date: Wed, 19 Oct 2005 12:49:35 +0100
User-Agent: KMail/1.7.1
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       davej@redhat.com
References: <20051017044606.GA1266@havoc.gtf.org> <4353DB2C.10905@pobox.com> <Pine.LNX.4.64.0510171017010.3369@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510171017010.3369@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510191249.36126.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 October 2005 18:25, Linus Torvalds wrote:
> On Mon, 17 Oct 2005, Jeff Garzik wrote:
> > Linus Torvalds wrote:
> > > Btw, if you want to have the _question_ always be y/n only, that's easy
> > > enough to do, just make that one do
> > >
> > > 	config SATA_MENU
> > > 		bool "Want to see SATA drivers"
> > > 		depends on SCSI != n
> > >
> > > 	config SCSI_SATA
> > > 		tristate
> > > 		depends on SCSI && SATA_MENU
> > > 		default y
> > >
> > > and now you have a totally sensible setup, where the low-level drivers
> > > can depend on something sane.
> > > I don't think it _buys_ you anything, but hey, at least it's logical.
> >
> > That's a reasonable solution.  I think it does buy you reduced user
> > confusion.
>
> The thing that worries me is that while the question may appear a bit more
> straightforward that way, I actually think it makes the end result _less_
> so.
>
> Let's say that I'm a clueless user, and I just don't realize that SATA
> depends on SCSI. After all, to a user, SATA sure as hell isn't SCSI,
> that's just an implementation detail inside the kernel.
>
> So I've happened to say "m" to SCSI (for whatever reason - don't ask why
> users do strange things, but maybe I realize that USB storage needs it),
> and now I see the question for SATA. And I say "y".
>
> And then I wonder why I can only select my sata drivers as modules. I
> didn't ask for SATA as a module, but they refuse to say "m".
>
> Now, with SCSI_SATA as a straight M/n choice (or whatever), if I had SCSI
> as a module, at least I'll see at SATA selection time that I can only
> compile SATA drivers as modules. I might wonder at that time why, but I
> think it's less confusing there (and we could even mention it in the
> help-text).
>
[snip]

Pretty much this exact thing happened to me. SATA=y when SCSI=y, then I 
selected my mainboard's SATA chipset (NFORCE=y), then a few kernels later I 
went back to set SCSI=m (I can't remember the rationale, something to do with 
udev and me thinking I didn't need to compile SCSI into the kernel).

Of course, without asking me, this changed my SATA chipset driver to a module, 
and the resulting kernel wouldn't get to init (because I was attempting to 
boot from a disc on the SATA controller).

This particular issue is perhaps more difficult to resolve, but I think this 
illustrates that a conceptual link between SCSI and SATA is a bad idea at the 
KConfig level (even if, within the kernel, SATA depends on parts of SCSI).

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
