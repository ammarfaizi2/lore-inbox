Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129347AbQKQH6S>; Fri, 17 Nov 2000 02:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129591AbQKQH56>; Fri, 17 Nov 2000 02:57:58 -0500
Received: from [213.8.185.152] ([213.8.185.152]:34832 "EHLO callisto.yi.org")
	by vger.kernel.org with ESMTP id <S129347AbQKQH5s>;
	Fri, 17 Nov 2000 02:57:48 -0500
Date: Fri, 17 Nov 2000 09:26:54 +0200 (IST)
From: Dan Aloni <karrde@callisto.yi.org>
To: Jacob Luna Lundberg <jacob@velius.chaos2.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH (2.4)] atomic use count for proc_dir_entry
In-Reply-To: <Pine.LNX.4.21.0011162103040.10109-100000@velius.chaos2.org>
Message-ID: <Pine.LNX.4.21.0011170905030.19287-100000@callisto.yi.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2000, Jacob Luna Lundberg wrote:

> 
> I'm not (yet) a kernel guru, so just point and laugh if I'm wrong, but...
> 
> On Thu, 16 Nov 2000, Dan Aloni wrote:
> > -               if (!--de->count) {
> > +               if (atomic_dec_and_test(&de->count)) {
> 
> Doesn't this reverse the sense of the test?

If you are right, I guess put_files_struct() of kernel/exit.c would
have cleaned files_struct everytime someones called it. 
Everywhere in the kernel, objects are freed when
atomic_dec_and_test() returns true.

-- 
Dan Aloni 
dax@karrde.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
