Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268651AbRGZSxJ>; Thu, 26 Jul 2001 14:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268652AbRGZSw7>; Thu, 26 Jul 2001 14:52:59 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:2571 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S268651AbRGZSwo>; Thu, 26 Jul 2001 14:52:44 -0400
Date: Thu, 26 Jul 2001 15:52:45 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Paul Larson <plars@austin.ibm.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Linux 2.4.7-ac1
In-Reply-To: <01072612421000.21482@plars.austin.ibm.com>
Message-ID: <Pine.LNX.4.33L.0107261546560.20326-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, 26 Jul 2001, Paul Larson wrote:

> make it up to 980 threads on my machine.  Saw this change in fork.c with
> 2.4.7-ac1:
>
> -       max_threads = mempages / (THREAD_SIZE/PAGE_SIZE) / 2;
> +       max_threads = mempages / (THREAD_SIZE/PAGE_SIZE) / 16;
>
> Any reason why this was done?

The old default was to allow up to HALF of the system's memory to
be allocated in task structs. Since each task will also want things
like page tables, mm_struct, vma's, etc. it was pretty easy to just
about KILL a system using nothing but a simple fork bomb, or some
other thing running out of hand.

The new default is to set the limit to something safe enough to
not run the system completely out of swappable memory. This should
protect the system in extreme situations.

If the system administrator wants more tasks in the system, (s)he
can always raise the limit in /proc/sys/kernel/threads-max

regards,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

