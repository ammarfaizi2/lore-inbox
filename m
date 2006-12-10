Return-Path: <linux-kernel-owner+w=401wt.eu-S934293AbWLJVqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934293AbWLJVqp (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 16:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934378AbWLJVqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 16:46:45 -0500
Received: from gaz.sfgoth.com ([69.36.241.230]:58198 "EHLO gaz.sfgoth.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934293AbWLJVqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 16:46:44 -0500
Date: Sun, 10 Dec 2006 14:05:07 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Folkert van Heusden <folkert@vanheusden.com>
Cc: Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org
Subject: Re: strncpy optimalisation? (lib/string.c)
Message-ID: <20061210220507.GE47959@gaz.sfgoth.com>
References: <20061210205230.GB30197@vanheusden.com> <20061210210614.GD24090@1wt.eu> <20061210213518.GD30197@vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061210213518.GD30197@vanheusden.com>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Sun, 10 Dec 2006 14:05:08 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folkert van Heusden wrote:
> This one (tested in test-code seperate from kernel) works:

No it doesn't!

strncpy() guarantees that the entire destination buffer is written to.
If you call
	strncpy(dest, "foo", 10000)
then you MUST write to 10000 bytes of memory, or your strncpy() is buggy.

Your patches basically turn strncpy() into strlcpy().  Don't do that.
They're separate functions for a reason.

-Mitch
