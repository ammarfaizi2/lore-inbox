Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262802AbVCWR5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262802AbVCWR5e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 12:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262741AbVCWR5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 12:57:33 -0500
Received: from oracle.bridgewayconsulting.com.au ([203.56.14.38]:50882 "EHLO
	oracle.bridgewayconsulting.com.au") by vger.kernel.org with ESMTP
	id S262802AbVCWR5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 12:57:16 -0500
Date: Thu, 24 Mar 2005 01:57:07 +0800
From: Bernard Blackham <bernard@blackham.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Matt <matt@signalz.com>, linux-kernel@vger.kernel.org
Subject: Promise SX8 performance issues and CARM_MAX_Q
Message-ID: <20050323175707.GA10481@blackham.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101757822.4309.37.camel@schroder.signalz.com>
Organization: Dagobah Systems
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Playing with a recently acquired Promise SX8 card, we've found
similar performance results to Matt's post to lkml a few months back
at http://marc.theaimsgroup.com/?l=linux-kernel&m=110175890323356&w=2

It appears that the driver is only submitting one command at a time
per port, which is at least one cause of the slowdowns. By raising
CARM_MAX_Q from 1 to 3 in drivers/block/sx8.c (it was 3 in an
earlier pre-merge incarnation of carmel.c), we're getting very
notable speed improvements, with no side effects just yet.

Knowing very little about what this change has actually done, I've a
few questions: 

 - Should this be considered dangerous?
 - Why was it taken from 3 to 1?
 - Is CARM_MAX_Q a number defined (or limited) by the hardware?

Thanks in advance,

Bernard.

-- 
 Bernard Blackham <bernard at blackham dot com dot au>
