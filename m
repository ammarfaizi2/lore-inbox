Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270274AbRHMQPn>; Mon, 13 Aug 2001 12:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270273AbRHMQPd>; Mon, 13 Aug 2001 12:15:33 -0400
Received: from ns.suse.de ([213.95.15.193]:44042 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S269223AbRHMQPP>;
	Mon, 13 Aug 2001 12:15:15 -0400
To: Manfred Bartz <mbartz@optushome.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: connect() does not return ETIMEDOUT
In-Reply-To: <20010813140049.28744.qmail@optushome.com.au.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 13 Aug 2001 18:15:06 +0200
In-Reply-To: Manfred Bartz's message of "13 Aug 2001 16:03:57 +0200"
Message-ID: <ouplmkogcmt.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Bartz <mbartz@optushome.com.au> writes:

> When a TCP client opens multiple connections beyond the server's
> backlog capacity, the call to connect() returns a value of zero 
> (success) after 9 seconds. Toggling SYN-cookies makes no difference.

It works correct here (2.4.7-something)

# ipchains -A input -j DENY -p tcp --dport 10000
# strace -e connect telnet localhost 10000
...
connect(3, {sin_family=AF_INET, sin_port=htons(10000), sin_addr=inet_addr("127.0.0.1")}}, 16) = -1 ETIMEDOUT (Connection timed out)

If you think something is wrong you should probably send a strace that
shows it.

-Andi
