Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130195AbRAQSCT>; Wed, 17 Jan 2001 13:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131455AbRAQSCA>; Wed, 17 Jan 2001 13:02:00 -0500
Received: from Cantor.suse.de ([194.112.123.193]:61198 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S130195AbRAQSBz>;
	Wed, 17 Jan 2001 13:01:55 -0500
Date: Wed, 17 Jan 2001 19:01:26 +0100
From: Andi Kleen <ak@suse.de>
To: Tony Gale <gale@syntax.dera.gov.uk>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
        Jussi Hamalainen <count@theblah.org>
Subject: Re: IP defrag (was RE: ipchains blocking port 65535)
Message-ID: <20010117190126.B2859@gruyere.muc.suse.de>
In-Reply-To: <20010117183547.A2528@gruyere.muc.suse.de> <XFMail.20010117174430.gale@syntax.dera.gov.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <XFMail.20010117174430.gale@syntax.dera.gov.uk>; from gale@syntax.dera.gov.uk on Wed, Jan 17, 2001 at 05:44:30PM -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 17, 2001 at 05:44:30PM -0000, Tony Gale wrote:
> 
> On 17-Jan-2001 Andi Kleen wrote:
> > 
> > Connection tracking always defrags as needed.
> > masquerading/NAT/iptables 
> > with connection tracking uses that.
> > 
> > This means that if any of these are enabled and your machine acts
> > as a 
> > router lots of CPU could get burned in defragmentation, and packets
> > will not forwarded until all fragments arrived.
> 
> Hmm... ok, what if I'm on a single nic system using ipchains on the
> input and want to always defrag before they hit the ipchains
> filter, what settings would I need? No masq., no NAT. (bearing in
> mind that ipchains differentiates between SYN+frag and noSYN+frag.

You probably need to just load ip_conntrack_standalone and make sure it runs.
It has a higher priority than ipchains in the prerouting chain and should just defragment 
things. 

Better would it be to just write a small netfilter module with a higher
priority than ipchains that always defrags. 

Actually I thought I've once seen such a beast, but it doesn't seem to
be included in the main kernel now that I look for it.  It's all only a few 
lines of code anyways.


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
