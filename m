Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965010AbVIKSW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965010AbVIKSW2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 14:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965013AbVIKSW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 14:22:28 -0400
Received: from smtpout.mac.com ([17.250.248.46]:23011 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S965010AbVIKSW2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 14:22:28 -0400
In-Reply-To: <20050911104437.6445ff20.donate@madrone.org>
References: <20050911103757.7cc1f50f.rdunlap@xenotime.net> <20050911104437.6445ff20.donate@madrone.org>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8244F3CF-9EF7-44BB-B3DA-B46A1FF39E1C@mac.com>
Cc: LKML Kernel <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC] [PATCH] make add_taint() inline
Date: Sun, 11 Sep 2005 14:22:08 -0400
To: "Randy.Dunlap" <rddunlap@osdl.org>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 11, 2005, at 13:44:37, donate wrote:
> From: Randy Dunlap <rdunlap@xenotime.net>
>
> add_taint() is a trivial function.
> No need to call it out-of-line, just make it inline and
> remove its export.

Actually, in this case it might be better to leave add_taint
exported, add and export a new function get_taint(), and then
remove all export of the variable "tainted".  I've actually
seen one case where some module removed taint bits.  I don't
remember where or why, but it seemed really bad at the time,
and still does.  Also, does the tainted variable need any
kind of locking?  What happens if two CPUs try to taint the
kernel simultaneously?

Cheers,
Kyle Moffett

--
Premature optimization is the root of all evil in programming
   -- C.A.R. Hoare



