Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269050AbTBXBPC>; Sun, 23 Feb 2003 20:15:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269051AbTBXBPC>; Sun, 23 Feb 2003 20:15:02 -0500
Received: from to-wiznet.redhat.com ([216.129.200.2]:33785 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S269050AbTBXBPB>; Sun, 23 Feb 2003 20:15:01 -0500
Date: Sun, 23 Feb 2003 20:25:12 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030223202512.B15376@redhat.com>
References: <200302232115.h1NLF9wo000201@81-2-122-30.bradfords.org.uk> <Pine.LNX.4.44.0302231343050.1534-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0302231343050.1534-100000@home.transmeta.com>; from torvalds@transmeta.com on Sun, Feb 23, 2003 at 01:45:16PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2003 at 01:45:16PM -0800, Linus Torvalds wrote:
> The x86 has that stupid "executablility is tied to a segment" thing, which
> means that you cannot make things executable on a page-per-page level.  
> It's a mistake, but it's one that _could_ be fixed in the architecture if
> it really mattered, the same way the WP bit got fixed in the i486.

I've been thinking about this recently, and it turns out that the whole 
point is moot with a fixed address vsyscall page: non-exec stacks are 
trivially circumvented by using the vsyscall page as a known starting 
point for the exploite.  All the other tricks of changing the starting 
stack offset and using randomized load addresses don't help at all, 
since the exploite can merely use the vsyscall page to perform various 
operations.  Personally, I'm still a fan of the shared library vsyscall 
trick, which would allow us to randomize its laod address and defeat 
this problem.

		-ben
