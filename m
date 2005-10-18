Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbVJRBDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbVJRBDY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 21:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbVJRBDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 21:03:23 -0400
Received: from nproxy.gmail.com ([64.233.182.195]:41640 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751233AbVJRBDX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 21:03:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=i/YuKP8XNDTGdYgMun7cMjv+PqJAIq4CC8qBJobflIgrgvxIQTTfGE149UqIlGfXK4ThyrpnF+jO6SLm+O4U7v+O5Xd/8hh2d2bdGqC1MA+AZWL9ICzGXauX3eLgoo/XzkThIlwxYpJ3nXgn9vuIt8kLdU6v5JDO6+JjcIA3Z9Y=
Message-ID: <2cd57c900510171803i7b6ccfffwffb378b535f10558@mail.gmail.com>
Date: Tue, 18 Oct 2005 09:03:20 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Ben Dooks <ben@fluff.org.uk>
Subject: Re: [PATCH] mark __init code noinline to stop erroneous inclusions
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051017213737.GA18686@home.fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051017213737.GA18686@home.fluff.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/05, Ben Dooks <ben@fluff.org.uk> wrote:
> Make __init also have the noinline attribute attached
> to it, to stop code marked as __init being included
> into non __init code. This not only wastes space, but
> also makes it impossible to track down any calls from
> non-init code as differing compilers and optimisations
> make differing decisions on what to inline.

I think this is overkill. __init code could be inlined into __init
code.  Instead we should make sure to not to call __init code from
non-init code `directly'.

It is a gcc bug. Gcc really should respects __attribute__
((__section__ (".init.text"))), and not inline the code in that
section.
--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
