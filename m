Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030306AbWILR5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030306AbWILR5d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 13:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030307AbWILR5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 13:57:33 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:30909 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030306AbWILR5c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 13:57:32 -0400
Subject: [PATCH 0/7] Integrity Service and SLIM
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>
Cc: Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>, akpm@osdl.org
Content-Type: text/plain
Date: Tue, 12 Sep 2006 10:57:25 -0700
Message-Id: <1158083845.18137.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an updated request for comments on a proposed integrity 
service framework and dummy provider, along with SLIM, a low 
water-mark mandatory access control LSM module which utilizes the 
integrity services as additional input to the access control decisions.

In this version:
- We have further slimmed down the code by removing the secrecy checks
to focus on only the integrity model at this time.  The secrecy code had
several parts that were still in development and only had comments
indicating where they would eventually be and the policy was only using
one secrecy level.  Hopefully, this will remove an element of review
confusion
- The file revocation code was removed in favor of denying access when a
process has open shared file descriptors b/c file revocation has too
many corner cases.
- Fixed the situation where shared physical memory could cause a problem
if one thread was demoted.  Currently access is denied in the situation
we are working on a way to allow the access and demote all the threads.
- SLIM boot parameter
- INTEGRITY config parameter (which SLIM depends on) 

Where we are going:
- dummy integrity subsystem (included)
- integrity-only slim (included)
- secrecy slim 
- tcg-based integrity subsystem

Later we will be submitting EVM as a specific integrity service
provider under this proposed framework. By separating the submissions,
we hope that the integrity framework and its relationship to SLIM
(and potentially to selinux) will be clearer and easier to review.
Since this integrity provider is a dummy, it has no requirements for
TPM hardware, or for LSM stacking, again making the review simpler.

A corresponding userspace utility package is available at
http://www.research.ibm.com/gsal/tcpa

Patch 1/7 is a tiny patch to make mprotect available for revocation.

Patch 2/7 provides the integrity service API with dummy provider.

Patch 3-7 provide SLIM, and a more detailed description of
its changes, and points out its use of the integrity service.

These patches have no prerequisites for stacker or TPM related patches.


