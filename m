Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030304AbWEKQLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030304AbWEKQLG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 12:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030305AbWEKQLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 12:11:06 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:22184 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030304AbWEKQLE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 12:11:04 -0400
Subject: Re: [RFC] Hugetlb demotion for x86
From: Adam Litke <agl@us.ibm.com>
To: Christoph Lameter <christoph@engr.sgi.com>
Cc: linux-mm@kvack.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0605101633140.7639@schroedinger.engr.sgi.com>
References: <1147287400.24029.81.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0605101633140.7639@schroedinger.engr.sgi.com>
Content-Type: text/plain
Organization: IBM
Date: Thu, 11 May 2006 11:10:58 -0500
Message-Id: <1147363859.24029.134.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-10 at 16:42 -0700, Christoph Lameter wrote:
> Seems that the code is not modifying x86 code but all code. 

Right.  It's definitely broken in that regard.  I sent it out in this
condition so the patch was small, easy to review, and my approach would
be easy to see.

> An app should be getting an out of memory error and not a SIGBUS when 
> running out of memory.
> 
> I thought we fixed the SIGBUS problems and were now reporting out of 
> memory? If there still is an issue then we better fix out of memory 
> handling. Provide a way for the app to trap OOM conditions?

Yes, the SIGBUS issues are "fixed".  Now the application is killed
directly via VM_FAULT_OOM so it is not possible to handle the fault from
userspace.  For my libhugetlbfs-based fallback approach, I needed to
patch the kernel so that SIGBUS was delivered to the process like in the
days of old.

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

