Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266938AbTBXMEi>; Mon, 24 Feb 2003 07:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266940AbTBXMEi>; Mon, 24 Feb 2003 07:04:38 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:46352 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S266938AbTBXMEf>; Mon, 24 Feb 2003 07:04:35 -0500
Date: Mon, 24 Feb 2003 13:14:27 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: "Kevin O'Connor" <kevin@koconnor.net>
cc: Werner Almesberger <wa@almesberger.net>,
       Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Is an alternative module interface needed/possible?
In-Reply-To: <20030223183433.A16972@arizona.localdomain>
Message-ID: <Pine.LNX.4.44.0302241241000.1336-100000@serv>
References: <20030217221837.Q2092@almesberger.net> <20030218050349.44B092C04E@lists.samba.org>
 <20030218042042.R2092@almesberger.net> <Pine.LNX.4.44.0302181252570.1336-100000@serv>
 <20030218111215.T2092@almesberger.net> <20030218142257.A10210@almesberger.net>
 <20030223183433.A16972@arizona.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 23 Feb 2003, Kevin O'Connor wrote:

> 8) Have the unregister code (remove_proc_entry) set an external flag (eg,
>    de->data_is_there), and update all users of de->data to check the flag
>    before following the pointer.
> 
> Option 8 may not qualify as "sane", but I think it is important to add it
> because it is what the module code is currently using.  Thus, one need not
> look at the module stuff as a "special case", but as a general (if
> complicated) resource management solution.

Yes, it's another possible solution, but it has the same problem as the 
current module locking - increased locking complexity.
Such flag actually exists already ("deleted"), but no user can use it 
currently, because the read/write functions don't have the proc entry 
argument. Even if they could use it, switching this flag isn't enough 
remove_proc_entry also had to synchronize with active users, so users had 
to take some lock just to read the data, where a simple reference was 
sufficient before.

bye, Roman

