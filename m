Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbTENOyR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 10:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbTENOyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 10:54:17 -0400
Received: from holomorphy.com ([66.224.33.161]:25540 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262427AbTENOyQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 10:54:16 -0400
Date: Wed, 14 May 2003 08:06:53 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave McCracken <dmccr@us.ibm.com>
Cc: Andrew Morton <akpm@digeo.com>, mika.penttila@kolumbus.fi,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Race between vmtruncate and mapped areas?
Message-ID: <20030514150653.GM8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave McCracken <dmccr@us.ibm.com>, Andrew Morton <akpm@digeo.com>,
	mika.penttila@kolumbus.fi, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
References: <154080000.1052858685@baldur.austin.ibm.com> <20030513181018.4cbff906.akpm@digeo.com> <18240000.1052924530@baldur.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18240000.1052924530@baldur.austin.ibm.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, May 13, 2003 18:10:18 -0700 Andrew Morton <akpm@digeo.com> wrote:
>> That's the one.  Process is sleeping on I/O in filemap_nopage(), wakes up
>> after the truncate has done its thing and the page gets instantiated in
>> pagetables.
>> But it's an anon page now.  So the application (which was racy anyway)
>> gets itself an anonymous page.

On Wed, May 14, 2003 at 10:02:10AM -0500, Dave McCracken wrote:
> Which the application thinks is still part of the file, and will expect its
> changes to be written back.  Granted, if the page fault occurred just after
> the truncate it'd get SIGBUS, so it's clearly not a robust assumption, but
> it will result in unexpected behavior.  Note that if the application later
> extends the file to include this page it could result in a corrupted file,
> since all the pages around it will be written properly.

Well, for this one I'd say the app loses; it was its own failure to
synchronize truncation vs. access, at least given that the kernel
doesn't oops.


-- wli
