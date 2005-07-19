Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbVGSJ05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbVGSJ05 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 05:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbVGSJ05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 05:26:57 -0400
Received: from smtp2.rz.tu-harburg.de ([134.28.205.13]:5738 "EHLO
	smtp2.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id S261450AbVGSJ04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 05:26:56 -0400
Message-ID: <42DCC7AA.2020506@tu-harburg.de>
Date: Tue, 19 Jul 2005 11:28:10 +0200
From: Jan Blunck <j.blunck@tu-harburg.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ramfs: pretend dirent sizes
References: <42D72705.8010306@tu-harburg.de> <Pine.LNX.4.58.0507151151360.19183@g5.osdl.org> <20050716003952.GA30019@taniwha.stupidest.org>
In-Reply-To: <20050716003952.GA30019@taniwha.stupidest.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> 
> Why bother at all?
> 
> I don't see why zero sizes are a problem.  We've had them for year
> without complaints.

I'm using the i_size of directories in my patches. When reading from a 
union directory, I'm using the i_size to seek to the right offset in the 
union stack. Therefore I need values of dirent->d_off which are smaller 
than the i_size of the directory.
Altogether, it doesn't make sense to me to seek to an offset which is 
greater than the i_size and let the dirent read succeed.

Jan
