Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271982AbRIWKFa>; Sun, 23 Sep 2001 06:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273361AbRIWKFV>; Sun, 23 Sep 2001 06:05:21 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:6411 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S271982AbRIWKFN>; Sun, 23 Sep 2001 06:05:13 -0400
Date: Sat, 22 Sep 2001 21:32:18 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Beau Kuiper <kuib-kl@ljbc.wa.edu.au>
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Significant performace improvements on reiserfs systems, kupdated bugfixes
Message-ID: <20010922213218.D31000@emma1.emma.line.org>
Mail-Followup-To: Beau Kuiper <kuib-kl@ljbc.wa.edu.au>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010921152627.C13862@emma1.emma.line.org> <Pine.LNX.4.30.0109230226210.25332-100000@gamma.student.ljbc>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0109230226210.25332-100000@gamma.student.ljbc>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Sep 2001, Beau Kuiper wrote:

> > Be careful! MTAs rely on this behaviour on fsync(). The official
> > consensus on ReiserFS and ext3 on current Linux 2.4.x kernels (x >= 9)
> > is that "any synchronous operation flushes all pending operations", and
> > if that is changed, you MUST make sure that the changed ReiserFS/ext3fs
> > still make all the guarantees that softupdated BSD file systems make,
> > lest you want people to run their mail queues off "sync" disks.
> 
> This code change does not affect the functionality of fsync(), only
> kupdated. kupdated is responsible for flushing buffers that have been
> sitting around too long to disk.

Sorry, I didn't grok that when writing my previous mail in this thread.
I thought kupdate was the one that writes ReiserFS transactions, but
that's kreiserfsd, I think.

> > Note also, if these blocks belong to newly-opened files, you definitely
> > want kupdated to flush these to disk on its next run so that the files
> > are still there after a crash.
> 
> They still are (they would be flushed out by the sync_inodes call in
> sync_old_buffers. But why are the file records for any new file more
> important than changes to old files? (This is what an application can
> determince, the kernel should just do what the app says, and treat
> everything else fairly)

Not really, but open is a directory operation, while writing is a file
operation. Directory operations have been flushed earlier traditionally
(5s vs. 30s).

-- 
Matthias Andree

"Those who give up essential liberties for temporary safety deserve
neither liberty nor safety." - Benjamin Franklin
