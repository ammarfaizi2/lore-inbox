Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWFAHL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWFAHL2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 03:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbWFAHL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 03:11:27 -0400
Received: from gw.openss7.com ([142.179.199.224]:21652 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id S1750729AbWFAHL0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 03:11:26 -0400
Date: Thu, 1 Jun 2006 01:11:25 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: David Miller <davem@davemloft.net>, draghuram@rocketmail.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Question about tcp hash function tcp_hashfn()
Message-ID: <20060601011125.C22283@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	David Miller <davem@davemloft.net>, draghuram@rocketmail.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20060531090301.GA26782@2ka.mipt.ru> <20060531035124.B3065@openss7.org> <20060531105814.GB7806@2ka.mipt.ru> <20060531.114127.14356069.davem@davemloft.net> <20060601060424.GA28087@2ka.mipt.ru> <20060601001825.A21730@openss7.org> <20060601063012.GC28087@2ka.mipt.ru> <20060601004608.C21730@openss7.org> <20060601070136.GA754@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060601070136.GA754@2ka.mipt.ru>; from johnpol@2ka.mipt.ru on Thu, Jun 01, 2006 at 11:01:36AM +0400
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy,

On Thu, 01 Jun 2006, Evgeniy Polyakov wrote:

> On Thu, Jun 01, 2006 at 12:46:08AM -0600, Brian F. G. Bidulock (bidulock@openss7.org) wrote:
> > > Since pseudo-randomness affects both folded and not folded hash
> > > distribution, it can not end up in different results.
> > 
> > Yes it would, so to rule out pseudo-random effects the pseudo-
> > random number generator must be removed.
> > 
> > > 
> > > You are right that having test with 2^48 values is really interesting,
> > > but it will take ages on my test machine :)
> > 
> > Try a usable subset; no pseudo-random number generator.
> 
> I've run it for 2^30 - the same result: folded and not folded Jenkins
> hash behave the same and still both results produce exactly the same
> artifacts compared to XOR hash.

But not without the pseudo-random number generation... ?

> 
> Btw, XOR hash, as completely stateless, can be used to show how
> Linux pseudo-random generator works for given subset - it's average of
> distribution is very good.

But its distribution might auto-correlate with the Jenkins function.
The only way to be sure is to remove the pseudo-random number generator.

Just try incrementing from, say, 10.0.0.0:10000 up, resetting port number
to 10000 at 16000, and just incrementing the IP address when the port
number wraps, instead of pseudo-random, through 2^30 loops for both.
If the same artifacts emerge, I give in.

Can you show the same artifacts for jenkins_3word?

