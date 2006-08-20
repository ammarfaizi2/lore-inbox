Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751701AbWHTIeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbWHTIeu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 04:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751680AbWHTIeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 04:34:50 -0400
Received: from mx1.suse.de ([195.135.220.2]:41945 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751311AbWHTIet (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 04:34:49 -0400
From: Andi Kleen <ak@suse.de>
To: Solar Designer <solar@openwall.com>
Subject: Re: [PATCH] getsockopt() early argument sanity checking
Date: Sun, 20 Aug 2006 10:34:43 +0200
User-Agent: KMail/1.9.3
Cc: Willy Tarreau <wtarreau@hera.kernel.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
References: <20060819230532.GA16442@openwall.com>
In-Reply-To: <20060819230532.GA16442@openwall.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608201034.43588.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 August 2006 01:05, Solar Designer wrote:
> I propose the attached patch (extracted from 2.4.33-ow1) for inclusion
> into 2.4.34-pre.
> 
> (2.6 kernels could benefit from the same change, too, but at the moment
> I am dealing with proper submission of generic changes like this that
> are a part of 2.4.33-ow1.)

In general I don't think it makes sense to submit stuff for 2.4 
that isn't in 2.6.

> 
> The patch makes getsockopt(2) sanity-check the value pointed to by
> the optlen argument early on.  This is a security hardening measure
> intended to prevent exploitation of certain potential vulnerabilities in
> socket type specific getsockopt() code on UP systems.

It's not only insufficient on SMP, but even on UP where a thread
can sleep in get_user and another one can run in this time.

Doing a check that is inherently racy everywhere doesn't seem like
a security improvement to me. If there is really a length checking bug somewhere 
it needs to be fixed in a race-free way. If not then there is no need
for a change.

-Andi
