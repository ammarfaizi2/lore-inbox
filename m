Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268069AbUHKO0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268069AbUHKO0H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 10:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268070AbUHKO0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 10:26:07 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:59919 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id S268069AbUHKO0E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 10:26:04 -0400
Message-ID: <20040811182602.A2055@castle.nmd.msu.ru>
Date: Wed, 11 Aug 2004 18:26:02 +0400
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Jirka Kosina <jikos@jikos.cz>, Giuliano Pochini <pochini@shiny.it>,
       linux-kernel@vger.kernel.org
Subject: Re: FW: Linux kernel file offset pointer races
References: <XFMail.20040805104213.pochini@shiny.it> <Pine.LNX.4.58.0408051228400.2791@twin.jikos.cz> <20040807171500.GA26084@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <20040807171500.GA26084@logos.cnet>; from "Marcelo Tosatti" on Sat, Aug 07, 2004 at 02:15:00PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BTW, f_pos assignments are non-atomic on IA-32 since it's a 64-bit value.
The file position is protected by the BKL in llseek(), but I do not see any
serialization neither in sys_read() nor in generic_file_read() and other
methods.

Have we accepted that the file position may be corrupted after crossing 2^32
boundary by 2 processes reading in parallel from the same file?
Or am I missing something?

	Andrey

On Sat, Aug 07, 2004 at 02:15:00PM -0300, Marcelo Tosatti wrote:
> On Thu, Aug 05, 2004 at 12:30:23PM +0200, Jirka Kosina wrote:
> > On Thu, 5 Aug 2004, Giuliano Pochini wrote:
> > 
> > > I don't remember if this issue has already been discussed here:
> > > -----FW: <Pine.LNX.4.44.0408041220550.26961-100000@isec.pl>-----
> > > Date: Wed, 4 Aug 2004 12:22:42 +0200 (CEST)
> > > From: Paul Starzetz <ihaquer@isec.pl>
> > > To: bugtraq@securityfocus.com, vulnwatch@vulnwatch.org,
> > >  full-disclosure@lists.netsys.com
> > > Subject: Linux kernel file offset pointer races
> > 
> > It hasn't been discussed here, but at 
> > http://linux.bkbits.net:8080/linux-2.4/gnupatch@411064f7uz3rKDb73dEb4vCqbjEIdw 
> > you can find a patchset fixing (some of) the mentioned problems. This 
> > patchset is from 2.4.27-rc5
> 
> "some of" ? 
> 
> Do you know any unfixed still broken piece of driver code ? 
