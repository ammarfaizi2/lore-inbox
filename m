Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262913AbTKTWcD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 17:32:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263007AbTKTWcC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 17:32:02 -0500
Received: from colossus.systems.pipex.net ([62.241.160.73]:42704 "EHLO
	colossus.systems.pipex.net") by vger.kernel.org with ESMTP
	id S262913AbTKTWcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 17:32:01 -0500
From: Shaheed <srhaque@iee.org>
To: rob@landley.net, linux-kernel@vger.kernel.org
Subject: Re: Patrick's Test9 suspend code.
Date: Thu, 20 Nov 2003 22:33:09 +0000
User-Agent: KMail/1.5.93
References: <200311201726.48097.srhaque@iee.org> <200311201339.45461.rob@landley.net>
In-Reply-To: <200311201339.45461.rob@landley.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200311202233.09609.srhaque@iee.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 20 November 2003 19:39, Rob Landley wrote:
> When resuming from a writeable filesystem, the filesystem has to match the
> contents of suspended memory.  If you've TOUCHED the filesystem since
> suspending, the resume is going to shred it, cross-link the heck out of it,
> and generally be evil.  (There are open filehandles saved in there, page
> table entries to maped stuff...  Just don't go there.)

Understood. But by definition, there must be at least one page of data on the 
filesystem whose location we know in order to do the resume. Why can't we 
simply use one extra page to store this data?

At least in my reading of suspend/main.c we create a directory of pages which 
itself is stored on disk. Since we do that, can't we simply use an extra page 
for this signature?

