Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751037AbWAVT0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbWAVT0t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 14:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWAVT0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 14:26:49 -0500
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:30478 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S1751037AbWAVT0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 14:26:48 -0500
Message-ID: <43D3DC75.30703@superbug.co.uk>
Date: Sun, 22 Jan 2006 19:26:45 +0000
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Mail/News 1.5 (X11/20060112)
MIME-Version: 1.0
To: John Richard Moser <nigelenki@comcast.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: soft update vs journaling?
References: <43D3295E.8040702@comcast.net>
In-Reply-To: <43D3295E.8040702@comcast.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Richard Moser wrote:
> 
> Unfortunately, journaling uses a chunk of space.  Imagine a journal on a
> USB flash stick of 128M; a typical ReiserFS journal is 32 megabytes!
> Sure it could be done in 8 or 4 or so; or (in one of my file system
> designs) a static 16KiB block could reference dynamicly allocated
> journal space, allowing the system to sacrifice performance and shrink
> the journal when more space is needed.  Either way, slow media like
> floppies will suffer, HARD; and flash devices will see a lot of
> write/erase all over the journal area, causing wear on that spot.
> 

My understanding is that if one designed a power supply with enough 
headroom, one could remove the power and still have time to write dirty 
sectors to the USB flash stick. Would this not remove the need for a 
journaling fs on a flash stick. This would remove the "wear on that 
spot" problem. Actually USB flash sticks are a bit clever, in that they 
add an extra layer of translation to the write. I.e. If you write to the 
same sector again and again, the USB flash stick will actually write it 
to a different area of the memory each time. This is specifically done 
to save the "wear on that spot" problem.

This "flush on power fail" approach is not so easy with a HD because it 
uses more power and takes longer to flush.

James

