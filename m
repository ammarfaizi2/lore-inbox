Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964888AbWEJK3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbWEJK3A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 06:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbWEJK3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 06:29:00 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33441 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964888AbWEJK27
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 06:28:59 -0400
Subject: Re: [PATCH -mm] ixj gcc 4.1 warning fix
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Walker <dwalker@mvista.com>
Cc: akpm@osdl.org, eokerson@quicknet.net, linux-kernel@vger.kernel.org
In-Reply-To: <200605100255.k4A2tx1b031712@dwalker1.mvista.com>
References: <200605100255.k4A2tx1b031712@dwalker1.mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 10 May 2006 11:40:36 +0100
Message-Id: <1147257636.17886.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-05-09 at 19:55 -0700, Daniel Walker wrote:
> Fixes the following warnings,
> 
> drivers/telephony/ixj.c: In function 'ixj_pstn_state':
> drivers/telephony/ixj.c:4847: warning: 'bytes.high' may be used uninitialized in this function
> drivers/telephony/ixj.c: In function 'ixj_write_frame':
> drivers/telephony/ixj.c:3448: warning: 'blankword.high' may be used uninitialized in this function
> drivers/telephony/ixj.c:3448: warning: 'blankword.low' may be used uninitialized in this function
> 
> Signed-Off-By: Daniel Walker <dwalker@mvista.com>

No this is not a good idea either. The missing default case stuff is as
far as I can see from inspection not neccessary. If anything you want to
add

	default:
		BUG();

since those are impossible cases.

The unusued variables also appear to be just compiler confusion.

