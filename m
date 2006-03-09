Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbWCIR1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbWCIR1i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 12:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbWCIR1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 12:27:38 -0500
Received: from mx1.redhat.com ([66.187.233.31]:36810 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750937AbWCIR1h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 12:27:37 -0500
Date: Thu, 9 Mar 2006 12:27:23 -0500
From: Dave Jones <davej@redhat.com>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: Al Viro <viro@ftp.linux.org.uk>, "David S. Miller" <davem@davemloft.net>,
       linux-kernel@vger.kernel.org
Subject: Re: filldir[64] oddness
Message-ID: <20060309172722.GB9876@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Bryan O'Sullivan <bos@serpentine.com>,
	Al Viro <viro@ftp.linux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org
References: <20060309042744.GA23148@redhat.com> <20060308.203204.115109492.davem@davemloft.net> <20060309044025.GS27946@ftp.linux.org.uk> <1141923743.17294.8.camel@localhost.localdomain> <20060309170740.GA9876@redhat.com> <1141924514.17294.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141924514.17294.18.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 09:15:14AM -0800, Bryan O'Sullivan wrote:
 > On Thu, 2006-03-09 at 12:07 -0500, Dave Jones wrote:
 > 
 > >  > About half of the ~50 reports I've looked at so far in their database
 > >  > have been false positives.  In most of those cases, it's not obvious how
 > >  > a checker might have gotten them right instead, though.
 > > 
 > > It seems to stumble quite a bit when faced with things that are
 > > free'd when refcounts drop to zero. (skbs, and kobjects).
 > 
 > Yes, or (in my case) stuff like "when this variable has value X, that
 > pointer can't possibly be NULL".

*nod*
It does call into question the "OMFG, there are 1000 bugs in the kernel"
hysteria that has found its way through various news forums.
The genuine bugs it does find are gold dust though.  There's a bunch
of stuff that's sat there for an eternity. It's just painstaking to
grovel through the reports weeding out the false positives.

A lot of the 'bugs' it's found are also not really going to make
the world stop turning soon. It even picked up a few cases of
code doing like.

void foo()
{
	int x;

	while (read status from hardware reg != READY)
		x++;
}

as uninitialised. Which is true, but as there's nothing
dependant on it, it's harmless.

		Dave

-- 
http://www.codemonkey.org.uk
