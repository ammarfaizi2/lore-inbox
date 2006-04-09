Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751382AbWDIGHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbWDIGHR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 02:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWDIGHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 02:07:17 -0400
Received: from mx1.suse.de ([195.135.220.2]:39611 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751382AbWDIGHP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 02:07:15 -0400
From: Andi Kleen <ak@suse.de>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: [RFC][PATCH 1/5] uts namespaces: Implement utsname namespaces
Date: Sun, 9 Apr 2006 08:00:57 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060407095132.455784000@sergelap> <p73hd549o5u.fsf@bragg.suse.de> <20060408202840.GB26403@sergelap.austin.ibm.com>
In-Reply-To: <20060408202840.GB26403@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604090800.57814.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 08 April 2006 22:28, Serge E. Hallyn wrote:

> This is something we've been discussing - whether to use a single
> "container" structure pointing to all the namespaces, or put everything
> into the task_struct.  Using container structs means more cache misses
> and refcounting issues, but keeps task_struct smaller as you point out.

The more cache misses argument seems bogus to me. If you consider 
the case of a lot of processes with lots of shared name spaces
the overall foot print should be in fact considerable less.


> The consensus so far has been to start putting things into task_struct
> and move if needed.  At least the performance numbers show that so far
> there is no impact.

Performance is not the only consider consideration here. Overall 
memory consumption is important too.

Sure for a single namespace like utsname it won't make much difference,
but it likely will if you have 10-20 of these things.

> 
> iirc container patches have been sent before.  Should those be resent,
> then, and perhaps this patchset rebased on those?

I think so.

-Andi
