Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263160AbVGAAnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263160AbVGAAnL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 20:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263163AbVGAAnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 20:43:11 -0400
Received: from [62.206.217.67] ([62.206.217.67]:64188 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S263160AbVGAAnH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 20:43:07 -0400
Message-ID: <42C4919A.5000009@trash.net>
Date: Fri, 01 Jul 2005 02:43:06 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.8) Gecko/20050514 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Patrick Jenkins <patjenk@wam.umd.edu>
CC: linux-kernel@vger.kernel.org, Maillist netdev <netdev@oss.sgi.com>
Subject: Re: [PATCH] multipath routing algorithm, better patch
References: <Pine.GSO.4.61.0506302014160.7400@rac1.wam.umd.edu>
In-Reply-To: <Pine.GSO.4.61.0506302014160.7400@rac1.wam.umd.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Jenkins wrote:
> Hi,
> 
> The last patch wont work, this should.
> 
> This patch assigns the multipath routing algorithm into the fib_info
> struct's fib_mp_alg variable. Previously, the algorithm was always set to
> IP_MP_ALG_NONE which was incorrect. This patch corrects the problem by
> assigning the correct value when a fib_info is initialized.
> 
> This patch was tested against kernel 2.6.12.1 for all multipath routing
> algorithms (none, round robin, interface round robin, random, weighted
> random).

Multiple algorithms can be compiled in at once, so this patch is wrong.
mp_alg is supplied by userspace:

        if (rta->rta_mp_alg) {
                mp_alg = *rta->rta_mp_alg;

                if (mp_alg < IP_MP_ALG_NONE ||
                    mp_alg > IP_MP_ALG_MAX)
                        goto err_inval;
        }

If it isn't set correctly its an iproute problem. Did you actually
experience any problems?

Regards
Patrick
