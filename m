Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268842AbUHLWYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268842AbUHLWYp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 18:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268840AbUHLWYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 18:24:44 -0400
Received: from gprs214-76.eurotel.cz ([160.218.214.76]:63110 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S268842AbUHLWYP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 18:24:15 -0400
Date: Fri, 13 Aug 2004 00:23:48 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: is_head_of_free_region slowing down swsusp
Message-ID: <20040812222348.GA10791@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

is_head_of_free_region with count_and_copy_zone results results in
pretty nasty O(number_of_free_regions^2) behaviour, and some users see
cpu spending 40 seconds there :-(.

Actually count_and_copy_zone would probably be happy with
"is_free_page()".

I asked Lukas (who is seeing this problem) to kill locking from
is_head_of_free_region [we are running singlethreaded at this point,
so it should be ok]. Do you have any other ideas?
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
