Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272442AbTHNQdw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 12:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272449AbTHNQdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 12:33:52 -0400
Received: from waste.org ([209.173.204.2]:36751 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S272442AbTHNQds (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 12:33:48 -0400
Date: Thu, 14 Aug 2003 11:33:25 -0500
From: Matt Mackall <mpm@selenic.com>
To: Robert Love <rml@tech9.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, James Morris <jmorris@intercode.com.au>,
       "David S. Miller" <davem@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cryptoapi: Fix sleeping
Message-ID: <20030814163325.GL325@waste.org>
References: <20030813233957.GE325@waste.org> <3F3AD5F1.8000901@pobox.com> <1060821251.4709.449.camel@lettuce> <20030814015820.GH325@waste.org> <1060878560.4709.474.camel@lettuce>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060878560.4709.474.camel@lettuce>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 14, 2003 at 09:29:20AM -0700, Robert Love wrote:
> On Wed, 2003-08-13 at 18:58, Matt Mackall wrote:
> 
> > This is part of cryptoapi and given the large chunks of work you could
> > potentially hand to it, it's probably a good idea for it to work this
> > way. You hand it a long list of sg segments, it does the transform and
> > reschedules if it thinks it's safe. But its test of when it was safe
> > was not complete.
> 
> Right.  My concern is that you said sometimes it is called when
> preemption is disabled.

Sure, but it's called here rather indirectly. Apparently I'm the first
person to try using cryptoapi with per_cpu. And at present there's
nothing in the api to tell it "don't do that" - but see my followup
patch.
 
-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
