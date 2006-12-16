Return-Path: <linux-kernel-owner+w=401wt.eu-S1750761AbWLPKbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWLPKbx (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 05:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753584AbWLPKbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 05:31:53 -0500
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:53523 "EHLO
	mtagate3.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbWLPKbw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 05:31:52 -0500
Subject: Re: [S390] Fix reboot hang on LPARs
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, holzheu@de.ibm.com
In-Reply-To: <20061215211558.GA8101@osiris.ibm.com>
References: <20061215162218.GF4920@skybase>
	 <20061215211558.GA8101@osiris.ibm.com>
Content-Type: text/plain
Organization: IBM Corporation
Date: Sat, 16 Dec 2006 11:31:39 +0100
Message-Id: <1166265099.26640.13.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-15 at 22:15 +0100, Heiko Carstens wrote:
> This is broken. pgm_check_occured must be volatile, otherwise the -EIO path
> in stsch_reset might get optimized away.

That is true, good spotting. Only adding a "volatile" in not the right
solution. The point here is that the stsch inline assembly can write to
pgm_check_occured. We better tell the compiler, e.g. by adding a
"memory" clobber or better a "+m" (pgm_check_occured). For the later
we'd have to copy the inline assembly though.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


