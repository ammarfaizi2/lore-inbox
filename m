Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267413AbUHZE3j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267413AbUHZE3j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 00:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267460AbUHZE3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 00:29:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:418 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267413AbUHZE3h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 00:29:37 -0400
Date: Thu, 26 Aug 2004 05:29:36 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Chris Wright <chrisw@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Rik van Riel <riel@redhat.com>, Tim Hockin <thockin@hockin.org>,
       Mike Waychison <Michael.Waychison@Sun.COM>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Hans Reiser <reiser@namesys.com>
Subject: Re: Using fs views to isolate untrusted processes: I need an assistant architect in the USA for Phase I of a DARPA funded linux kernel project
Message-ID: <20040826042936.GR21964@parcelfarce.linux.theplanet.co.uk>
References: <410D96DC.1060405@namesys.com> <Pine.LNX.4.44.0408251624540.5145-100000@chimarrao.boston.redhat.com> <20040825205618.GA7992@hockin.org> <30958D95-F6ED-11D8-A7C9-000393ACC76E@mac.com> <412D2BD2.2090408@sun.com> <EAB989A6-F6F9-11D8-A7C9-000393ACC76E@mac.com> <20040825180615.Z1973@build.pdx.osdl.net> <BCE1F8F8-F716-11D8-A7C9-000393ACC76E@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BCE1F8F8-F716-11D8-A7C9-000393ACC76E@mac.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 12:16:43AM -0400, Kyle Moffett wrote:
> I'm well aware of the technique, but I was wondering if there was any
> extra VFS baggage associated with a normal bind mount that might
> be eliminated by restricting a different version of a bind mount to only
> files.  That's why I asked later if anybody had benchmarked the bind
> mount system to see how well it would scale to 1000 bound files and
> directories.  If it's not a performance issue then I really don't care 
> less,
> but I have a somewhat old box that must make do as a fileserver, so
> I'm very interested in maximizing the performance. I don't care much
> about extra RAM consumption, only about CPU and bus usage.

Files and directories are not different in that respect - the only overhead
is price of hash lookup when crossing the binding in either case.  1000
bindings shouldn't be a problem - it's 3--5 per hash chain.  Wrt memory,
it's one struct vfsmount allocated per binding - IOW, about 80Kb total
for 1000 of those.
