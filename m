Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbTD1XsX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 19:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbTD1XsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 19:48:23 -0400
Received: from holomorphy.com ([66.224.33.161]:61384 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261180AbTD1XsV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 19:48:21 -0400
Date: Mon, 28 Apr 2003 17:00:14 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Jones <davej@codemonkey.org.uk>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Dave Hansen <haveblue@us.ibm.com>, Andi Kleen <ak@suse.de>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Henti Smith <bain@tcsn.co.za>, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: maximum possible memory limit ..
Message-ID: <20030429000014.GA30441@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave Jones <davej@codemonkey.org.uk>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Dave Hansen <haveblue@us.ibm.com>, Andi Kleen <ak@suse.de>,
	Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
	Henti Smith <bain@tcsn.co.za>, linux-kernel@vger.kernel.org,
	lse-tech@lists.sourceforge.net
References: <20030424200524.5030a86b.bain@tcsn.co.za> <3EAD27B2.9010807@gmx.net> <20030428141023.GC4525@Wotan.suse.de> <3EAD44BF.30808@gmx.net> <20030428151648.GF4525@Wotan.suse.de> <3EAD5C44.103@us.ibm.com> <483810000.1051549109@[10.10.2.4]> <20030428224025.GW30441@holomorphy.com> <20030428235023.GE26105@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030428235023.GE26105@suse.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 28, 2003 at 03:40:25PM -0700, William Lee Irwin III wrote:
>> Most of the driver stuff I've seen is ioremap() of O(PAGE_SIZE) which
>> just gets denied so it fails to probe. IDE was worse (as usual), and
>> AGP needed an unusual amount of tweaking, which probably will be
>> typical for the graphics drivers in general.

On Tue, Apr 29, 2003 at 12:50:23AM +0100, Dave Jones wrote:
> Is this stuff in the current pgcl patch? I've not looked at it,
> but wouldn't mind a look-see sometime.

Not much of it. Basically I've only swept the drivers for the systems
I've been hacking on. My driver-fu is limited anyway. Most of it is
really boring, basically changing size specifications for blocks of
memory used by the driver from being defined in terms of MMUPAGE_SIZE
when they need to be in 4KB units (which is the hardware pagesize on
most cpus).

IDE was sizing its PRD tables in terms of PAGE_SIZE, so that needed
quickfixing and it's otherwise mostly immune to the effect(s), and that's
in the patch. AGP was fiddling around with something, which very well may
have been some kind of GART aperture for all I know about it, and needed
to use MMUPAGE_SIZE to think of its size correctly. Hugh's 2.4.x code had
a better sampling of what's needed for DRM and AGP in general, along with
various fixes for other framebuffer drivers, but it predated 2.4.8, at
which time some kind of enormous DRM merge happened and clobbered things.

-- wli
