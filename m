Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272295AbTG3BCS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 21:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272315AbTG3BCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 21:02:18 -0400
Received: from unity.unh.edu ([132.177.137.40]:42369 "EHLO unity.unh.edu")
	by vger.kernel.org with ESMTP id S272295AbTG3BCR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 21:02:17 -0400
Date: Tue, 29 Jul 2003 21:02:12 -0400
From: Samuel Thibault <Samuel.Thibault@ens-lyon.fr>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] single return paradigm
Message-ID: <20030730010212.GD3100@bouh.unh.edu>
Reply-To: Samuel Thibault <samuel.thibault@fnac.net>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030726221655.GB1148@bouh.unh.edu> <1059302602.12754.3.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1059302602.12754.3.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4i-nntp
X-MailScanner-Information: http://pubpages.unh.edu/notes/mailfiltering.html
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-8.3, required 5,
	BAYES_10, IN_REP_TO, QUOTED_EMAIL_TEXT, REFERENCES,
	REPLY_WITH_QUOTES, USER_AGENT_MUTT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le dim 27 jui 2003 11:43:22 GMT, Alan Cox a tapoté sur son clavier :
> On Sad, 2003-07-26 at 23:16, Samuel Thibault wrote:
> > The "single return" paradigm of drivers/char/vt.c:tioclinux() surprised
> > me at first glance. But I'm now trying to maintain a patch which adds
> > probes at entry and exit of functions for performance instrumenting
> 
> gcc will already dop that for you

Indeed. The thing is that this automatic call only gives you the
function address and its caller site (yes, it couldn't give much more),
so you have to lookup symbols in the System.map, you can't do this with
modules (at least for non-exported functions which don't appear in
/proc/ksyms), and you can't get the return code.

I'll yet add this possibility for quickly adding tracing to a particular
file by just adding CFLAGS_file.o=-finstrument-functions to the Makefile,
before progressively replacing it by hand-written probes with the wanted
parameters. The single-exit issue still remains then.

Thanks anyway,
Regards,
Samuel
