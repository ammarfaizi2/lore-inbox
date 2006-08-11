Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbWHKApq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbWHKApq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 20:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbWHKApp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 20:45:45 -0400
Received: from helium.samage.net ([83.149.67.129]:24002 "EHLO
	helium.samage.net") by vger.kernel.org with ESMTP id S932388AbWHKApo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 20:45:44 -0400
Message-ID: <40710.81.207.0.53.1155257131.squirrel@81.207.0.53>
In-Reply-To: <1155228640.5696.55.camel@twins>
References: <1155216769.5696.23.camel@twins> 
    <20060810140240.GA28989@2ka.mipt.ru> <1155221191.5696.43.camel@twins> 
    <20060810162229.GA27364@2ka.mipt.ru> <1155228640.5696.55.camel@twins>
Date: Fri, 11 Aug 2006 02:45:31 +0200 (CEST)
Subject: Re: [RFC][PATCH] VM deadlock prevention core -v3
From: "Indan Zupancic" <indan@nul.nu>
To: "Peter Zijlstra" <a.p.zijlstra@chello.nl>
Cc: "Evgeniy Polyakov" <johnpol@2ka.mipt.ru>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "linux-mm" <linux-mm@kvack.org>, "netdev" <netdev@vger.kernel.org>,
       "Daniel Phillips" <phillips@google.com>,
       "David Miller" <davem@davemloft.net>, "Thomas Graf" <tgraf@suug.ch>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, August 10, 2006 18:50, Peter Zijlstra said:
> You are right if the reserve wasn't device bound - which I will abandon
> because you are right that with multi-path routing, bridge device and
> other advanced goodies this scheme is broken in that there is no
> unambiguous mapping from sockets to devices.

The natural thing seems to make reserves socket bound, but that has
overhead too and the simplicity of a global reserve is very tempting.

What about adding a flag to sk_set_memalloc() which says if memalloc is on
or off on the socket? (Or add sk_unset_memalloc). That way it's possible
to switch it off again, which doesn't seem like that a bad idea, because
then it can be turned on only when the socket can be used to reduce total
memory usage. Also if it is turned off again when no more memory can be
freed by using this socket, it will solve the starvation problem as a
starved socket now has a new chance to do its thing.

Greetings,

Indan


