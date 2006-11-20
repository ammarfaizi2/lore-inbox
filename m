Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966867AbWKTWQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966867AbWKTWQI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 17:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966873AbWKTWQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 17:16:07 -0500
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:56919 "HELO
	smtp109.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S966868AbWKTWPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 17:15:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Disposition:Message-Id:Content-Type:Content-Transfer-Encoding;
  b=rX8ueLcrHYpqAO+JcHbA22AJvt9o1ORPLy/eejFrofqD/+vUiekul+rou/P50UKcNe2x170a75F5kX9BFqlQDbBvAlW0iXDQ2cHZjNP7riBQF5LcVon4NI0lWA6qSnflDWOlkSEdT8Bh1G6dI1QIHz89r7fq10XvgvMcG1zz5Qc=  ;
X-YMail-OSG: HUzXJ6IVM1llu1wEzzBxxBcJ6CIUe4N9ZbLhFdAy1VrNAxLpQYwcK.aI2E3w5d049g27clEb72xxmKy1Ap8gXve320V.7b8lqN14mz7v1.5Wi9pojefAykiIxkPeV3fPowTHvoIv.S0t1DAhYICPuQE22aLYz5nuglo-
From: David Brownell <david-b@pacbell.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch/rfc 2.6.19-rc5] arch-neutral GPIO calls
Date: Mon, 20 Nov 2006 14:15:17 -0800
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Bill Gatliff <bgat@billgatliff.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>,
       Paul Mundt <lethal@linux-sh.org>
References: <200611111541.34699.david-b@pacbell.net> <4558C794.90602@billgatliff.com> <20061113201535.GA20388@linux-sh.org>
In-Reply-To: <20061113201535.GA20388@linux-sh.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200611201415.19095.david-b@pacbell.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, just trying to summarize here:

 - Nobody has reported **ANY** real problem with the API, other than a minor
   comment from Andrew Victor about a must_check annotation (resolved in a
   nyet-posted update).  No surprise; there are already nearly a dozen APIs
   in the kernel doing exactly the same thing.

 - Various folk want to see an additional API that can work with things like
   I2C GPIO expanders ... where the bit get/set calls require task contexts.
   Everyone agrees such a thing is eventually needed, but nobody needs it
   "today".

 - There's interest in a userspace interface to GPIOs; nothing pressing, and
   that's at a different level, but worth noting since it always comes up.

 - Paul Mundt also wants to see pin muxing APIs.  Fine, but that's both
   orthogonal and highly platform-specific.  I can't support trying to
   merge it into the generic notion of a GPIO line.

 - Paul also wants to see implementations package multiple sync/atomic GPIO
   controllers using this API.  The API that I pulled together clearly permits
   implementations to do that ... but it does not require them to do so.

I could certainly take all that feedback and let it lead me to some particular
implementation -- example, a table of { controller, index, flags } structs indexed
by the GPIO numbers, with controller ops vectors matching the primitives -- but
even if that were to happen, I'd like to know if anyone has any major disagreement
with the summary above.

- Dave
