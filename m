Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129806AbRAQRgS>; Wed, 17 Jan 2001 12:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130112AbRAQRgH>; Wed, 17 Jan 2001 12:36:07 -0500
Received: from Cantor.suse.de ([194.112.123.193]:2316 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129806AbRAQRgE>;
	Wed, 17 Jan 2001 12:36:04 -0500
Date: Wed, 17 Jan 2001 18:35:47 +0100
From: Andi Kleen <ak@suse.de>
To: Tony Gale <gale@syntax.dera.gov.uk>
Cc: Jussi Hamalainen <count@theblah.org>, linux-kernel@vger.kernel.org
Subject: Re: IP defrag (was RE: ipchains blocking port 65535)
Message-ID: <20010117183547.A2528@gruyere.muc.suse.de>
In-Reply-To: <Pine.LNX.4.30.0101171911010.21865-100000@shodan.irccrew.org> <XFMail.20010117171554.gale@syntax.dera.gov.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <XFMail.20010117171554.gale@syntax.dera.gov.uk>; from gale@syntax.dera.gov.uk on Wed, Jan 17, 2001 at 05:15:54PM -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 17, 2001 at 05:15:54PM -0000, Tony Gale wrote:
> 
> On 17-Jan-2001 Jussi Hamalainen wrote:
> > On Wed, 17 Jan 2001, Tony Gale wrote:
> > 
> >> It looks like this is due to the odd way in which ipchains handles
> >> fragments. Try:
> >>
> >> echo 1 > /proc/sys/net/ipv4/ip_always_defrag
> > 
> > Thanks, this seems to do the trick. Does this oddity still exist
> > in 2.4?
> > 
> 
> Well, I haven't found it, but there is
> /proc/sys/net/ipv4/ipfrag_high_thresh
> /proc/sys/net/ipv4/ipfrag_low_thresh
> /proc/sys/net/ipv4/ipfrag_time
> 
> Perhaps 2.4 always defrags packets by default. Anyone confirm? This
> is pretty much needed for any kind of firewall/masquerading system.

Connection tracking always defrags as needed. masquerading/NAT/iptables 
with connection tracking uses that.

This means that if any of these are enabled and your machine acts as a 
router lots of CPU could get burned in defragmentation, and packets
will not forwarded until all fragments arrived.

All very nasty, but unfortunately there is no alternative.


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
