Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279201AbRKFNcE>; Tue, 6 Nov 2001 08:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279264AbRKFNbz>; Tue, 6 Nov 2001 08:31:55 -0500
Received: from ns.ithnet.com ([217.64.64.10]:9735 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S279201AbRKFNbo>;
	Tue, 6 Nov 2001 08:31:44 -0500
Date: Tue, 6 Nov 2001 14:31:08 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: torvalds@transmeta.com, andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: out_of_memory() heuristic broken for different mem configurations
Message-Id: <20011106143108.6ef304d5.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.21.0111060928010.9782-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0111060928010.9782-100000@freak.distro.conectiva>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Nov 2001 09:40:51 -0200 (BRST) Marcelo Tosatti
<marcelo@conectiva.com.br> wrote:

> Well, yes, its seems to be just a wrong magic number for this
> setup/workload.

Well, first time I read the code I thought that this will happen. Simply think
of a _slow_ system with _lots_ of mem. Chances are high you cannot match the
seconds-rule. 

> Linus, any suggestion to "fix" that ? 

How about this really stupid idea: oom means allocs fail, so why not simply
count failed 0-order allocs, if one succeeds, reset counter. If a page is freed
reset counter. If counter reaches <new magic number> then you're oom. No timing
involved, which means you can have as much mem or as slow host as you like. It
isn't even really interesting, if you have swap or not, because a failed
0-order alloc tells you whatever mem you have, there is surely not much left.
I'd try about 100 as magic number.

> /proc tunable (eeek) ? 

NoNoNo, please don't do that!

Regards,
Stephan

