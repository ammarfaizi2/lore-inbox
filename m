Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267973AbRHBAR4>; Wed, 1 Aug 2001 20:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267988AbRHBARq>; Wed, 1 Aug 2001 20:17:46 -0400
Received: from wawura.off.connect.com.au ([202.21.9.2]:56043 "HELO
	wawura.off.connect.com.au") by vger.kernel.org with SMTP
	id <S267973AbRHBARk>; Wed, 1 Aug 2001 20:17:40 -0400
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.4 
In-Reply-To: Your message of "Wed, 01 Aug 2001 17:02:30 +0100."
             <20010801170230.B7053@redhat.com> 
Date: Thu, 02 Aug 2001 10:17:32 +1000
From: Andrew McNamara <andrewm@connect.com.au>
Message-Id: <20010802001732.4DED1BE95@wawura.off.connect.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Please quote chapter and verse --- my reading of SUS shows no such
>requirement.  
>
>fsync is required to force "all currently queued I/O operations
>associated with the file indicated by file descriptor fildes to the
>synchronised I/O completion state."  But as you should know, directory
>entries and files are NOT the same thing in Unix/SUS.  

But does fsync() have any meaning if it doesn't ensure the file is
visible within the filesystem? 

This all comes back to the fact that old UFS's made directory
operations syncronous, at a substantial cost in performance. Writing
the directory data wasn't necessary for them, because it was already
commited when the creat() call returned.

I can easily understand people's asthetic objection to having fsync
touch the directory object as well as the file, however what meaning
does fsync() have it it doesn't - under linux, it tells usermode "yes,
your object is committed, but it might be in lost+found next time you
want it", and with the syncronous UFS implementations, it tells
usermode "yes, your object is committed, you can find it where you left
it (unless the directory was corrupted)".

 ---
Andrew McNamara (System Architect)

connect.com.au Pty Ltd
Lvl 3, 213 Miller St, North Sydney, NSW 2060, Australia
Phone: +61 2 9409 2117, Fax: +61 2 9409 2111
