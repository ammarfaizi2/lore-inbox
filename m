Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263400AbTC2JNT>; Sat, 29 Mar 2003 04:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263401AbTC2JNT>; Sat, 29 Mar 2003 04:13:19 -0500
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:12041 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id <S263400AbTC2JNS>; Sat, 29 Mar 2003 04:13:18 -0500
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>, jgarzik@pobox.com,
       aeb@cwi.nl
Subject: Re: NICs trading places ?
References: <20030328221037.GB25846@suse.de>
	<20030328224843.GA11980@win.tue.nl>
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 29 Mar 2003 10:20:39 +0100
Message-ID: <wrpisu21qc8.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <20030328224843.GA11980@win.tue.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andries" == Andries Brouwer <aebr@win.tue.nl> writes:

Andries> I am not quite sure, apologies in case I misremember, but
Andries> maybe the most recent breakage was caused by Marc Zyngier
Andries> with EISA bus changes.

Well, it is not exactly related to EISA bus, although part of the same
patch.

The real problem is that some old drivers are still initialized from
Space.c (they simply do not know about init_etherdev (NULL, ...),
after all these years). So yes, I broke 3c509 in this respect. I also
broke znet if that matters. Oh, and the EISA part of depca in the AC
tree.

So the questions are :
- Should Space.c die ? I think so.
- Should 2.5 be the place and time to kill it ? I also think so.

I know it is a pain for most of us to have interfaces being
renumbered. But relying on something as static as Space.c is the wrong
answer IMHO.

        M.
-- 
Places change, faces change. Life is so very strange.
