Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135221AbRAYSCV>; Thu, 25 Jan 2001 13:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135545AbRAYSCL>; Thu, 25 Jan 2001 13:02:11 -0500
Received: from pcep-jamie.cern.ch ([137.138.38.126]:12809 "EHLO
	pcep-jamie.cern.ch") by vger.kernel.org with ESMTP
	id <S135532AbRAYSCC>; Thu, 25 Jan 2001 13:02:02 -0500
Date: Thu, 25 Jan 2001 18:58:16 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
        Rick Jones <raj@cup.hp.com>, Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
Message-ID: <20010125185816.B5109@pcep-jamie.cern.ch>
In-Reply-To: <Pine.LNX.4.30.0101171231420.16292-100000@twinlark.arctic.org> <Pine.LNX.4.30.0101181345020.823-100000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0101181345020.823-100000@elte.hu>; from mingo@elte.hu on Thu, Jan 18, 2001 at 01:56:55PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> this is what TUX uses. When a eg. static HTTP request arrives it sends
> reply headers shortly after having checked file permissions and stuff (but
> the file is not yet sent), with MSG_MORE set. Then it sends the file, and
> sendfile() keeps MSG_MORE set right until the end of the request, when it
> clears it for the last fragment so the last partial packet gets flushed to
> the network. In fact there is one more optimization here, if the request
> is not keepalive then TUX still kees MSG_MORE set, and closes the socket -
> which will implicitly flush the output queue anyway and send any partial
> packet, but will also have the FIN packet merged with the last outgoing
> packet.

... is it possible to do control the MSG_MORE flag for sendfile's final
packet from user space, or do you have to use TCP_CORK to get the control?

-- Jamie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
