Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261575AbVETUde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbVETUde (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 16:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbVETUdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 16:33:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11197 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261575AbVETUdT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 16:33:19 -0400
Date: Fri, 20 May 2005 16:32:58 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Reiner Sailer <sailer@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       Emily Ratliff <emilyr@us.ibm.com>, Kent E Yoder <yoder1@us.ibm.com>,
       <kjhall@us.ibm.com>, <linux-kernel@vger.kernel.org>,
       Tom Lendacky <toml@us.ibm.com>
Subject: Re: [PATCH 1 of 4] ima: related TPM device driver interal kernel
 interface
In-Reply-To: <OF78B8C5CF.5EB676A1-ON85257007.005EA7BF-85257007.005FF5F9@us.ibm.com>
Message-ID: <Xine.LNX.4.44.0505201622410.21141-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 May 2005, Reiner Sailer wrote:

> > Why are you using LSM for this?
> > 
> > LSM should be used for comprehensive access control frameworks which 
> > significantly enhance or even replace existing Unix DAC security.
> 
> I see LSM is framework for security. IMA is an architecture that
> enforces access control in a different way than SELinux. IMA guarantees 
> that executable content is measured and accounted for before
> it is loaded and can access (and possibly corrupt) system resources.

LSM is an access control framework.  Your (few) LSM hooks always return
zero, and don't enforce access control at all.  You even have a separate
measurement hook for modules.

I suggest implementing all of your code via distinct measurement hooks, so 
measurement becomes a distinct and well defined security entity within the 
kernel.

LSM should not be used just because it has a few hooks in the right place
for your code.


- James
-- 
James Morris
<jmorris@redhat.com>




