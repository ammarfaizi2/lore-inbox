Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263770AbREYPbp>; Fri, 25 May 2001 11:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263771AbREYPbf>; Fri, 25 May 2001 11:31:35 -0400
Received: from twinlark.arctic.org ([204.107.140.52]:3341 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S263770AbREYPbZ>; Fri, 25 May 2001 11:31:25 -0400
Date: Fri, 25 May 2001 08:31:24 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: <linux-kernel@vger.kernel.org>
Subject: Re: [CHECKER] large stack variables (>=1K) in 2.4.4 and 2.4.4-ac8
In-Reply-To: <20010525081107.A733@whitehall1-5.seh.ox.ac.uk>
Message-ID: <Pine.LNX.4.33.0105250821210.30357-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

another possibility for a debugging mode for the kernel would be to hack
gcc to emit something like the following in the prologue of every function
(after the frame is allocated):

	movl %esp,%edx
	andl %edx,0x1fff
	cmpl %edx,sizeof(struct task)+512
	jbe stack_overflow

where stack_overflow is a no_return routine... the 512 is just some fudge
factor where if we get that low on the stack we probably want to know
about it (perhaps compile time tuneable).

-dean

