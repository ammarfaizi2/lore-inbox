Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030245AbWGMRBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030245AbWGMRBh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 13:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030250AbWGMRBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 13:01:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60813 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030245AbWGMRBg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 13:01:36 -0400
Date: Thu, 13 Jul 2006 13:01:27 -0400
From: Dave Jones <davej@redhat.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: sparse warnings for variable length arrays
Message-ID: <20060713170127.GI12807@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	linux-kernel@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
References: <20060713085808.GA9566@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060713085808.GA9566@osiris.boeblingen.de.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2006 at 10:58:08AM +0200, Heiko Carstens wrote:
 > Hi all,
 > 
 > in include/asm-s390/bitops.h we have several typedefs:
 > 
 > typedef struct { long _[__BITOPS_WORDS(size)]; } addrtype;
 > 
 > sparse warns about these with "error: bad constant expression".
 > Is there any way to tell sparse to be quiet? __force doesn't seem to work.

In many cases, these turn up as on-stack variables.  It'd be
nice if sparse could figure out the maximum potential bound
and warn appropriately if they could reach $BIGSIZE.

For non-stack vars, it's less of an issue of course.

		Dave

-- 
http://www.codemonkey.org.uk
