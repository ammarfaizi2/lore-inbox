Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbVHLD3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbVHLD3Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 23:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbVHLD3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 23:29:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27116 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751149AbVHLD3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 23:29:24 -0400
Date: Thu, 11 Aug 2005 23:28:08 -0400
From: Dave Jones <davej@redhat.com>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: David Mosberger <davidm@napali.hpl.hp.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: suspect code in drivers/char/agp/generic.c
Message-ID: <20050812032808.GE9529@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jeremy Fitzhardinge <jeremy@goop.org>,
	David Mosberger <davidm@napali.hpl.hp.com>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <42FBF62F.5090205@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42FBF62F.5090205@goop.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2005 at 06:06:55PM -0700, Jeremy Fitzhardinge wrote:
 > I was just looking at agp_copy_info(), which contains this code:
 > 
 >    318 	if (bridge->mode & AGPSTAT_MODE_3_0)
 >    319 		info->mode = bridge->mode & ~AGP3_RESERVED_MASK;
 >    320 	else
 >    321 		info->mode = bridge->mode & ~AGP2_RESERVED_MASK;
 >    322 	info->mode = bridge->mode;
 > 
 > This looks wrong to me, since line 322 overrides the previous 4 lines'
 > work...
 > 
 > I have no idea whether this is actually causing a problem, but I'd
 > thought I'd call attention to it.
 
Ugh, that crept in when the multiple gart support got added.
Line 322 shouldn't be there. I'll nuke it in agpgart.git

Whilst its clearly wrong, I'd like the corrected version to take a quick
spin in -mm before we add this to 2.6.13, just in case.

		Dave

