Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbWBFQeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWBFQeN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 11:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWBFQeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 11:34:13 -0500
Received: from smtp112.sbc.mail.mud.yahoo.com ([68.142.198.211]:46183 "HELO
	smtp112.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932200AbWBFQeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 11:34:12 -0500
From: David Brownell <david-b@pacbell.net>
To: "Carlo E. Prelz" <fluido@fluido.as>
Subject: Re: [linux-usb-devel] Re: ATI RS480-based motherboard: stuck while booting with kernel >= 2.6.15 rc1
Date: Mon, 6 Feb 2006 08:24:04 -0800
User-Agent: KMail/1.7.1
Cc: linux-usb-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20060120123202.GA1138@epio.fluido.as> <200602051145.22933.david-b@pacbell.net> <20060206080251.GA23014@epio.fluido.as>
In-Reply-To: <20060206080251.GA23014@epio.fluido.as>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602060824.04945.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 February 2006 12:02 am, Carlo E. Prelz wrote:
> 
> > Interesting ... feels like a BIOS problem.  If you want to experiment,
> > there's a right bracket -- "}" -- immediately before that.  Try moving
> > it right after that write, so that write_config_byte is covered by the
> > preceding "if LEGSUP_BIOS" test; or copying the much later "disable SMI"
> > clause into an "else" for that "if".
> 
> The first one would be useless - I inserted lots of printouts to find
> out where the freeze took place, and I know that the 
> EHCI_USBLEGSUP_BIOS flag is on (cap is 0x10001). The value remains the
> same after the 'spin till it hands it over' loop - so that this
> printout appears:
> 
> 0000:00:13.2 EHCI: BIOS handoff failed (BIOS bug ?)

If it printed that, then how is it possible that it hung _before_ printing
that message???  Your reports are not making any sense to me.

Maybe that whole "if" block that turns that SMI _on_ is the problem; it
was part of the "early handoff" code, which came from who knows where,
was clearly buggy, and was never widely used until recently.  Enabling
the SMI seemed pretty dubious to me, but I suspect that some undescribed
buggy BIOS really does need it ... maybe whoever provided that "early"
handoff version could report what they were trying to do by enabling
the SMI?

- Dave

