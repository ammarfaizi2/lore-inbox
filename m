Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263777AbTFCTn0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 15:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbTFCTn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 15:43:26 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:23300 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263777AbTFCTnY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 15:43:24 -0400
Date: Tue, 3 Jun 2003 21:56:51 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Stig Brautaset <stig@brautaset.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: strange dependancy generation bug?
Message-ID: <20030603195651.GA17845@mars.ravnborg.org>
Mail-Followup-To: Stig Brautaset <stig@brautaset.org>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <fa.er84418.1ikmjqq@ifi.uio.no> <fa.hfbafvn.n7qkih@ifi.uio.no> <20030603191154.GA30323@brautaset.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030603191154.GA30323@brautaset.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 03, 2003 at 08:11:54PM +0100, Stig Brautaset wrote:
> > What happens is that within Makefile.build there is used multi line
> > definition, where each new-line causes make to launch a new sub-shell.
> > The command for the second sub-shell is echoed, even though make is told
> > not to do so. 
> 
> I beg to differ. Since make launches a new subshell, the commands in the
> second subshell is _not_ told to shut up, and thus is echoed. No?

In make a so-called "canned command sequence" is generated.
Quote from 'info make':

	On the other hand, prefix characters on the command line that refers
	to a canned sequence apply to every line in the sequence.  So the rule:

	     frob.out: frob.in
        	     @$(frobnicate)

	does not echo _any_ commands.


In kbuild this is exactly what happens.
So according to make info the command for the second sub-shell should not
be echoed.

	Sam
