Return-Path: <linux-kernel-owner+w=401wt.eu-S933006AbWLSXgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933006AbWLSXgc (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 18:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933007AbWLSXgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 18:36:32 -0500
Received: from smtp103.sbc.mail.mud.yahoo.com ([68.142.198.202]:40689 "HELO
	smtp103.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S933006AbWLSXgb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 18:36:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=Me2wAy6bcD5OsiIZV6qGV0VZcshqk/IPek0J2ObBgV/vJunHCtwGjntOHLHzC2qXYgJVhHWqSdYM7Fb7pOQQQM6yvaCbkcO05d/mYAxsy4KjgqKGjRMbnhyKzOddky2YlYYEPgPZA4CBNHJxTAQlJhVDlX/BIP/iEgPwCvZdA3c=  ;
X-YMail-OSG: Bte4hecVM1n9jZUDk0KuImVhlY3SHYcDxGNH1nu0EPpykd725Uq5q6FYS.VhX9cQw3YDgHe4KFupxoTnFng651BbpkyRdN2rVGBRO7KDNj2dczyBd7eIwY9rlXSTzm3DzJN9FACqFEC2ZjibNS0ljHqR8KUgKlk2ahYgLZZ5ibjvNcYxHSvimgyXKPZn
From: David Brownell <david-b@pacbell.net>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Changes to PM layer break userspace
Date: Tue, 19 Dec 2006 15:36:28 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de
References: <20061219185223.GA13256@srcf.ucam.org> <200612191322.13378.david-b@pacbell.net> <20061219225729.GA15777@srcf.ucam.org>
In-Reply-To: <20061219225729.GA15777@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612191536.28998.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 December 2006 2:57 pm, Matthew Garrett wrote:
> On Tue, Dec 19, 2006 at 01:22:12PM -0800, David Brownell wrote:

> > As a generic mechanism, that interface has *ALWAYS* been "broken
> > by design"; I'd call it unfixable.  It's deprecated, and scheduled
> > to vanish; see Documentation/feature-removal-schedule.txt ...
> 
> The fact that something is scheduled to be removed in July 2007 does 
> *not* mean it's acceptable to break it in 2006. We need to find a way to 
> fix this functionality in the meantime.

The disconnect here is analagous to:  I tell you the alleged perpetual
motion machine never worked, and can't ever work; and you push back and
say that you need a perpetual motion machine that works, NOW please,
because you need something that pushes those widgets around.  (There are
better ways to push widgets than side effects of a broken machine...)


Given that your examples are network adapters, you should really look
more at why "ifdown eth0" (etc) having drivers put the device into a
low power state (like PCI D3hot, or maybe D2) wouldn't work in any
particular case.  If you actually have such cases, then maybe those
specific drivers need to drive new power management interfaces.

That's a workable approach to resolving the underlying problem in the
long term.  In the short term, notice the system still works correctly
if you don't try writing those files.

I'd not be keen on reverting Linus' patch [1] myself, even though few
drivers have started to use that mechanism yet; that would be a step
backwards, and would perpetuate users of that broken sysfs file.

- Dave

[1] cbd69dbbf1adfce6e048f15afc8629901ca9dae5

