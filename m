Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbWAIQcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWAIQcg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 11:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWAIQcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 11:32:35 -0500
Received: from smtp.osdl.org ([65.172.181.4]:56753 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751111AbWAIQce (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 11:32:34 -0500
Date: Mon, 9 Jan 2006 08:32:20 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Jones <davej@redhat.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: vm related lock up in 2.6.15
In-Reply-To: <20060109154957.GA9766@redhat.com>
Message-ID: <Pine.LNX.4.64.0601090830040.3169@g5.osdl.org>
References: <20060109021230.GA23750@redhat.com> <20060109154957.GA9766@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 9 Jan 2006, Dave Jones wrote:
>  
> Linus,
>  Turns out this was your BUG_ON(page_count(p) <= page_mapcount(p));
> addition to putpage_test_zero, which I added a few days ago and promptly
> forgot about.
> 
> Triggering this isn't too difficult it seems :-/

Well, as I warned in the message that had the patch, the test _is_ racy. 
The reads of the page counts have no serialization, so if another process 
is changing them, I don't guarantee that the test is correct.

IOW, it was meant as a special case debug test for one particular problem 
where I hoped it would give more information, rather than a real patch.

		Linus
