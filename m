Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265276AbUAESQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 13:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265285AbUAESQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 13:16:26 -0500
Received: from scrat.hensema.net ([62.212.82.150]:53148 "EHLO
	scrat.hensema.net") by vger.kernel.org with ESMTP id S265276AbUAESQY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 13:16:24 -0500
Date: Mon, 5 Jan 2004 19:16:10 +0100
From: Erik Hensema <erik@hensema.net>
To: Ricky Beam <jfbeam@bluetronic.net>
Cc: Roland Dreier <roland@topspin.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0: something is leaking memory
Message-ID: <20040105181610.GB13674@bender.home.hensema.net>
Reply-To: erik@hensema.net
References: <52wu87wfzp.fsf@topspin.com> <Pine.GSO.4.33.0401051116240.26470-100000@sweetums.bluetronic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.33.0401051116240.26470-100000@sweetums.bluetronic.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 11:18:52AM -0500, Ricky Beam wrote:
> On 4 Jan 2004, Roland Dreier wrote:
> >Yup, looks like IPv6 is leaking memory (since your netstat shows
> >nowhere near 19K sockets):
> >
> > > tcp6_sock          19729  19732   1024    4    1 : tunables   54   27    0 : slabdata   4933   4933      0
> >
> >Now to figure out why...
> 
> Of course, there are a lot of sockets in CLOSE_WAIT.  That's where I'd
> start looking... if I actually cared about IPv6 :-)  There used to be the
> same sort of problem for IPv4 (sockets would never go away), but no one
> ever fixed it -- a rewrite of the network stack made it go away.

Those sockets in CLOSE_WAIT state are due to a filedescriptor leak in nscd
(or nss_ldap), which is a userspace problem.
It does however make the leak in kernelspace more visible it seems.
-- 
Erik Hensema (erik@hensema.net)
