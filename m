Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264143AbTH1SSb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 14:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264144AbTH1SSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 14:18:31 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:43718 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S264143AbTH1SSa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 14:18:30 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16206.18283.555437.70679@gargle.gargle.HOWL>
Date: Thu, 28 Aug 2003 20:18:19 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: joe.korty@ccur.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bad definition of cpus_complement
In-Reply-To: <20030828155451.GA16156@tsunami.ccur.com>
References: <20030828155451.GA16156@tsunami.ccur.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Korty writes:
 > One of the definitions of cpus_complement is broke.  Also, cpus_complement is
 > the only cpus_* definition which operates in-place rather than in (dst,src)
 > form.  I will submit a patch to convert if there is interest.
 > 
 > Joe
 > 
 > --- include/asm-generic/cpumask_up.h.orig	2003-08-27 06:08:38.000000000 -0400
 > +++ include/asm-generic/cpumask_up.h	2003-08-28 11:45:09.000000000 -0400
 > @@ -28,7 +28,7 @@
 >  
 >  #define cpus_complement(map)						\
 >  	do {								\
 > -		cpus_coerce(map) = !cpus_coerce(map);			\
 > +		cpus_coerce(map) = ~cpus_coerce(map);			\
 >  	} while (0)

Broken how? The value range for a cpumask_t on UP is [0,1],
and ! respects that whereas ~ does not.
