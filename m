Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268853AbUHLWtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268853AbUHLWtd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 18:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268850AbUHLWrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 18:47:33 -0400
Received: from mail.tpgi.com.au ([203.12.160.103]:19388 "EHLO mail.tpgi.com.au")
	by vger.kernel.org with ESMTP id S268853AbUHLWqG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 18:46:06 -0400
Subject: Re: is_head_of_free_region slowing down swsusp
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040812222348.GA10791@elf.ucw.cz>
References: <20040812222348.GA10791@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1092350569.24776.22.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 13 Aug 2004 08:42:49 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel.

On Fri, 2004-08-13 at 08:23, Pavel Machek wrote:
> is_head_of_free_region with count_and_copy_zone results results in
> pretty nasty O(number_of_free_regions^2) behaviour, and some users see
> cpu spending 40 seconds there :-(.
> 
> Actually count_and_copy_zone would probably be happy with
> "is_free_page()".

Take a look at my implementation. I do a one-time pass through the slow
path, building a bitmap of free pages. is_head_of_free_region is then
simply a O(1) loop through the bitmap.

Nigel
-- 
Nigel Cunningham
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. But true tolerance can cope with others
being intolerant.

