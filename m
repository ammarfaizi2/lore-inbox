Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289234AbSBNAg6>; Wed, 13 Feb 2002 19:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289236AbSBNAgt>; Wed, 13 Feb 2002 19:36:49 -0500
Received: from suntan.tandem.com ([192.216.221.8]:55495 "EHLO
	suntan.tandem.com") by vger.kernel.org with ESMTP
	id <S289234AbSBNAgp>; Wed, 13 Feb 2002 19:36:45 -0500
Message-ID: <3C6B0131.F096F020@compaq.com>
Date: Wed, 13 Feb 2002 16:13:37 -0800
From: "Brian J. Watson" <Brian.J.Watson@compaq.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org, hch@caldera.de
Subject: Re: [PATCH] 2.4.18-pre9, trylock for read/write semaphores
In-Reply-To: <26130.1013588383@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> I think the following would be more elegant:
> 
> [snip]

I agree.


> I'm also not sure that the cast has any effect in the following excerpt from
> the above:
> 
>         old = (volatile signed long)sem->count;
> 

You're right. I looked at the generated assembly, and the volatile cast
makes no difference.


> What you may actually want is:
> [snip]

Although you're right that a volatile pointer is the proper way to do
it, it turns out that a volatile declaration isn't necessary at all. The
cmpxchg() function is a memory barrier that forces the count to be
refetched the next time through the loop.


> Using this inline assembly has three advantages over mixing lots of C into it:
> [snip]

I'm not much of an assembly programmer, so implementing it this way
never crossed my mind. It looks much more efficient than the code
generated from the C version. A drawback is that it is not as easy to
port to other architectures, particularly those that already have a
cmpxchg() function.

It's up to you whether you prefer C or assembly. Let me know, and I'll
test that version and regenerate the patch.

Brian
