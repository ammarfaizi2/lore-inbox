Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129352AbQLGQkY>; Thu, 7 Dec 2000 11:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130887AbQLGQkO>; Thu, 7 Dec 2000 11:40:14 -0500
Received: from 212-140-94-250.btopenworld.com ([212.140.94.250]:40454 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S129352AbQLGQkF>;
	Thu, 7 Dec 2000 11:40:05 -0500
Date: Thu, 7 Dec 2000 16:11:41 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Szabolcs Szakacsits <szaka@f-secure.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Broken NR_RESERVED_FILES
In-Reply-To: <Pine.LNX.4.30.0012071758470.5455-100000@fs129-190.f-secure.com>
Message-ID: <Pine.LNX.4.21.0012071608550.970-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2000, Szabolcs Szakacsits wrote:
> Read the whole get_empty_filp function, especially this part, note the
> goto new_one below and the part you didn't include above [from
> the new_one label],
> 
>         if (files_stat.nr_files < files_stat.max_files) {
>                 file_list_unlock();
>                 f = kmem_cache_alloc(filp_cachep, SLAB_KERNEL);
>                 file_list_lock();
>                 if (f) {
>                         files_stat.nr_files++;
>                         goto new_one;
>                 }

I have read the whole function, including the above code, of course. The
new_one label has nothing to do with freelists -- it adds the file to the
anon_list, where the new arrivales from the slab cache go. The goto
new_one above is there simply to initialize the structure with sane
initial values

So, the normal user _cannot_ take a file structure from the freelist
unless it contains more than NR_RESERVED_FILE entries. Please read the
whole function and see it for yourself.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
