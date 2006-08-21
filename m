Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932525AbWHUAtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932525AbWHUAtu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 20:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbWHUAtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 20:49:50 -0400
Received: from mother.openwall.net ([195.42.179.200]:46800 "HELO
	mother.openwall.net") by vger.kernel.org with SMTP id S932431AbWHUAtt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 20:49:49 -0400
Date: Mon, 21 Aug 2006 04:45:37 +0400
From: Solar Designer <solar@openwall.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Willy Tarreau <wtarreau@hera.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] set*uid() must not fail-and-return on OOM/rlimits
Message-ID: <20060821004537.GA22672@openwall.com>
References: <20060820003840.GA17249@openwall.com> <1156097640.4051.24.camel@localhost.localdomain> <20060820221208.GA21754@openwall.com> <1156114275.4051.71.camel@localhost.localdomain> <44E8FD07.1010104@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E8FD07.1010104@bigpond.net.au>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2006 at 10:23:35AM +1000, Peter Williams wrote:
> How about going ahead with the uid change (if the current user is root) 
> BUT still return -EAGAIN.  That way programs that ignore the return 
> value will at least no longer have root privileges.

That's bad.  It will break legitimate programs that assume that the
UID switch has failed if set*uid() indicates so with its return value.

Alexander
