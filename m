Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933183AbWFXC1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933183AbWFXC1O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 22:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933187AbWFXC1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 22:27:13 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:50303 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S933183AbWFXC1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 22:27:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=lvle+U8bTeJr775Sal2M3aE2mFWzVve/GVLL+a3H5WnNox04J11n95/7tkUhXvcPQ3ajQrvs12SFho60P0GloglZxb/660W4k46rBZmFklRu6OirbN0cnW9AEkJtTrXTxhET72uXbeX4QGApkkpbDiQl5rzAeaFJ/wirb5PU/Nk=
Message-ID: <787b0d920606231927j67eb42a6k865391c75dbfd086@mail.gmail.com>
Date: Fri, 23 Jun 2006 22:27:12 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: linux-kernel@vger.kernel.org, ltuikov@yahoo.com
Subject: Re: [PATCH] sched.h: increment TASK_COMM_LEN to 20 bytes
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luben Tuikov writes:

> Lets use 19+1 chars.  This helps display properly
> kernel threads (e.g. SATA translation threads) which bear
> the address of the STP/SATA bridge where the SATA disk is
> connected. Those are 16+1 chars long.  Currently (15+1) the
> last character is not displayed as it is used by the '\0'.

This makes apps crash when they do this:

char buf[16];
prctl(PR_GET_NAME, buf, 42, 42, 42);

Check the last 15 lines of kernel/sys.c to see why.

Though none of my code breaks, I have to wonder about what might
be out there. (my code truncates it)

I tend to think that putting 64 bits of hex in the command name
is an abuse of the command name. Perhaps it is time to make argv
work for built-in kernel tasks. It's also long past time to group
these things by tgid, reducing the horrible clutter seen on
large systems.

As for the size chosen...

Solaris uses 15. (plus 80 for unswappable argv)
Darwin uses 16. (was 10 I believe)
OpenBSD uses 16.
NetBSD uses 16.
We use 15. (you propose 19)
FreeBSD uses 19.
