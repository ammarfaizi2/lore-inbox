Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262030AbVBJHEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbVBJHEz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 02:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbVBJHEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 02:04:55 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:24353 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262030AbVBJHEx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 02:04:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=WsI7cSXW2wLUMMXE4Yml0T3yPIPEXPIO+7KsVhy+rSpoeQRG0WbAxH89M9daloGA/pBfMTSwjZ1hcEaxb5b0hwiIHtuNeBFYHpEiKrOmZGk4O0hBwMf3KyXPjatw9xXWMgeLKqSNWLQufxj9xkmukaTgPTQrRM1JmR0qfAdYOr0=
Message-ID: <84144f02050209230413d87904@mail.gmail.com>
Date: Thu, 10 Feb 2005 09:04:49 +0200
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH 9/8] lib/sort: turn off self-test
Cc: Paul Jackson <pj@sgi.com>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       penberg@cs.helsinki.fi
In-Reply-To: <20050131170344.GP2891@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050131074400.GL2891@waste.org>
	 <20050131035742.1434944c.pj@sgi.com> <20050131170344.GP2891@waste.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2005 09:03:44 -0800, Matt Mackall <mpm@selenic.com> wrote:
> It's a nice self-contained unit test. It's here because I ran into a
> strange regparm-related bug when developing the code in userspace and
> I wanted to be sure that it was easy to diagnose in the field if a
> similar bug appeared in the future. I actually think that more code
> ought to have such tests, so long as they don't obscure the code in
> question.

Unit tests are nice and your approach is wrong. The test does not
belong in the implementation for two reasons: it hurts readability of
the actual code and the _commented out_ test will not be maintained
(dead code never is).

I don't know if the maintainers are interested in unit tests but a
better solution would be to  put your test in a separate file and make
sure it is always compiled and executed when CONFIG_UNIT_TEST is
enabled.

P.S. If the test fails, it probably should do BUG().

                               Pekka
