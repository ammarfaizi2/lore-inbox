Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261796AbUJYMsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbUJYMsj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 08:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbUJYMsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 08:48:39 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:23775 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261789AbUJYMr1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 08:47:27 -0400
Date: Mon, 25 Oct 2004 14:47:18 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Timo Sirainen <tss@iki.fi>
cc: Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org
Subject: Re: readdir loses renamed files
In-Reply-To: <571A250A-2682-11D9-8AC3-000393CC2E90@iki.fi>
Message-ID: <Pine.LNX.4.53.0410251443370.19850@yvahk01.tjqt.qr>
References: <431547F9-2624-11D9-8AC3-000393CC2E90@iki.fi>
 <20041025082910.GA17089@taniwha.stupidest.org> <571A250A-2682-11D9-8AC3-000393CC2E90@iki.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>So if I lose a file, how many times should I scan the directory again
>to know if it's really gone? And is it really worth the extra overhead

Maybe the use of stat() will show whether a file really exists.

>The test program that I had showed that the next scan didn't
>necessarily return it either. The file was sometimes lost for as long
>as 5 scans.

Unrelated to this issue, I had a look into reiser3 for some other project of
mine. What I've found was that upon renaming() a file, the old entry is marked
invisble first, and then the new one is marked visible.
You would need to meet a lot of conditions to have a file lost (IMO):
- using reiser3
- reiserfs_rename() is suspended for as long as 5 scans
  (only happens either on SMP or UP+preempt)
- reiserfs_rename() hangs... somwhat, because while(i<5){while(readdir(...)){}}
  usually takes longer than a rename


Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
