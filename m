Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262414AbSIPPuv>; Mon, 16 Sep 2002 11:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262483AbSIPPuv>; Mon, 16 Sep 2002 11:50:51 -0400
Received: from ns.suse.de ([213.95.15.193]:46866 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S262414AbSIPPus>;
	Mon, 16 Sep 2002 11:50:48 -0400
Date: Mon, 16 Sep 2002 17:55:45 +0200
From: Dave Jones <davej@suse.de>
To: James Cleverdon <jamesclv@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, James.Bottomley@steeleye.com,
       torvalds@transmeta.com, alan@redhat.com, mingo@redhat.com
Subject: Re: [PATCH] Summit patch for 2.5.34
Message-ID: <20020916175545.A21875@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	James Cleverdon <jamesclv@us.ibm.com>, linux-kernel@vger.kernel.org,
	James.Bottomley@steeleye.com, torvalds@transmeta.com,
	alan@redhat.com, mingo@redhat.com
References: <200209122035.14678.jamesclv@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200209122035.14678.jamesclv@us.ibm.com>; from jamesclv@us.ibm.com on Thu, Sep 12, 2002 at 08:35:14PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2002 at 08:35:14PM -0700, James Cleverdon wrote:
 > Patch that allows IBM x440 boxes to on-line all CPUs and interrupt routing for 
 > x360s.   Fixed x360 ID bug.

Couple questions/comments.

- Is this the same summit code as is in 2.4-ac ?
  (Ie, the one that boots on non summit systems too)
- I believe the way forward here is to work with James Bottomley,
  who has a nice abstraction of the areas your patch touches for
  his Voyager sub-architecture.
  Linus has however been completley silent on the x86-subarch idea
  despite heavyweights like Alan and Ingo adding their support...
  If you go this route, James' base needs to go in first
  (converting just the in-kernel visws support). After which, adding
  support for Voyager, Summit and any other wacky x86esque hardware
  is a simple non-intrusive patch that touches subarch specific areas.
- Some of the code you've added looks along the lines of..

   if (numaq)
      foo();
   else if (summit)
      foo2();
   else 
      foo3();

  Would it be over-abstracting to have some form of APIC struct,
  defining pointers to various routines instead of lots of ugly
  if's/switches/fall-through's.

However, the last point may be completley pointless after adapting to
use what James B has come up with..

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
