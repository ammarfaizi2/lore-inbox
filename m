Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbVLPRfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbVLPRfq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 12:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbVLPRfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 12:35:45 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:41110 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751312AbVLPRfp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 12:35:45 -0500
Subject: Re: [ckrm-tech] Re: [RFC][patch 00/21] PID Virtualization:
	Overview and Patches
From: Dave Hansen <haveblue@us.ibm.com>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: Matt Helsley <matthltc@us.ibm.com>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>, vserver@list.linux-vserver.org,
       Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       pagg@oss.sgi.com
In-Reply-To: <E1En6H2-0005ok-00@w-gerrit.beaverton.ibm.com>
References: <E1En6H2-0005ok-00@w-gerrit.beaverton.ibm.com>
Content-Type: text/plain
Date: Fri, 16 Dec 2005 09:35:19 -0800
Message-Id: <1134754519.19403.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-15 at 19:28 -0800, Gerrit Huizenga wrote:
> In the pid virtualization, I would think that tasks can move between
> containers as well,

I don't think tasks can not be permitted to move between containers.  As
a simple exercise, imagine that you have two processes with the same
pid, one in container A and one in container B.  You wish to have them
both run in container A.  They can't both have the same pid.  What do
you do?

I've been talking a lot lately about how important filesystem isolation
between containers is to implement containers properly.  Isolating the
filesystem namespaces makes it much easier to do things like fs-based
shared memory during a checkpoint/resume.  If we want to allow tasks to
move around, we'll have to throw out this entire concept.  That means
that a _lot_ of things get a notch closer to the too-costly-to-implement
category.

-- Dave

