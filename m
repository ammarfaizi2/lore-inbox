Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbUCAUbI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 15:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbUCAUaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 15:30:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:27627 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261423AbUCAU2s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 15:28:48 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16451.40189.997259.379123@neuro.alephnull.com>
Date: Mon, 1 Mar 2004 15:28:45 -0500
From: Rik Faith <faith@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: okir@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] Light-weight Auditing Framework
In-Reply-To: [Christoph Hellwig <hch@infradead.org>] Mon  1 Mar 2004 19:45:01 +0000
References: <16451.25789.72815.763592@neuro.alephnull.com>
	<20040301194501.A9080@infradead.org>
X-Key: 7EB57214; 958B 394D AD29 257E 553F  E7C7 9F67 4BE0 7EB5 7214
X-Url: http://www.redhat.com/
X-Mailer: VM 7.17; XEmacs 21.4; Linux 2.4.22-1.2163.nptl (neuro)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon  1 Mar 2004 19:45:01 +0000,
   Christoph Hellwig <hch@infradead.org> wrote:
> On Mon, Mar 01, 2004 at 11:28:45AM -0500, Rik Faith wrote:
> > This note describes a patch against 2.6.4-rc1-bk2 that provides a
> > low-overhead system-call auditing framework for Linux that is usable by
> > LSM components (e.g., SELinux).  Comments will be appreciated.
> 
> I haven't actually looked at the code, but why don't you use Olaf Kirch's
> auditing framework that's used in production and already has gotten the
> wizzbang certification you seem to be aiming at.

Different goals.  My goals are to provide a generic very-low-overhead
auditing framework that can be used as a service by more complex systems
(e.g., SELinux).  In contrast to Olaf's work, for example, my patch does
not have intimate knowledge of system call parameters and semantics.
This decreases the invasiveness of the patch and the work required for
long-term maintainability.

The price for this simplicity is that the "language" for describing
which system calls to audit is also very simple (and is, therefore, not
independently sufficient for certifications).  However, I assume that a
system undergoing certification will be using SELinux or another
security infrastructure that will make auditing _and_ other decisions
-- adding sophistication to the auditing infrastructure only duplicates
the work that the security module will provide.

> Whether we want syscall auditing in mainline is a completely different
> question..

I believe we need a light-weight, maintainable framework that is
versatile enough to be used for non-security purposes (e.g., debugging).
In general, my patch meets these requirements since it provides very
little that helps specifically with security (failure modes, loginuid,
and small helper functions).

