Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278357AbRJMSm1>; Sat, 13 Oct 2001 14:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278353AbRJMSmR>; Sat, 13 Oct 2001 14:42:17 -0400
Received: from zero.aec.at ([195.3.98.22]:56594 "HELO zero.aec.at")
	by vger.kernel.org with SMTP id <S278355AbRJMSmE>;
	Sat, 13 Oct 2001 14:42:04 -0400
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org, lse-tech@sourceforge.net,
        Paul.McKenney@us.ibm.com, rusty@rustcorp.com.au
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists with insertion
In-Reply-To: <Pine.LNX.4.33.0110131015410.8707-100000@penguin.transmeta.com>
From: Andi Kleen <ak@muc.de>
Date: 13 Oct 2001 20:42:34 +0200
In-Reply-To: Linus Torvalds's message of "Sat, 13 Oct 2001 10:23:23 -0700 (PDT)"
Message-ID: <k23d4njs9x.fsf@zero.aec.at>
User-Agent: Gnus/5.0700000000000003 (Pterodactyl Gnus v0.83) Emacs/20.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0110131015410.8707-100000@penguin.transmeta.com>,
Linus Torvalds <torvalds@transmeta.com> writes:

>  - nobody has shown a case where existing normal locking ends up being
>    really a huge problem, and where RCU clearly helps.

The poster child of such a case is module unloading. Keeping reference
counts for every even non sleeping use of a module is very painful. 
The current "fix" -- putting module count increases in all possible module 
callers to fix the unload races is slow and ugly and far too subtle to 
get everything right. Waiting quiescent periods before unloading is a nice 
alternative.

-Andi
