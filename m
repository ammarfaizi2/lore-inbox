Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129783AbQJ0QcD>; Fri, 27 Oct 2000 12:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129821AbQJ0Qbx>; Fri, 27 Oct 2000 12:31:53 -0400
Received: from brutus.conectiva.com.br ([200.250.58.146]:53500 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129783AbQJ0Qbn>; Fri, 27 Oct 2000 12:31:43 -0400
Date: Fri, 27 Oct 2000 14:31:28 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Rui Sousa <rsousa@grad.physics.sunysb.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Blocked processes <=> Elevator starvation?
In-Reply-To: <Pine.LNX.4.21.0010271658500.1295-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0010271430330.25174-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2000, Rui Sousa wrote:

> I finally had time to give this a better look. It now seems the
> problem is in the VM system.

*sigh*

> schedule()
> ___wait_on_page()
> do_generic_file_read()
> generic_file_read()
> sys_read()
> system_call()
> 
> So it seems the process is either in a loop in ___wait_on_page()
> racing for the PageLock or it never wakes-up... (I guess I could
> add a printk to check which)

It is spinning in ___wait_on_page() because the page never
becomes available, because the IO doesn't get scheduled to
disk in time.

This appears to be an elevator problem, not a VM problem.

regards,

Rik
--
"What you're running that piece of shit Gnome?!?!"
       -- Miguel de Icaza, UKUUG 2000

http://www.conectiva.com/		http://www.surriel.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
