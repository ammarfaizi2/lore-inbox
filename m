Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266090AbUF2Vhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266090AbUF2Vhu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 17:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266089AbUF2Vhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 17:37:50 -0400
Received: from mailer1.psc.edu ([128.182.58.100]:59343 "EHLO mailer1.psc.edu")
	by vger.kernel.org with ESMTP id S266084AbUF2Vhp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 17:37:45 -0400
Date: Tue, 29 Jun 2004 17:36:45 -0400 (EDT)
From: John Heffner <jheffner@psc.edu>
To: Stephen Hemminger <shemminger@osdl.org>
cc: "David S. Miller" <davem@redhat.com>, <debi.janos@freemail.hu>,
       <linux-kernel@vger.kernel.org>, <linux-net@vger.kernel.org>
Subject: Re: 2.6.7-mm1 - 2.6.7-mm4 weird http behavior
In-Reply-To: <20040629140242.1e274ffb@dell_ss3.pdx.osdl.net>
Message-ID: <Pine.NEB.4.33.0406291729500.11034-100000@dexter.psc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jun 2004, Stephen Hemminger wrote:

> On Tue, 29 Jun 2004 13:59:22 -0700
> "David S. Miller" <davem@redhat.com> wrote:
>
> > On Tue, 29 Jun 2004 13:35:01 -0700
> > Stephen Hemminger <shemminger@osdl.org> wrote:
> >
> > > FYI - gentoo works for window scale 0..2 and appears to fail for >3.
> > >
> > > Also, the socket ends up with:
> > >
> > > State      Recv-Q Send-Q      Local Address:Port          Peer Address:Port
> > > ESTAB      0      0             172.20.1.73:34452       198.63.211.232:http
> > >          ts sack wscale:0,3 rto:332 rtt:66.375/50.5 cwnd:3
> >
> > Yes, I've seen this declared in other reports too.
> >
> > It probably means just that for window scales of 0..2 the misinterpretation
> > does not result in a too-small-to-send-data window.
> >
> > But I'm still confused that the scaled window is being given to the
> > receiver, and this makes the connection freeze.  I wonder if there is
> > a queer box doing NAT or similar in front of the gentoo machine which
> > either:
> >
> > 1) Applies any window scaling to both directions
> > 2) Applies window scaling to the wrong direction
> >
> > and uses this to "help" with dropping of out-of-window TCP segments.
>
> Unfortunately, this means the default probably means that window scale must be
> disabled. An interesting experiment would be to see if other implementations have
> the same problem with window scale enabled.


Sigh.  I ran in to this problem a year or so ago and it was a broken
firewall that was mangling the TCP window scale option.  I think the
firewall was an OpenBSD machine, and I was told the problem went away with
an upgrade.  I'm curious what they're running here.

The boundary 3 is special because it causes SWS avoidance to break.

  -John

