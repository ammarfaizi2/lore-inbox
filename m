Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267607AbUHZFBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267607AbUHZFBr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 01:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267623AbUHZFBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 01:01:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20390 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267607AbUHZFBp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 01:01:45 -0400
Date: Thu, 26 Aug 2004 06:01:45 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Chris Wright <chrisw@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Rik van Riel <riel@redhat.com>, Tim Hockin <thockin@hockin.org>,
       Mike Waychison <Michael.Waychison@Sun.COM>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Hans Reiser <reiser@namesys.com>
Subject: Re: Using fs views to isolate untrusted processes: I need an assistant architect in the USA for Phase I of a DARPA funded linux kernel project
Message-ID: <20040826050145.GT21964@parcelfarce.linux.theplanet.co.uk>
References: <410D96DC.1060405@namesys.com> <Pine.LNX.4.44.0408251624540.5145-100000@chimarrao.boston.redhat.com> <20040825205618.GA7992@hockin.org> <30958D95-F6ED-11D8-A7C9-000393ACC76E@mac.com> <412D2BD2.2090408@sun.com> <EAB989A6-F6F9-11D8-A7C9-000393ACC76E@mac.com> <20040825180615.Z1973@build.pdx.osdl.net> <BCE1F8F8-F716-11D8-A7C9-000393ACC76E@mac.com> <20040826042936.GR21964@parcelfarce.linux.theplanet.co.uk> <C08CA144-F71B-11D8-A7C9-000393ACC76E@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C08CA144-F71B-11D8-A7C9-000393ACC76E@mac.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 12:52:37AM -0400, Kyle Moffett wrote:
> Where would I increase the hash size if I wanted to increase the number
> of bindings by an order of magnitude or so?  I'm very interested in
> pursuing this possibility, because when combined with the procedure I
> described earlier, plus a little bit of extra work with capabilities 
> and such
> it's very easy to build incredibly flexible and basically indestructible
> chroot environments with not much code.

*shrug*

fs/namespace.c::mnt_init().  Right now it allocates 1 page for hash table
(order = 0), you can easily raise that.  You might want to try and change
the order of checks in lookup_mnt() loop - depending on your setup it
might speed the things up, but I doubt that it would be noticable win.
