Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964866AbWAIQfQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbWAIQfQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 11:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbWAIQfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 11:35:16 -0500
Received: from mx1.redhat.com ([66.187.233.31]:60854 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964866AbWAIQfO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 11:35:14 -0500
Date: Mon, 9 Jan 2006 11:35:07 -0500
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: vm related lock up in 2.6.15
Message-ID: <20060109163507.GA20205@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060109021230.GA23750@redhat.com> <20060109154957.GA9766@redhat.com> <Pine.LNX.4.64.0601090830040.3169@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601090830040.3169@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 08:32:20AM -0800, Linus Torvalds wrote:
 
 > >  Turns out this was your BUG_ON(page_count(p) <= page_mapcount(p));
 > > addition to putpage_test_zero, which I added a few days ago and promptly
 > > forgot about.
 > > 
 > > Triggering this isn't too difficult it seems :-/
 > 
 > Well, as I warned in the message that had the patch, the test _is_ racy. 
 > The reads of the page counts have no serialization, so if another process 
 > is changing them, I don't guarantee that the test is correct.
 > 
 > IOW, it was meant as a special case debug test for one particular problem 
 > where I hoped it would give more information, rather than a real patch.

ok, that explains. I'll go back to chasing the real cause of the corruption
I was seeing :-/

		Dave

