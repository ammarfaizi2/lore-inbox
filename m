Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264161AbTEGSX4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 14:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264160AbTEGSX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 14:23:56 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:30227 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264161AbTEGSXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 14:23:54 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: top stack (l)users for 2.5.69
Date: 7 May 2003 18:36:06 GMT
Organization: Transmeta Corp
Message-ID: <1052332566.752437@palladium.transmeta.com>
References: <20030507132024.GB18177@wohnheim.fh-wedel.de> <Pine.LNX.4.53.0305070933450.11740@chaos>
X-Trace: palladium.transmeta.com 1052332566 4508 127.0.0.1 (7 May 2003 18:36:06 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 7 May 2003 18:36:06 GMT
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: torvalds@penguin.transmeta.com (Linus Torvalds)
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.53.0305070933450.11740@chaos>,
Richard B. Johnson <root@chaos.analogic.com> wrote:
>
>You know (I hope) that allocating stuff on the stack is not
>"bad". 

Allocating stuff on the stack _is_ bad if you allocate more than a few
hundred bytes. That's _especially_ true deep down in the call-sequence,
ie in device drivers, low-level filesystems etc.

The kernel stack is a very limited resource, with no protection from
overflow. Being lazy and using automatic variables is a BAD BAD thing,
even if it's syntactically easy and generates good code.

			Linus
